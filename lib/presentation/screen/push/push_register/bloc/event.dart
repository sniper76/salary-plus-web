part of 'bloc.dart';

@immutable
abstract class PushEvent {
  const PushEvent._();

  const factory PushEvent.setSearchType(PushTargetType searchType) = PushOnSetTargetSearchType;

  const factory PushEvent.searchKeyword(String searchKeyword) = PushOnSetTargetSearchKeyword;

  const factory PushEvent.push() = PushOnPost;

  const factory PushEvent.setPushData({
    String? targetLinkPostId,
    PushLinkType? targetLinkType,
    PushSendType? sendType,
    DateTime? dateTime,
    String? title,
    String? content,
    SimpleStockGroup? stockGroup,
    SimpleStock? stock,
  }) = PushOnSetData;
}

class PushOnPost extends PushEvent {
  const PushOnPost() : super._();
}

class PushOnSetTargetSearchType extends PushEvent {
  final PushTargetType searchType;

  const PushOnSetTargetSearchType(this.searchType) : super._();
}

class PushOnSetTargetSearchKeyword extends PushEvent {
  final String searchKeyword;

  const PushOnSetTargetSearchKeyword(this.searchKeyword) : super._();
}

class PushOnSetData extends PushEvent {
  final String? targetLinkPostId;
  final PushLinkType? targetLinkType;
  final PushSendType? sendType;
  final DateTime? dateTime;
  final String? content;
  final String? title;
  final SimpleStockGroup? stockGroup;
  final SimpleStock? stock;

  const PushOnSetData({
    this.content,
    this.title,
    this.stock,
    this.stockGroup,
    this.dateTime,
    this.sendType,
    this.targetLinkPostId,
    this.targetLinkType,
  }) : super._();
}
