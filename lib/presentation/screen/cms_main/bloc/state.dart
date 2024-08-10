part of 'bloc.dart';

@immutable
class MainState extends BaseState {
  final List<String> zipFileDownloadList;
  final User? userMe;

  const MainState({
    this.zipFileDownloadList = const [],
    this.userMe,
    bool isLoading = false,
    String? errorToastMessage,
  }) : super(isLoading: isLoading, errorToastMessage: errorToastMessage ?? '');

  MainState copyWith({User? userMe, bool? isLoading, List<String>? zipFileDownloadList}) {
    return MainState(
      zipFileDownloadList: zipFileDownloadList ?? this.zipFileDownloadList,
      isLoading: isLoading ?? this.isLoading,
      errorToastMessage: errorToastMessage,
      userMe: userMe ?? this.userMe,
    );
  }

  @override
  List<Object?> get props => [isLoading, errorToastMessage, zipFileDownloadList];
}
