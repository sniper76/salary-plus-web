part of 'bloc.dart';

@immutable
class PostState extends BaseState {
  final ReportDetail? reportDetail;

  final String reason;

  const PostState({
    bool isLoading = false,
    String? errorToastMessage,
    this.reportDetail,
    this.reason = "",
  }) : super(isLoading: isLoading, errorToastMessage: errorToastMessage ?? '');

  PostState copyWith({
    bool? isLoading,
    String? errorToastMessage,
    Post? reportPost,
    ReportDetail? reportDetail,
    String? reason,
    Comment? comment,
    Comment? reply,
  }) {
    return PostState(
      isLoading: isLoading ?? this.isLoading,
      errorToastMessage: errorToastMessage ?? this.errorToastMessage,
      reportDetail: reportDetail ?? this.reportDetail,
      reason: reason ?? this.reason,
    );
  }

  List<Post> parseUserData(String responseBody) {
    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Post>((json) => Post.fromJson(json)).toList();
  }

  @override
  List<Object?> get props => [
        isLoading,
        errorToastMessage,
        reportDetail,
        reason,
      ];
}
