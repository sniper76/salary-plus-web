part of 'bloc.dart';

@immutable
class DialogState extends BaseState {
  final ActionPostType type;
  final FileDownloadStatusType zipFileStatus;
  final DateTime? updatedDownloadData;
  final String? fileKey;

  const DialogState({
    this.type = ActionPostType.action,
    this.zipFileStatus = FileDownloadStatusType.unknown,
    this.fileKey,
    this.updatedDownloadData,
    bool isLoading = false,
    String? errorToastMessage,
  }) : super(isLoading: isLoading, errorToastMessage: errorToastMessage ?? '');

  DialogState copyWith(
      {String? fileKey,
      FileDownloadStatusType? zipFileStatus,
      ActionPostType? type,
      DateTime? updatedDownloadData,
      bool? isLoading,
      String? errorToastMessage}) {
    return DialogState(
      type: type ?? this.type,
      zipFileStatus: zipFileStatus ?? this.zipFileStatus,
      fileKey: fileKey ?? this.fileKey,
      updatedDownloadData: updatedDownloadData ?? this.updatedDownloadData,
      isLoading: isLoading ?? this.isLoading,
      errorToastMessage: errorToastMessage ?? '',
    );
  }

  @override
  List<Object?> get props => [type, isLoading, errorToastMessage, zipFileStatus, fileKey];
}
