import 'package:act_cms/config/constants.dart';
import 'package:act_cms/core/injection.dart';
import 'package:act_cms/domain/model/board_group_category.dart';
import 'package:act_cms/core/extension/exception_extension.dart';
import 'package:act_cms/domain/model/enum/board_group_type.dart';
import 'package:act_cms/domain/model/post.dart';
import 'package:act_cms/domain/usecase/admin_post/create_post.dart';
import 'package:act_cms/domain/usecase/admin_post/update_post.dart';
import 'package:act_cms/presentation/screen/event_board/register/bloc/event.dart';
import 'package:act_cms/presentation/screen/event_board/register/bloc/state.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multiple_result/multiple_result.dart';

class EventBoardRegisterBloc extends Bloc<EventBoardRegisterEvent, EventBoardRegisterState> {
  final BoardGroupCategory boardGroupCategory;

  final _createPost = getIt<CreateAdminPost>();
  final _updatePost = getIt<UpdatePost>();

  EventBoardRegisterBloc({
    required this.boardGroupCategory,
    Post? updatePost,
  }) : super(const EventBoardRegisterState()) {
    on<OnInit>((event, emit) async {
      if (updatePost != null) {
        emit(state.copyWith(
          title: updatePost.title,
          content: updatePost.content,
          isActive: updatePost.isActive,
          updatePost: updatePost,
          activeStartDate: updatePost.activeStartDate?.toLocal(),
          activeEndDate: updatePost.activeEndDate?.toLocal(),
          isNotification: updatePost.isNotification,
          pushRequest: updatePost.pushRequest,
        ));
      }
    });

    on<OnSaveEventBoardPost>((event, emit) async {
      if (state.isLoading) return;

      emit(state.copyWith(isLoading: true));

      final title = event.title;
      final content = event.content;
      final activeStartDate = event.activeStartDate;
      final activeEndDate = event.activeEndDate;

      final push = event.pushRequest;
      Future<Result<Post, Exception>> savePostAsync = state.updatePost != null
          ? _updatePost(
              postId: state.updatePost!.id,
              stockCode: AppConfig.globalBoardCode,
              boardGroupCategory: boardGroupCategory,
              boardGroupType: BoardGroupType.globalevent,
              content: content,
              title: title,
              activeStartDate: activeStartDate?.toUtc().toIso8601String(),
              activeEndDate: activeEndDate?.toUtc().toIso8601String(),
              isActive: event.isActive!,
              isNotification: event.isNotification ?? false,
              isEscaped: true,
            )
          : _createPost(
              stockCode: AppConfig.globalBoardCode,
              boardGroupCategory: boardGroupCategory,
              boardGroupType: BoardGroupType.globalevent,
              content: content,
              title: title,
              activeStartDate: activeStartDate?.toUtc().toIso8601String(),
              activeEndDate: activeEndDate?.toUtc().toIso8601String(),
              isActive: event.isActive!,
              pushRequest: push,
              isNotification: event.isNotification ?? false,
              isEscaped: true,
            );
      final res = await savePostAsync;

      if (res.isSuccess()) {
        final updatePost = res.tryGetSuccess();

        emit(state.copyWith(
          isLoading: false,
          updatePost: updatePost,
          isComplete: true,
        ));
      } else {
        emit(state.copyWith(
          isLoading: false,
          isComplete: false,
          errorToastMessage: res.tryGetError()?.message,
        ));
      }
    });

    on<SetActiveStartDateTime>((event, emit) async {
      emit(state.copyWith(activeStartDate: event.newDate));
    });

    on<SetActiveEndDateTime>((event, emit) async {
      emit(state.copyWith(activeEndDate: event.newDate));
    });

    on<OnSetActiveStatus>((event, emit) async {
      emit(state.copyWith(
        isActive: event.isActive,
      ));
    });

    on<OnSetAlarmStatus>((event, emit) async {
      if (state.isNotification == event.isNotification) return;

      emit(state.copyWith(
        isNotification: event.isNotification,
      ));
    });

    on<OnSetData>((event, emit) async {
      emit(state.copyWith(
        title: event.title ?? state.title,
        content: event.content ?? state.content,
        activeStartDate: event.activeStartDate ?? state.activeStartDate,
        activeEndDate: event.activeEndDate ?? state.activeEndDate,
        pushRequest: event.push ?? state.pushRequest,
      ));
    });

    on<OnSetPushSendStatus>((event, emit) async {
      if (event.newNoticePushSendStatus == state.selectedNoticePushSendStatus) return;

      emit(state.copyWith(
        selectedNoticePushSendStatus: event.newNoticePushSendStatus,
      ));
    });
  }
}
