import 'dart:async';

import 'package:act_web/config/app_event.dart';
import 'package:act_web/core/extension/exception_extension.dart';
import 'package:act_web/core/service/user_auth_service.dart';
import 'package:act_web/domain/enum/board_group_type.dart';
import 'package:act_web/domain/model/document/document.dart';
import 'package:act_web/domain/model/file/upload_image_file.dart';
import 'package:act_web/domain/model/post/board_group_category.dart';
import 'package:act_web/domain/model/post/poll_register_result.dart';
import 'package:act_web/domain/model/post/post.dart';
import 'package:act_web/domain/model/user/user_profile.dart';
import 'package:act_web/domain/usecase/post/create_post.dart';
import 'package:act_web/domain/usecase/post/update_post.dart';
import 'package:act_web/domain/usecase/web/upload_image.dart';
import 'package:act_web/presentation/base/base_state_mixin.dart';
import 'package:event_bus_plus/res/event_bus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:get_it/get_it.dart';
import 'package:multiple_result/multiple_result.dart';

part 'bloc.freezed.dart';
part 'event.dart';
part 'state.dart';

class PostSaveBloc extends Bloc<PostSaveEvent, PostSaveState> {
  final IEventBus _eventBus = GetIt.I<IEventBus>();
  final UserAuthService _authService = GetIt.I<UserAuthService>();

  final UploadImage _uploadImage = GetIt.I<UploadImage>();
  final CreatePost _createPost = GetIt.I<CreatePost>();
  final UpdatePost _updatePost = GetIt.I<UpdatePost>();

  final int maxUploadFileCount = 1;

  final BoardGroupType? boardGroupType;
  final BoardGroupCategory? boardGroupCategory;
  final Post? post;

  late final String _tempSavedPostContentStorageKey = 'temp_saved_storage_key_${_authService.userMe?.id}';

  PostSaveBloc({
    required this.boardGroupType,
    this.boardGroupCategory,
    this.post,
  }) : super(const PostSaveState()) {
    on<_OnInit>((event, emit) async {
      emit(state.copyWithNull(isLoading: true));

      final String? tempSavedPostContent = post == null ? await _loadTempSavedPostContent() : null;

      final uploadImages =
          post?.postImages?.map((e) => UploadImageFile(id: e.imageId, url: e.imageUrl, originalFilename: '')).toList();

      emit(state.copyWithNull(
        isLoading: false,
        uploadImageFiles: uploadImages ?? [],
        isAnonymous: post?.userProfile?.isAnonymous ?? false,
        isExclusiveToHolders: post?.isExclusiveToHolders ?? false,
        pollRegisterResultList: post?.polls?.map((Poll poll) => PollRegisterResult.fromModel(poll)).toList() ?? [],
        selectedboardGroupOption: post?.boardGroupCategory != null && post?.boardGroupType != null
            ? (
                post!.boardGroupType!,
                post!.boardGroupCategory!,
              )
            : null,
        stockCode: post?.stock?.code,
        tempSavedPostContent: tempSavedPostContent,
      ));
    });

    on<_OnDisableSavedContentDialog>((event, emit) async {
      emit(state.copyWithNull(
        tempSavedPostContent: null,
      ));
    });

    on<_OnTempSavePostContent>((event, emit) async {
      await _saveTempSavedPostContent(event.content);

      emit(state.copyWithNull(
        tempSavedDateTime: DateTime.now(),
      ));
    });

    on<_OnSearchStock>((event, emit) async {
      emit(state.copyWithNull(
        stockSearchKeyword: event.stockCode ?? '',
      ));
    });

    on<_OnChangeStock>((event, emit) async {
      if (_authService.userMe?.leadingSolidarityStockCodes?.contains(event.stockCode) == true) {
        emit(state.copyWithNull(
          stockCode: event.stockCode,
          boardGroupOptionList: [
            (BoardGroupType.debate, const BoardGroupCategory(name: 'DEBATE', displayName: '토론방')),
            (BoardGroupType.analysis, const BoardGroupCategory(name: 'DAILY_ACT', displayName: '분석자료')),
            (
              BoardGroupType.analysis,
              const BoardGroupCategory(name: 'SOLIDARITY_LEADER_LETTERS', displayName: '주주연대 공지')
            ),
          ],
          selectedboardGroupOption: (
            BoardGroupType.debate,
            const BoardGroupCategory(name: 'DEBATE', displayName: '토론방')
          ),
        ));
      } else {
        emit(state.copyWithNull(
          stockCode: event.stockCode,
          boardGroupOptionList: [
            (BoardGroupType.debate, const BoardGroupCategory(name: 'DEBATE', displayName: '토론방')),
          ],
          selectedboardGroupOption: (
            BoardGroupType.debate,
            const BoardGroupCategory(name: 'DEBATE', displayName: '토론방')
          ),
        ));
      }
    });

    on<_OnChangeCategory>((event, emit) async {
      if (event.option != null) {
        emit(state.copyWithNull(
          selectedboardGroupOption: event.option,
        ));
      }
    });

    on<_OnUploadImage>((event, emit) async {
      if (state.isLoading) return;

      if (state.uploadImageFiles.length >= maxUploadFileCount) {
        emit(state.copyWithNull(errorToastMessage: '이미지 업로드 최대 갯수($maxUploadFileCount)를 초과 하였습니다'));
        return;
      }

      emit(state.copyWithNull(isLoading: true));

      final res = await _uploadImage(event.file);
      final updateUploadImageFiles = [...state.uploadImageFiles];
      final uploadImageFile = res.tryGetSuccess();
      if (res.isSuccess() && uploadImageFile != null) {
        updateUploadImageFiles.add(uploadImageFile);
      }

      emit(state.copyWithNull(
        isLoading: false,
        uploadImageFiles: updateUploadImageFiles,
      ));
    });

    on<_OnDeleteUploadImage>((event, emit) async {
      if (state.isLoading) return;

      emit(state.copyWithNull(
        isLoading: false,
        uploadImageFiles: [],
      ));
    });

    on<_OnToggleAnonymous>(
      (event, emit) {
        if (state.isLoading) return;

        emit(state.copyWithNull(
          isAnonymous: !state.isAnonymous,
        ));
      },
    );

    on<_OnToggleIsExclusiveToHolders>(
      (event, emit) {
        if (state.isLoading) return;

        emit(state.copyWithNull(isExclusiveToHolders: !state.isExclusiveToHolders));
      },
    );

    on<_OnCreatePoll>(
      (event, emit) {
        if (state.isLoading) return;

        emit(state.copyWithNull(pollRegisterResultList: [...state.pollRegisterResultList, event.pollRegisterResult]));
      },
    );

    on<_OnUpdatePoll>(
      (event, emit) {
        if (state.isLoading) return;

        // indexWhere return -1 when no item found
        final int changedPollRegistredResultIndex = state.pollRegisterResultList.indexWhere(
          (element) => element.title == event.pollRegisterResult.title,
        );

        if (changedPollRegistredResultIndex != -1) {
          List<PollRegisterResult> originPollRegistereResultList = state.pollRegisterResultList;
          originPollRegistereResultList = originPollRegistereResultList.map(
            (result) {
              return result.copyWith(endedAt: event.pollRegisterResult.endedAt);
            },
          ).toList();
          emit(state.copyWithNull(pollRegisterResultList: originPollRegistereResultList));
        }
      },
    );

    on<_OnDeletePoll>(
      (event, emit) {
        final List<PollRegisterResult> newPollRegisterResultList = [...state.pollRegisterResultList];
        newPollRegisterResultList.removeAt(event.index);

        emit(PostSaveState(
          isLoading: state.isLoading,
          isAnonymous: state.isAnonymous,
          isExclusiveToHolders: state.isExclusiveToHolders,
          errorToastMessage: state.errorToastMessage,
          selectedboardGroupOption: state.selectedboardGroupOption,
          boardGroupOptionList: state.boardGroupOptionList,
          uploadImageFiles: state.uploadImageFiles,
          updatedPost: state.updatedPost,
          pollRegisterResultList: newPollRegisterResultList,
        ));
      },
    );

    on<_OnSave>((event, emit) async {
      if (state.isLoading || state.selectedboardGroupOption == null && state.stockCode == null) return;

      final title = event.title;
      final content = event.content;
      final isAnonymous = state.isAnonymous;
      final isExclusiveToHolders = state.isExclusiveToHolders;
      final polls = state.pollRegisterResultList
          .map((PollRegisterResult pollRegisterResult) => pollRegisterResult.toPoll())
          .toList();
      final uploadImages = state.uploadImageFiles;

      emit(state.copyWithNull(isLoading: true));

      Future<Result<Post, Exception>> savePostAsync = post != null
          ? _updatePost(
              stockCode: state.stockCode!,
              boardGroupType: state.selectedboardGroupOption!.$1,
              boardGroupCategory: state.selectedboardGroupOption!.$2,
              postId: post!.id,
              title: title,
              content: content,
              isAnonymous: post?.userProfile?.isAnonymous ?? false,
              isExclusiveToHolders: isExclusiveToHolders,
              uploadImages: uploadImages,
              polls: polls,
            )
          : _createPost(
              stockCode: state.stockCode!,
              boardGroupType: state.selectedboardGroupOption!.$1,
              boardGroupCategory: state.selectedboardGroupOption!.$2,
              title: title,
              content: content,
              isAnonymous: isAnonymous,
              isExclusiveToHolders: isExclusiveToHolders,
              uploadImages: uploadImages,
              polls: polls,
            );

      final res = await savePostAsync;

      final updatedPost = res.tryGetSuccess();

      // when create post
      if (res.isSuccess() && post == null) {
        _eventBus.fire(PostCountChangeEvent());
        _deleteTempSavedPostContent();
      }

      // when update post
      if (res.isSuccess() && post != null && updatedPost != null) {
        _eventBus.fire(PostChangedEvent(post: updatedPost));
      }

      emit(state.copyWithNull(
        isLoading: false,
        updatedPost: updatedPost,
        errorToastMessage: res.tryGetError()?.message,
      ));
    });
  }

  Future<String?> _loadTempSavedPostContent() async {
    try {
      String? tempSavedPostContent = await const FlutterSecureStorage().read(
        key: _tempSavedPostContentStorageKey,
      );

      if (tempSavedPostContent == null) return null;

      return tempSavedPostContent;
    } catch (e) {
      return null;
    }
  }

  Future<void> _saveTempSavedPostContent(String content) async {
    await const FlutterSecureStorage().write(
      key: _tempSavedPostContentStorageKey,
      value: content,
    );
  }

  Future<void> _deleteTempSavedPostContent() async {
    await const FlutterSecureStorage().delete(
      key: _tempSavedPostContentStorageKey,
    );
  }
}
