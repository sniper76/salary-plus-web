import 'dart:async';
import 'dart:convert';

import 'package:act_cms/config/app_event.dart';
import 'package:act_cms/core/injection.dart';
import 'package:act_cms/domain/model/accept_user.dart';
import 'package:act_cms/domain/model/corporation_user.dart';
import 'package:act_cms/domain/model/digital_document_accept_user.dart';
import 'package:act_cms/domain/model/paging.dart';
import 'package:act_cms/domain/model/simple_stock.dart';
import 'package:act_cms/domain/model/stock_detail.dart';
import 'package:act_cms/domain/model/user.dart';
import 'package:act_cms/domain/usecase/admin_acceptor/fire_accept_user.dart';
import 'package:act_cms/domain/usecase/admin_solidarity/delete_solidarity_leader.dart';
import 'package:act_cms/domain/usecase/admin_solidarity/withdraw_solidarity_leader_applicant.dart';
import 'package:act_cms/domain/usecase/admin_solidarity/set_solidarity_corporation_leader.dart';
import 'package:act_cms/domain/usecase/admin_solidarity/set_solidarity_leader.dart';
import 'package:act_cms/domain/usecase/admin_solidarity/update_solidarity_leader_comment.dart';
import 'package:act_cms/domain/usecase/admin_stock/download_stocks_csv.dart';
import 'package:act_cms/domain/usecase/admin_stock/get_stock_detail.dart';
import 'package:act_cms/domain/usecase/admin_users/get_corporations.dart';
import 'package:act_cms/presentation/base/base_state.dart';
import 'package:act_cms/presentation/widget/act_data_grid.dart';
import 'package:bloc/bloc.dart';
import 'package:event_bus_plus/event_bus_plus.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';

part 'event.dart';
part 'state.dart';

class CmsBloc extends Bloc<CmsEvent, CmsState> {
  final _eventBus = getIt<IEventBus>();
  final _getDetail = getIt<GetStockDetail>();
  final _getCorporations = getIt<GetCorporations>();
  final _updateSolidarityLeaderComment = getIt<UpdateSolidarityLeaderComment>();
  final _setSolidarlityLeader = getIt<SetSolidarlityLeader>();
  final _withdrawSolidarlityLeaderApplicant = getIt<WithdrawSolidarlityLeaderApplicant>();
  final _setSolidarityCorporationLeader = getIt<SetSolidarityCorporationLeader>();
  final _deleteSolidarityLeader = getIt<DeleteSolidarityLeader>();
  final _downloadUserList = getIt<DownloadStocksCSV>();
  final _fireAcceptUser = getIt<FireAcceptUser>();
  late StreamSubscription _acceptUserChangeEventSubscription;

  CmsBloc() : super(const CmsState()) {
    _acceptUserChangeEventSubscription = _eventBus.on<AcceptUserChangeEvent>().listen((e) {
      add(CmsEvent.onAcceptUser(e.acceptUser));
    });

    on<CmsOnInit>((event, emit) async {
      emit(state.copyWith(isLoading: true));
      final res = await _getDetail(code: event.stock.code);
      if (res.isSuccess()) {
        final result = res.tryGetSuccess();
        if (result?.solidarityLeader != null) {
          emit(state.copyWith(
              isLoading: false, stockInfo: result, isLeaderSeleted: true, acceptUser: result?.acceptUser));
        } else {
          emit(state.copyWith(
              isLoading: false, stockInfo: result, isLeaderSeleted: false, acceptUser: result?.acceptUser));
        }
      } else {
        emit(state.copyWith(isLoading: false, errorToastMessage: res.tryGetError().toString()));
      }
    });

    on<CmsOnSetLeaderComment>((event, emit) async {
      // emit(state.copyWith(isLoading: true));
      try {
        final res = await _updateSolidarityLeaderComment(
            solidarityId: state.stockInfo!.solidarityLeader!.solidarityId, message: event.comment);
        if (res.isSuccess()) {
          emit(state.copyWith(
            isLoading: false,
            toast: "주주한마디가 변경되었습니다.",
          ));
        } else {
          emit(state.copyWith(isLoading: false, errorToastMessage: res.tryGetError().toString()));
        }
      } catch (e) {
        emit(state.copyWith(isLoading: false, errorToastMessage: "리더선정 에러 : $e"));
      }
      // print("userTest result, $res");
    });

    on<CmsOnClearToastMsg>((event, emit) async {
      emit(state.copyWith(
        toast: "",
      ));
    });

    on<CmsOnSetLeader>((event, emit) async {
      emit(state.copyWith(isLoading: true));
      final res = await _setSolidarlityLeader(
          solidarityId: event.solidarityId, solidarityApplicantId: event.solidarityApplicantId);
      if (res.isSuccess()) {
        emit(state.copyWith(isLoading: false));

        add(CmsEvent.init(SimpleStock(
          code: state.stockInfo!.solidarity!.code,
          name: state.stockInfo!.solidarity!.name,
        )));
      } else {
        final err = res.tryGetError();
        emit(state.copyWith(isLoading: false, errorToastMessage: err.toString()));
      }
    });

    on<CmsOnDeleteLeader>((event, emit) async {
      emit(state.copyWith(isLoading: true));
      final res = await _deleteSolidarityLeader(
        solidarityId: state.stockInfo!.solidarity!.id,
        solidarityLeaderId: state.stockInfo!.solidarityLeader!.solidarityLeaderId,
      );

      if (res.isSuccess()) {
        add(CmsEvent.init(SimpleStock(
          code: state.stockInfo!.solidarity!.code,
          name: state.stockInfo!.solidarity!.name,
        )));
      }

      emit(state.copyWith(isLoading: false, errorToastMessage: res.isError() ? res.tryGetError().toString() : null));
    });

    on<CmsOnSetCorporationLeader>((event, emit) async {
      if (state.selectedCorporation == null) return;
      emit(state.copyWith(isLoading: true));

      final res =
          await _setSolidarityCorporationLeader(solidarityId: state.stockInfo!.solidarity!.id, userId: event.userId);
      if (res.isSuccess()) {
        add(CmsEvent.init(
            SimpleStock(code: state.stockInfo!.solidarity!.code, name: state.stockInfo!.solidarity!.name)));
      }
      emit(state.copyWith(isLoading: false, errorToastMessage: res.isError() ? res.tryGetError().toString() : null));
    });

    on<CmsOnCancelLeaderCandidate>((event, emit) async {
      emit(state.copyWith(isLoading: true));
      final res = await _withdrawSolidarlityLeaderApplicant(
        stockCode: state.stockInfo!.solidarity!.code,
        solidarityApplicantId: event.solidarityApplicantId,
        reason: event.cancelReason,
      );
      if (res.isSuccess()) {
        emit(state.copyWith(isLoading: false));

        add(CmsEvent.init(SimpleStock(
          code: state.stockInfo!.solidarity!.code,
          name: state.stockInfo!.solidarity!.name,
        )));
      } else {
        emit(state.copyWith(
          isLoading: false,
          errorToastMessage: res.tryGetError().toString(),
        ));
      }
    });

    on<CmsOnSelectCorporation>((event, emit) {
      emit(state.copyWith(selectedCorporation: event.corporation));
    });

    on<CmsOnGetCorporationList>((event, emit) async {
      emit(state.copyWith(isLoading: true));

      final acceptanceList = await _getCorporations(
        searchKeyword: event.searchKeyword ?? '',
        page: event.page ?? 1,
        size: apiLoadSize,
      );

      emit(state.copyWith(
        isLoading: false,
        corporations: acceptanceList.isSuccess() ? acceptanceList.tryGetSuccess()?.data ?? [] : null,
        errorToastMessage: acceptanceList.tryGetError()?.toString(),
        paging: acceptanceList.isSuccess() ? acceptanceList.tryGetSuccess()?.paging : null,
      ));
    });

    on<CmsOnDownloadUserList>((event, emit) async {
      emit(state.copyWith(isLoading: true));
      final res = await _downloadUserList(stockCode: event.stockCode);

      emit(state.copyWith(
        isLoading: false,
        errorToastMessage: res.isError() ? res.tryGetError()?.toString() : null,
      ));
    });

    on<CmsOnAcceptUser>((event, emit) {
      final acceptUser = event.acceptUser;
      emit(
        state.copyWith(
          acceptUser: DigitalDocumentAcceptUser(
            id: acceptUser.userId,
            name: acceptUser.name,
            phoneNumber: acceptUser.uniqueNumber,
            birthDate: DateTime.now(),
          ),
        ),
      );
    });

    on<CmsOnFireAcceptUser>((event, emit) async {
      emit(state.copyWith(isLoading: true));
      final res = await _fireAcceptUser(userId: event.userId, code: event.stockCode);

      emit(state.copyWith(
        isLoading: false,
        clearAcceptUser: res.isSuccess(),
        errorToastMessage: res.isError() ? res.tryGetError().toString() : null,
      ));
    });

    @override
    Future<void> close() {
      _acceptUserChangeEventSubscription.cancel();
      return super.close();
    }
  }
}
