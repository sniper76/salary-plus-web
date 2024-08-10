import 'dart:async';

import 'package:act_cms/config/app_event.dart';
import 'package:act_cms/core/injection.dart';
import 'package:act_cms/core/service/user_auth_service.dart';
import 'package:act_cms/domain/model/board_group_category.dart';
import 'package:act_cms/domain/model/comment.dart';
import 'package:act_cms/domain/model/digital_document.dart';
import 'package:act_cms/domain/model/enum/board_group_type.dart';
import 'package:act_cms/domain/model/enum/board_sort_type.dart';
import 'package:act_cms/domain/model/paging.dart';
import 'package:act_cms/domain/model/post.dart';
import 'package:act_cms/domain/model/solidarity_leader_election_application.dart';
import 'package:act_cms/domain/model/stock.dart';
import 'package:act_cms/domain/model/user.dart';
import 'package:act_cms/domain/usecase/admin_digital_document/get_user_digital_document_pdf.dart';
import 'package:act_cms/domain/usecase/admin_post/delete_post.dart';
import 'package:act_cms/domain/usecase/admin_post/get_post.dart';
import 'package:act_cms/domain/usecase/admin_stock/get_solidarity_leader_election_application.dart';
import 'package:act_cms/presentation/base/base_state.dart';
import 'package:bloc/bloc.dart';
import 'package:event_bus_plus/event_bus_plus.dart';
import 'package:flutter/material.dart';
import 'package:act_cms/core/extension/exception_extension.dart';

part 'post_detail_event.dart';
part 'post_detail_state.dart';

class PostDetailBloc extends Bloc<PostDetailEvent, PostDetailState> {
  final _eventBus = getIt<IEventBus>();
  final _authService = getIt<UserAuthService>();
  final _getPost = getIt<GetPost>();
  final _deletePost = getIt<DeletePost>();
  final _getSolidarityLeaderElectionApplcation = getIt<GetSolidarityLeaderElectionApplcation>();
  final _getUserDigitalDocumentPdf = getIt<GetUserDigitalDocumentPdf>();

  Paging? _commentPaging;

  final Stock stock;
  final BoardGroupType boardGroupType;
  final int postId;
  final BoardGroupCategory? boardGroupCategory;

  PostDetailBloc({
    required this.stock,
    required this.boardGroupType,
    required this.postId,
    required this.boardGroupCategory,
  }) : super(const PostDetailState()) {
    on<PostDetailOnInit>((event, emit) async {
      emit(state.copyWith(isLoading: true));

      final userMe = _authService.userMe;
      final postRes = await _fetchPost();

      if (postRes == null) {
        emit(state.copyWith(isLoading: false, isNotFound: true));
        return;
      }

      final post = postRes.copyWith(stock: stock, boardGroupCategory: boardGroupCategory);

      emit(state.copyWith(
          isLoading: false,
          userMe: userMe,
          post: post,
          isOwner: post.userId == userMe?.id,
          digitalDocument: post.digitalDocument?.copyWith(title: post.title),
          isNotification: post.isNotification,
          isActive: post.isActive));
    });

    on<PostDetailOnUpdateDone>((event, emit) async {
      if (state.isLoading || state.post == null) return;

      Post post = state.post!;

      emit(state.copyWith(
        isLoading: true,
      ));

      final postRes = await _fetchPost();

      if (postRes == null) {
        emit(state.copyWith(
          isLoading: false,
          isNotFound: true,
          onPopScreen: true,
        ));
        return;
      }

      post = postRes.copyWith(stock: stock, boardGroupCategory: boardGroupCategory);

      emit(state.copyWith(
        isLoading: false,
        post: post,
        digitalDocument: post.digitalDocument?.copyWith(title: post.title),
        isNotification: post.isNotification,
        isActive: post.isActive,
      ));

      _broadcastPostItemChanged(post.id);

      emit(state.copyWith(
        isLoading: false,
      ));
    });

    on<PostDetailOnDelete>((event, emit) async {
      if (state.isLoading || state.post == null) return;

      final post = state.post;

      emit(state.copyWith(
        isLoading: true,
      ));

      final res = await _deletePost(
        stockCode: stock.code,
        boardGroupType: boardGroupType,
        postId: post!.id,
      );

      if (res.isSuccess()) {
        _broadcastPostChanged();
      }

      emit(state.copyWith(
        onPopScreen: true,
        isLoading: false,
      ));
    });

    on<PostDetailShowSolidarityApplication>((event, emit) async {
      if (state.isLoading || state.post == null || state.post?.election == null) return;

      final post = state.post;

      emit(state.copyWith(
        isLoading: true,
      ));

      final res = await _getSolidarityLeaderElectionApplcation(
        stockCode: stock.code,
        solidarityLeaderElectionId: post!.election!.electionDetail.solidarityLeaderElectionId,
        solidarityApplicantId: event.solidarityApplicantId,
      );

      if (res.isSuccess()) {
        emit(state.copyWith(
          electionApplication: res.tryGetSuccess(),
          isShowingSolidarityApplication: true,
          isLoading: false,
        ));
      } else {
        emit(state.copyWith(
          isShowingSolidarityApplication: false,
          isLoading: false,
        ));
      }
    });

    on<PostDetailOnDownloadHolderListReadAndCopyDocs>(
      (event, emit) async {
        if (state.isLoading || state.post?.holderListReadAndCopyDigitalDocument == null) {
          return;
        }

        emit(state.copyWith(isLoading: true));

        final downloadRes = await _getUserDigitalDocumentPdf(
          digitalDocumentId: state.post!.holderListReadAndCopyDigitalDocument!.digitalDocumentId,
          userId: state.post!.holderListReadAndCopyDigitalDocument!.digitalDocumentOwnerId,
        );

        if (downloadRes.isSuccess() && downloadRes.tryGetSuccess() != null) {
          emit(state.copyWith(
            isLoading: false,
            holderListReadAndCopyDownloadLink: downloadRes.tryGetSuccess(),
          ));
        } else {
          emit(state.copyWith(
            isLoading: false,
            errorToastMessage: downloadRes.tryGetError()?.message,
          ));
        }
      },
    );
  }

  bool isLastPage() => _commentPaging?.page == _commentPaging?.totalPage;

  Future<Post?> _fetchPost() async {
    final res = await _getPost(
      stockCode: stock.code,
      boardGroupType: boardGroupType,
      postId: postId,
    );
    return res.tryGetSuccess()?.data;
  }

  _broadcastPostChanged() {
    _eventBus.fire(PostChangedEvent());
  }

  _broadcastPostItemChanged(int id) {
    _eventBus.fire(PostItemChangedEvent(id, stock.code));
  }

  _broadcastCommentChanged(int id, bool isActive, String content) {
    _eventBus.fire(PostCommentChangedEvent(id: id, isActive: isActive, content: content));
  }
}
