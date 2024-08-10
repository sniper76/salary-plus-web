import 'package:act_cms/domain/model/board_group_category.dart';
import 'package:act_cms/domain/model/enum/push/notice_push_send_status.dart';
import 'package:act_cms/domain/model/enum/push/push_send_type.dart';
import 'package:act_cms/domain/model/enum/push/push_target_type.dart';
import 'package:act_cms/domain/model/post.dart';
import 'package:act_cms/domain/model/push_request.dart';
import 'package:act_cms/presentation/base/base_state.dart';

class EventBoardRegisterState extends BaseState {
  final String? title;
  final String? content;
  final DateTime? activeStartDate;
  final DateTime? activeEndDate;
  final NoticePushSendStatus selectedNoticePushSendStatus;
  final Post? updatePost;
  final bool isActive;
  final bool isNotification;
  final bool isComplete;
  final PushRequest? pushRequest;
  final PushTargetType? targetType;

  const EventBoardRegisterState({
    this.pushRequest,
    this.activeStartDate,
    this.activeEndDate,
    this.updatePost,
    this.selectedNoticePushSendStatus = NoticePushSendStatus.notSend,
    this.isNotification = false,
    this.isActive = true,
    this.title,
    this.content,
    this.targetType = PushTargetType.all,
    this.isComplete = false,
    bool isLoading = false,
    String? errorToastMessage,
  }) : super(
          isLoading: isLoading,
          errorToastMessage: errorToastMessage ?? '',
        );

  EventBoardRegisterState copyWith({
    PushSendType? sendType,
    DateTime? activeStartDate,
    DateTime? activeEndDate,
    NoticePushSendStatus? selectedNoticePushSendStatus,
    Post? updatePost,
    List<BoardGroupCategory>? boardCategoryList,
    bool? isActive,
    bool? isNotification,
    PushRequest? pushRequest,
    String? title,
    String? content,
    bool? isComplete,
    bool? isLoading,
    String? errorToastMessage,
  }) {
    return EventBoardRegisterState(
      activeStartDate: activeStartDate ?? this.activeStartDate,
      activeEndDate: activeEndDate ?? this.activeEndDate,
      selectedNoticePushSendStatus: selectedNoticePushSendStatus ?? this.selectedNoticePushSendStatus,
      updatePost: updatePost ?? this.updatePost,
      isActive: isActive ?? this.isActive,
      isNotification: isNotification ?? this.isNotification,
      pushRequest: pushRequest ?? this.pushRequest,
      title: title ?? this.title,
      content: content ?? this.content,
      isComplete: isComplete ?? this.isComplete,
      isLoading: isLoading ?? this.isLoading,
      errorToastMessage: errorToastMessage ?? '',
    );
  }

  @override
  List<Object?> get props => [
        activeStartDate,
        activeEndDate,
        selectedNoticePushSendStatus,
        updatePost,
        isActive,
        isNotification,
        pushRequest,
        title,
        content,
        isLoading,
        errorToastMessage,
      ];
}
