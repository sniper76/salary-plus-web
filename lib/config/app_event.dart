import 'package:act_cms/domain/model/accept_user.dart';
import 'package:event_bus_plus/event_bus_plus.dart';

class MyDataChangedEvent extends AppEvent {
  const MyDataChangedEvent();

  @override
  List<Object?> get props => [];
}

class StockMainTabChangedEvent extends AppEvent {
  final String tabName;
  final String path;
  final String? queryString;

  const StockMainTabChangedEvent({required this.tabName, required this.path, this.queryString});

  @override
  List<Object?> get props => [tabName, path, queryString];
}

class PostChangedEvent extends AppEvent {
  @override
  List<Object?> get props => [];
}

class PageChangedEvent extends AppEvent {
  @override
  List<Object?> get props => [];
}

class OpenZipFileToastMessageEvent extends AppEvent {
  final String fileKey;

  const OpenZipFileToastMessageEvent({required this.fileKey});

  @override
  List<Object?> get props => [fileKey];
}

class LoadingZipFileEvent extends AppEvent {
  final String fileKey;

  const LoadingZipFileEvent({required this.fileKey});

  @override
  List<Object?> get props => [fileKey];
}

class PostCommentChangedEvent extends AppEvent {
  final int id;
  final bool isActive;
  final String content;

  const PostCommentChangedEvent({required this.id, required this.isActive, required this.content});

  @override
  List<Object?> get props => [id, isActive, content];
}

class PostItemChangedEvent extends AppEvent {
  final int id;
  final String stockCode;

  const PostItemChangedEvent(this.id, this.stockCode);

  @override
  List<Object?> get props => [id];
}

class UserChangedEvent extends AppEvent {
  const UserChangedEvent();

  @override
  List<Object?> get props => [];
}

class DigitalDocumentChangedEvent extends AppEvent {
  const DigitalDocumentChangedEvent();

  @override
  List<Object?> get props => [];
}

class CampaignChangedEvent extends AppEvent {
  @override
  List<Object?> get props => [];
}

class CorporationUserDetailChangedEvent extends AppEvent {
  final String corporationName;
  final String corporationNo;

  const CorporationUserDetailChangedEvent({required this.corporationName, required this.corporationNo});

  @override
  List<Object?> get props => [corporationName, corporationNo];
}

class StockGroupChangeEvent extends AppEvent {
  final int stockGroupId;

  const StockGroupChangeEvent(this.stockGroupId);

  @override
  List<Object?> get props => [stockGroupId];
}

class AcceptUserChangeEvent extends AppEvent {
  final AcceptUser acceptUser;

  const AcceptUserChangeEvent(this.acceptUser);

  @override
  List<Object?> get props => [acceptUser];
}
