part of 'bloc.dart';

@immutable
abstract class MainEvent {
  const MainEvent._();

  const factory MainEvent.initial() = OnInitial;

  const factory MainEvent.onLogout() = OnLogout;

  const factory MainEvent.onDownloadFile(String fileKey) = OnDownloadFile;

  const factory MainEvent.onAddZipFileDownloadList(String fileKey) = OnAddZipFileDownloadList;
}

class OnInitial extends MainEvent {
  const OnInitial() : super._();
}

class OnLogout extends MainEvent {
  const OnLogout() : super._();
}

class OnDownloadFile extends MainEvent {
  final String fileKey;

  const OnDownloadFile(this.fileKey) : super._();
}

class OnAddZipFileDownloadList extends MainEvent {
  final String fileKey;

  const OnAddZipFileDownloadList(this.fileKey) : super._();
}
