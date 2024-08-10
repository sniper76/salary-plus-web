import 'package:act_cms/domain/model/enum/period_check.dart';
import 'package:act_cms/domain/model/enum/post_search_type.dart';
import 'package:act_cms/domain/model/enum/post_status_type.dart';
import 'package:act_cms/domain/model/paging.dart';
import 'package:act_cms/domain/model/post.dart';
import 'package:act_cms/presentation/base/base_state.dart';
import 'package:act_cms/presentation/widget/act_data_grid.dart';
import 'package:act_cms/presentation/widget/act_pagination.dart';

class EventBoardListState extends BaseState implements PagingState {
  @override
  final Paging paging;
  final bool refreshPage;
  final String searchKeyword;
  final List<Post> eventBoardList;
  final BoardSearchType selectedSearchType;
  final PostStatusType selectedPostStatusType;
  final PeriodCheckStatus selectedPeriodCheckStatus;
  final List<BoardSearchType> eventBoardSearchCategoires;
  final DateTime? selectedSearchStartDate;
  final DateTime? selectedSearchEndDate;

  const EventBoardListState({
    bool isLoading = false,
    String? errorToastMessage,
    this.paging = const Paging(page: 1, size: apiLoadSize),
    this.refreshPage = false,
    this.searchKeyword = '',
    this.eventBoardList = const [],
    this.selectedSearchType = BoardSearchType.title,
    this.selectedPostStatusType = PostStatusType.all,
    this.selectedPeriodCheckStatus = PeriodCheckStatus.all,
    this.eventBoardSearchCategoires = const [
      BoardSearchType.title,
      BoardSearchType.content,
      BoardSearchType.titleAndContent
    ],
    this.selectedSearchEndDate,
    this.selectedSearchStartDate,
  }) : super(isLoading: isLoading, errorToastMessage: errorToastMessage ?? '');

  get stopWordList => null;

  EventBoardListState copyWith({
    bool? isLoading,
    bool? refreshPage,
    String? searchKeyword,
    String? errorToastMessage,
    Paging? paging,
    List<Post>? eventBoardList,
    BoardSearchType? selectedSearchType,
    PostStatusType? selectedPostStatusType,
    PeriodCheckStatus? selectedPeriodCheckStatus,
    DateTime? selectedSearchStartDate,
    DateTime? selectedSearchEndDate,
  }) {
    return EventBoardListState(
      isLoading: isLoading ?? this.isLoading,
      errorToastMessage: errorToastMessage ?? '',
      paging: paging ?? this.paging,
      searchKeyword: searchKeyword ?? this.searchKeyword,
      refreshPage: refreshPage ?? this.refreshPage,
      eventBoardList: eventBoardList ?? this.eventBoardList,
      selectedSearchType: selectedSearchType ?? this.selectedSearchType,
      selectedPostStatusType: selectedPostStatusType ?? this.selectedPostStatusType,
      selectedPeriodCheckStatus: selectedPeriodCheckStatus ?? this.selectedPeriodCheckStatus,
      selectedSearchStartDate: selectedSearchStartDate ?? this.selectedSearchStartDate,
      selectedSearchEndDate: selectedSearchEndDate ?? this.selectedSearchEndDate,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        refreshPage,
        searchKeyword,
        errorToastMessage,
        paging,
        eventBoardList,
        selectedSearchType,
        selectedPostStatusType,
        selectedPeriodCheckStatus,
        selectedSearchStartDate,
        selectedSearchEndDate,
      ];
}
