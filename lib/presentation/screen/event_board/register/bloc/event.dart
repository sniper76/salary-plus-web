import 'package:act_cms/domain/model/enum/push/notice_push_send_status.dart';
import 'package:act_cms/domain/model/push_request.dart';

abstract class EventBoardRegisterEvent {
  EventBoardRegisterEvent._();

  factory EventBoardRegisterEvent.init() = OnInit;

  factory EventBoardRegisterEvent.save({
    required String title,
    required String content,
    DateTime? activeStartDate,
    DateTime? activeEndDate,
    PushRequest? pushRequest,
    bool? isActive,
    bool? isNotification,
  }) = OnSaveEventBoardPost;

  factory EventBoardRegisterEvent.setStartDateTime(DateTime newDate) = SetActiveStartDateTime;

  factory EventBoardRegisterEvent.setEndDateTime(DateTime newDate) = SetActiveEndDateTime;

  factory EventBoardRegisterEvent.setActiveStatus(bool isActive) = OnSetActiveStatus;

  factory EventBoardRegisterEvent.setAlarmStatus(bool isNotification) = OnSetAlarmStatus;

  factory EventBoardRegisterEvent.setPushSendStatus(NoticePushSendStatus newNoticePushSendStatus) = OnSetPushSendStatus;

  factory EventBoardRegisterEvent.setData({
    String? title,
    String? content,
    DateTime? activeStartDate,
    DateTime? activeEndDate,
    PushRequest? push,
    bool? isActive,
    bool? isNotification,
  }) = OnSetData;
}

class OnInit extends EventBoardRegisterEvent {
  OnInit() : super._();
}

class OnSaveEventBoardPost extends EventBoardRegisterEvent {
  final String title;
  final String content;
  DateTime? activeStartDate;
  DateTime? activeEndDate;
  PushRequest? pushRequest;
  bool? isActive;
  bool? isNotification;
  OnSaveEventBoardPost({
    required this.title,
    required this.content,
    this.activeStartDate,
    this.activeEndDate,
    this.pushRequest,
    this.isActive,
    this.isNotification,
  }) : super._();
}

class OnSetData extends EventBoardRegisterEvent {
  String? title;
  String? content;
  DateTime? activeStartDate;
  DateTime? activeEndDate;
  PushRequest? push;
  bool? isActive;
  bool? isNotification;

  OnSetData({
    this.title,
    this.content,
    this.activeEndDate,
    this.activeStartDate,
    this.push,
    this.isActive,
    this.isNotification,
  }) : super._();
}

class SetActiveStartDateTime extends EventBoardRegisterEvent {
  final DateTime newDate;

  SetActiveStartDateTime(this.newDate) : super._();
}

class SetActiveEndDateTime extends EventBoardRegisterEvent {
  final DateTime newDate;

  SetActiveEndDateTime(this.newDate) : super._();
}

class OnSetActiveStatus extends EventBoardRegisterEvent {
  final bool isActive;

  OnSetActiveStatus(this.isActive) : super._();
}

class OnSetAlarmStatus extends EventBoardRegisterEvent {
  final bool isNotification;

  OnSetAlarmStatus(this.isNotification) : super._();
}

class OnSetPushSendStatus extends EventBoardRegisterEvent {
  final NoticePushSendStatus newNoticePushSendStatus;

  OnSetPushSendStatus(this.newNoticePushSendStatus) : super._();
}
