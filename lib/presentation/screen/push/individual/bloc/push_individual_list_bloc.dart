import 'package:act_cms/core/injection.dart';
import 'package:act_cms/domain/model/enum/board_sort_type.dart';
import 'package:act_cms/domain/model/enum/push/push_search_type.dart';
import 'package:act_cms/domain/model/individual_push.dart';
import 'package:act_cms/domain/model/paging.dart';
import 'package:act_cms/domain/usecase/admin_push/find_individual_push.dart';
import 'package:act_cms/presentation/base/base_state.dart';
import 'package:act_cms/presentation/widget/act_data_grid.dart';
import 'package:act_cms/presentation/widget/act_pagination.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'push_individual_list_event.dart';
part 'push_individual_list_state.dart';

class PushIndividualListBloc extends Bloc<PushIndividualListEvent, PushIndividualListState> {
  final _findPushes = getIt<FindIndividualPush>();

  PushIndividualListBloc() : super(const PushIndividualListState()) {
    on<PushIndividualListOnInit>(onInit);

    on<PushIndividualListOnSetSearchType>(onSetSearchType);
    on<PushIndividualListOnGetList>(onGetPushList);
  }

  void onInit(event, emit) {
    add(const PushIndividualListEvent.getPushList());
  }

  void onSetSearchType(PushIndividualListOnSetSearchType event, emit) {
    emit(state.copyWith(searchType: event.searchType));
  }

  void onGetPushList(PushIndividualListOnGetList event, emit) async {
    emit(state.copyWith(isLoading: true));
    final pushList = await _findPushes(
      searchType: event.searchType ?? state.searchType,
      searchKeyword: event.searchKeyword ?? '',
      page: event.page ?? 1,
      size: apiLoadSize,
    );
    emit(state.copyWith(
      isLoading: false,
      pushes: pushList.isSuccess() ? pushList.tryGetSuccess()?.data ?? [] : null,
      errorToastMessage: pushList.tryGetError()?.toString(),
      paging: pushList.isSuccess() ? pushList.tryGetSuccess()?.paging : null,
    ));
  }
}
