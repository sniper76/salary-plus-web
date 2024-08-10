import 'package:act_cms/core/injection.dart';
import 'package:act_cms/domain/model/board_group_category.dart';
import 'package:act_cms/domain/model/enum/board_group_type.dart';
import 'package:act_cms/domain/model/enum/period_check.dart';
import 'package:act_cms/domain/usecase/admin_post/find_posts.dart';
import 'package:act_cms/presentation/screen/event_board/widget/list/bloc/event.dart';
import 'package:act_cms/presentation/screen/event_board/widget/list/bloc/state.dart';
import 'package:act_cms/presentation/widget/act_data_grid.dart';
import 'package:bloc/bloc.dart';

class EventBoardListBloc extends Bloc<EventBoardListEvent, EventBoardListState> {
  final BoardGroupCategory boardGroupCategory;
  final _getPosts = getIt<FindPosts>();

  EventBoardListBloc({required this.boardGroupCategory}) : super(const EventBoardListState()) {
    on<OnInit>(
      (event, emit) async {
        try {
          await onGetEvents(const OnGetEventsOrCampaigns(), emit);
        } catch (e) {
          emit(state.copyWith(
            isLoading: false,
            errorToastMessage: e.toString(),
          ));
        }
      },
    );

    on<OnRefresh>(
      (event, emit) async {
        try {
          await onGetEvents(
            OnGetEventsOrCampaigns(page: state.paging.page),
            emit,
          );
        } catch (e) {
          emit(state.copyWith(
            isLoading: false,
            errorToastMessage: e.toString(),
          ));
        }
      },
    );

    on<OnSelectSearchType>(
      (event, emit) async {
        if (state.selectedSearchType == event.newSearchType) return;

        emit(state.copyWith(
          searchKeyword: '',
          selectedSearchType: event.newSearchType,
        ));
      },
    );

    on<OnSearch>(
      (event, emit) async {
        await onGetEvents(
          OnGetEventsOrCampaigns(searchKeyword: event.searchKeyword),
          emit,
        );
      },
    );

    on<OnSelectPeriodCheck>(
      (event, emit) async {
        if (state.selectedPeriodCheckStatus == event.newPeriodCheckStatus) return;
        final bool needResetSearchDates = event.newPeriodCheckStatus == PeriodCheckStatus.all;
        emit(state.copyWith(
          selectedPeriodCheckStatus: event.newPeriodCheckStatus,
          selectedSearchStartDate: needResetSearchDates ? null : state.selectedSearchStartDate,
          selectedSearchEndDate: needResetSearchDates ? null : state.selectedSearchEndDate,
        ));
      },
    );

    on<OnSelectPostStatusType>(
      (event, emit) async {
        if (state.selectedPostStatusType == event.newPostStatusType) return;
        emit(state.copyWith(selectedPostStatusType: event.newPostStatusType));
      },
    );

    on<OnSelectSearchStartDate>(
      (event, emit) async {
        if (state.selectedSearchStartDate == event.newSearchStartDate) return;
        emit(state.copyWith(selectedSearchStartDate: event.newSearchStartDate));
      },
    );

    on<OnSelectSearchEndDate>(
      (event, emit) async {
        if (state.selectedSearchEndDate == event.newSearchEndDate) return;
        emit(state.copyWith(selectedSearchEndDate: event.newSearchEndDate));
      },
    );

    on<OnLoadMore>(
      (event, emit) async {
        if (state.paging.page == event.page) return;

        await onGetEvents(
          OnGetEventsOrCampaigns(page: event.page),
          emit,
        );
      },
    );
  }

  Future<void> onGetEvents(OnGetEventsOrCampaigns event, Emitter<EventBoardListState> emit) async {
    emit(state.copyWith(isLoading: true));

    final res = await _getPosts(
      boardGroup: BoardGroupType.globalevent,
      boardCategory: boardGroupCategory,
      searchType: event.searchType ?? state.selectedSearchType,
      searchKeyword: event.searchKeyword ?? state.searchKeyword,
      page: event.page ?? 1,
      size: apiLoadSize,
      sort: null,
      status: event.status ?? state.selectedPostStatusType,
      searchStartDate: event.searchStartDate ?? state.selectedSearchStartDate,
      searchEndDate: event.searchEndDate ?? state.selectedSearchEndDate,
    );

    if (res.isSuccess()) {
      final successData = res.tryGetSuccess();

      emit(state.copyWith(
        isLoading: false,
        eventBoardList: successData?.data,
        selectedSearchType: event.searchType ?? state.selectedSearchType,
        searchKeyword: event.searchKeyword ?? state.searchKeyword,
        paging: successData?.paging,
        selectedPostStatusType: event.status ?? state.selectedPostStatusType,
        selectedSearchStartDate: event.searchStartDate ?? state.selectedSearchStartDate,
        selectedSearchEndDate: event.searchEndDate ?? state.selectedSearchEndDate,
      ));
    } else {
      emit(state.copyWith(
        isLoading: false,
        errorToastMessage: res.tryGetError().toString(),
      ));
    }
  }
}
