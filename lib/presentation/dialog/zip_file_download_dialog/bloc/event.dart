part of 'bloc.dart';

@immutable
abstract class DialogEvent {
  const DialogEvent._();

  const factory DialogEvent.onInit({required LocalStorageZipFile zipFileData}) = OnInit;

  const factory DialogEvent.onPollingData() = OnPollingData;

  const factory DialogEvent.onComplete(String fileKey) = OnComplete;

  const factory DialogEvent.requestZipFile({
    required int id,
    required ActionPostType type,
    String? code,
    BoardGroupType? boardGroupType,
    String? fileKey,
  }) = OnRequestZipFile;
}

class OnInit extends DialogEvent {
  final LocalStorageZipFile zipFileData;

  const OnInit({required this.zipFileData}) : super._();
}

class OnPollingData extends DialogEvent {
  const OnPollingData() : super._();
}

class OnComplete extends DialogEvent {
  final String fileKey;

  const OnComplete(this.fileKey) : super._();
}

class OnRequestZipFile extends DialogEvent {
  final int id;
  final ActionPostType type;
  final String? code;
  final BoardGroupType? boardGroupType;
  final String? fileKey;

  const OnRequestZipFile({
    required this.id,
    required this.type,
    this.code,
    this.boardGroupType,
    this.fileKey,
  }) : super._();
}
