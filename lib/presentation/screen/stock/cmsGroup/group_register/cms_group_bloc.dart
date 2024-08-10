import 'dart:async';
import 'dart:convert';

import 'package:act_cms/config/app_event.dart';
import 'package:act_cms/core/extension/string_extension.dart';
import 'package:act_cms/core/injection.dart';
import 'package:act_cms/core/service/cms_commons_service.dart';
import 'package:act_cms/domain/model/simple_stock.dart';
import 'package:act_cms/domain/model/simple_stock_group.dart';
import 'package:act_cms/domain/model/stock_group.dart';
import 'package:act_cms/domain/model/user.dart';
import 'package:act_cms/domain/usecase/admin_cms/get_cms_commons.dart';
import 'package:act_cms/domain/usecase/admin_stock/create_stock_group.dart';
import 'package:act_cms/domain/usecase/admin_stock/delete_stock_group.dart' as delete_use_case;
import 'package:act_cms/domain/usecase/admin_stock/get_stock_group_detail.dart';
import 'package:act_cms/domain/usecase/admin_stock/update_stock_group_detail.dart';
import 'package:act_cms/presentation/base/base_state.dart';
import 'package:bloc/bloc.dart';
import 'package:event_bus_plus/event_bus_plus.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';

part 'cms_group_event.dart';
part 'cms_group_state.dart';

class CmsStockGroupBloc extends Bloc<CmsStockGroupEvent, CmsStockGroupState> {
  final _cmsCommonsData = getIt<CMSCommonsService>();
  final _createStockGroup = getIt<CreateStockGroup>();
  final _updateStockGroup = getIt<UpdateStockGroupDetail>();
  final _getStockGroupDetail = getIt<GetStockGroupDetail>();
  final _deleteStockGroup = getIt<delete_use_case.DeleteStockGroup>();
  final _cmsCommons = getIt<GetCMSCommons>();
  final _eventBus = getIt<IEventBus>();

  CmsStockGroupBloc() : super(const CmsStockGroupState()) {
    on<CmsStockGroupOnInit>((event, emit) async {
      emit(state.copyWith(
        isLoading: event.id == null ? false : true,
        isCreateMode: event.id == null ? true : false,
      ));
      if (event.id != null) {
        final res = await _getStockGroupDetail(stockGroupId: event.id);

        if (res.isSuccess()) {
          final groupStockData = res.tryGetSuccess();
          final stockSet = groupStockData?.stocks.toSet();

          emit(state.copyWith(
            isLoading: false,
            groupName: groupStockData?.name,
            groupDescription: groupStockData?.description,
            candidateStockList: stockSet,
            isEditable: false,
          ));
        } else {
          emit(state.copyWith(
            isLoading: false,
            errorToastMessage: res.tryGetError().toString(),
            isEditable: false,
          ));
        }
      }
    });

    on<StockGroupEnableEditable>((event, emit) async {
      emit(state.copyWith(isEditable: event.isEditable));
    });

    on<SearchStockGroupKeword>((event, emit) async {
      final keyword = event.keyword.toLowerCase();
      final cadidateList = _cmsCommonsData.cmsCommons?.stockGroups
          .where((stock) => stock.name.toLowerCase().contains(keyword))
          .map((data) => SimpleStockGroup(id: data.id, name: data.name))
          .toList();
      emit(state.copyWith(matchedStockGroupList: cadidateList));
    });

    on<SearchStocksByCodeList>((event, emit) async {
      final stocks = _cmsCommonsData.cmsCommons?.stocks ?? [];

      if (stocks.isEmpty) {
        emit(state.copyWith(matchedBatchStockList: [], nonMatchedBatchStockList: []));
        return;
      }

      final reg = RegExp(r',\s*|\s');
      final Map<String, SimpleStock> stocksMap = {for (var item in stocks) item.code: item};
      List<String> allItems =
          event.codeList.convertToArray(regExp: reg).map((item) => item.trim().padLeft(6, '0')).toList();
      List<SimpleStock>? matchedItems = [];
      List<String>? nonMatchedItems = [];

      for (var code in allItems) {
        final stock = stocksMap[code];
        if (stock != null) {
          matchedItems.add(stock);
        } else {
          nonMatchedItems.add(code);
        }
      }

      emit(state.copyWith(matchedBatchStockList: matchedItems, nonMatchedBatchStockList: nonMatchedItems));
    });

    on<SearchStockByKeyword>((event, emit) async {
      if (event.keyword == "") {
        emit(state.copyWith(matchedStockList: []));
      } else {
        // 검색 키워드를 소문자로 변환
        final keywordLower = event.keyword.toLowerCase();

        final stockList = _cmsCommonsData.cmsCommons?.stocks
            .where((stock) => stock.name.toLowerCase().contains(keywordLower))
            .map((data) => SimpleStock(code: data.code, name: data.name))
            .toList();

        emit(state.copyWith(matchedStockList: stockList));
      }
    });

    on<DeleteNonMatchBatchStock>((event, emit) async {
      final nonMatchedBatchStockList = state.nonMatchedBatchStockList.where((item) => item != event.stock).toList();
      emit(state.copyWith(nonMatchedBatchStockList: nonMatchedBatchStockList));
    });

    on<DeleteMatchBatchStock>((event, emit) async {
      final matchedBatchStockList = state.matchedBatchStockList.where((item) => item.code != event.stock.code).toList();
      emit(state.copyWith(matchedBatchStockList: matchedBatchStockList));
    });

    on<SetStockGroupName>((event, emit) async {
      emit(state.copyWith(groupName: event.name));
    });

    on<AddStock>((event, emit) async {
      final newSet = Set<SimpleStock>.from(state.candidateStockList);
      newSet.add(event.stock);
      emit(state.copyWith(candidateStockList: newSet));
    });

    on<AddStockByBatch>((event, emit) async {
      final newSet = Set<SimpleStock>.from(state.candidateStockList);
      newSet.addAll(event.stockList);
      emit(state.copyWith(candidateStockList: newSet));
    });

    on<DeleteStock>((event, emit) async {
      final newSet = Set<SimpleStock>.from(state.candidateStockList);
      newSet.remove(event.stock);
      emit(state.copyWith(candidateStockList: newSet));
    });

    on<DeleteStockGroup>((event, emit) async {
      emit(state.copyWith(isLoading: true));

      final res = await _deleteStockGroup(stockGroupId: event.stockGroupId);
      if (res.isSuccess()) {
        _eventBus.fire(StockGroupChangeEvent(event.stockGroupId));
        _cmsCommonsData.deleteStockGroup(event.stockGroupId);
      }

      emit(state.copyWith(isLoading: false, errorToastMessage: res.isError() ? res.tryGetError().toString() : null));
    });

    on<RegisterStockGroup>((event, emit) async {
      if (state.isCreateMode) {
        emit(state.copyWith(isLoading: true));
        final res = await _createStockGroup(
            name: state.groupName!,
            description: state.groupDescription,
            stockCodes: state.candidateStockList.map((item) => item.code).toList());
        await _cmsCommons();
        if (res.isSuccess()) {
          final newGroup = res.tryGetSuccess();
          // print("userList Fetch test (FetchAction) : ${users!.data![0].email}");
          emit(state.copyWith(
            isLoading: false,
            newStockGroup: newGroup,
            isEditable: false,
            isCreateMode: false,
          ));
        } else {
          emit(state.copyWith(isLoading: false, errorToastMessage: res.tryGetError().toString()));
        }
      } else {
        emit(state.copyWith(isLoading: true));
        final res = await _updateStockGroup(
            stockGroupId: state.newStockGroup!.id,
            name: state.groupName!,
            description: state.groupDescription ?? "",
            stockCodes: state.candidateStockList.map((item) => item.code).toList());
        await _cmsCommons();
        if (res.isSuccess()) {
          final newGroup = res.tryGetSuccess();
          // print("userList Fetch test (FetchAction) : ${users!.data![0].email}");
          emit(state.copyWith(
            isLoading: false,
            newStockGroup: newGroup,
            isEditable: false,
            isCreateMode: false,
          ));
        } else {
          emit(state.copyWith(isLoading: false, errorToastMessage: res.tryGetError().toString()));
        }
      }
    });

    on<SetStockGroupDescription>((event, emit) {
      emit(state.copyWith(groupDescription: event.description));
    });
  }

  FutureOr<void> onCmsStockGroupOnInit(event, emit) async {}
}
