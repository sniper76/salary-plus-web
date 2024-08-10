part of 'report_comment_bloc.dart';

@immutable
class ReportCommentState extends BaseState implements PagingState {
  @override
  final Paging paging;
  final int paginatorIndex;
  final List<ReportList> reportList;
  final ReportStatusType reportStatus;
  final bool isChangingStatus;
  final bool refreshPage;

  const ReportCommentState({
    this.reportList = const [],
    bool isLoading = false,
    String? errorToastMessage,
    this.paging = const Paging(page: 1, size: apiLoadSize),
    this.paginatorIndex = 0,
    this.reportStatus = ReportStatusType.all,
    this.isChangingStatus = false,
    this.refreshPage = false,
  }) : super(isLoading: isLoading, errorToastMessage: errorToastMessage ?? '');

  ReportCommentState copyWith({
    bool? isLoading,
    String? errorToastMessage,
    List<ReportList>? reportList,
    ReportStatusType? reportStatus,
    Paging? paging,
    int? paginatorIndex,
    bool? isChangingStatus,
    bool? refreshPage,
  }) {
    return ReportCommentState(
      reportList: reportList ?? this.reportList,
      isLoading: isLoading ?? this.isLoading,
      errorToastMessage: errorToastMessage ?? '',
      reportStatus: reportStatus ?? this.reportStatus,
      paging: paging ?? this.paging,
      paginatorIndex: paginatorIndex ?? this.paginatorIndex,
      isChangingStatus: isChangingStatus ?? this.isChangingStatus,
      refreshPage: refreshPage ?? this.refreshPage,
    );
  }

  List<ReportList> parseUserData(String responseBody) {
    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<ReportList>((json) => ReportList.fromJson(json)).toList();
  }

  @override
  List<Object?> get props => [
        isLoading,
        errorToastMessage,
        reportList,
        reportStatus,
        paging,
        paginatorIndex,
        isChangingStatus,
        refreshPage,
      ];

  get accumulateIndex => (paging.page - 1) * paging.size;
}
