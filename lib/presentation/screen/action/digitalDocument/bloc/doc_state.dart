part of 'doc_bloc.dart';

@immutable
class DigitalDocumentState extends BaseState implements PagingState {
  final int documentId;
  @override
  final Paging paging;
  final List<DigitalDocumentUser> userList;
  final String? pdfUrl;

  final String searchKeyword;

  const DigitalDocumentState({
    required this.documentId,
    this.userList = const [],
    this.pdfUrl,
    bool isLoading = false,
    String? errorToastMessage,
    this.paging = const Paging(page: 1, size: apiLoadSize),
    this.searchKeyword = "",
  }) : super(isLoading: isLoading, errorToastMessage: errorToastMessage ?? '');

  DigitalDocumentState copyWith({
    bool? isLoading,
    String? errorToastMessage,
    List<DigitalDocumentUser>? userList,
    String? pdfUrl,
    String? searchKeyword,
    Paging? paging,
  }) {
    return DigitalDocumentState(
      documentId: documentId,
      userList: userList ?? this.userList,
      pdfUrl: pdfUrl ?? this.pdfUrl,
      isLoading: isLoading ?? this.isLoading,
      errorToastMessage: errorToastMessage ?? '',
      searchKeyword: searchKeyword ?? this.searchKeyword,
      paging: paging ?? this.paging,
    );
  }

  List<Post> parseUserData(String responseBody) {
    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Post>((json) => Post.fromJson(json)).toList();
  }

  @override
  List<Object?> get props => [
        documentId,
        isLoading,
        errorToastMessage,
        userList,
        pdfUrl,
        searchKeyword,
      ];

  get accumulateIndex => (paging.page - 1) * paging.size;
}
