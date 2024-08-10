import 'package:act_cms/config/app_event.dart';
import 'package:act_cms/core/injection.dart';
import 'package:act_cms/core/service/user_auth_service.dart';
import 'package:act_cms/domain/model/campaign.dart';
import 'package:act_cms/domain/model/campaign_post.dart';
import 'package:act_cms/domain/model/comment.dart';
import 'package:act_cms/domain/model/enum/board_group_type.dart';
import 'package:act_cms/domain/model/enum/board_sort_type.dart';
import 'package:act_cms/domain/model/paging.dart';
import 'package:act_cms/domain/model/post.dart';
import 'package:act_cms/domain/model/user.dart';
import 'package:act_cms/domain/usecase/admin_campaign/delete_campaign.dart';
import 'package:act_cms/domain/usecase/admin_campaign/get_campaign.dart';
import 'package:act_cms/domain/usecase/admin_post/get_post.dart';
import 'package:act_cms/presentation/widget/act_data_grid.dart';
import 'package:act_cms/presentation/widget/act_pagination.dart';
import 'package:bloc/bloc.dart';
import 'package:event_bus_plus/event_bus_plus.dart';
import 'package:flutter/material.dart';

import '../../../../base/base_state.dart';

part 'event.dart';
part 'state.dart';

class CampaignDetailBloc extends Bloc<CampaignDetailEvent, CampaignDetailState> {
  final _eventBus = getIt<IEventBus>();
  final _getPost = getIt<GetPost>();
  final _getCampaign = getIt<GetCampaign>();
  final _deleteCampaign = getIt<DeleteCampaign>();
  final _authService = getIt<UserAuthService>();

  Paging? _commentPaging;

  CampaignDetailBloc() : super(const CampaignDetailState()) {
    on<OnInit>(onInit);
    on<OnSetStock>(onSetStock);
    on<OnSearchStock>(onSearchStock);
    on<OnDeleteCampaign>(onDeleteCampaign);
    on<OnGetPost>(onGetPost);
  }

  void onInit(event, emit) async {
    if (state.isLoading) {
      return;
    }
    emit(state.copyWith(isLoading: true));
    final userMe = _authService.userMe;

    final res = await _getCampaign(event.campaignId);
    if (res.isSuccess()) {
      final campaignDetail = res.tryGetSuccess()?.data;
      final resPost = campaignDetail!.campaignPosts;
      final firstPost = resPost?.first;

      emit(state.copyWith(
        isLoading: false,
        detailCampaign: campaignDetail,
        simpleStockList: campaignDetail.campaignPosts,
        userMe: userMe,
        selectedStock: firstPost,
      ));

      add(CampaignDetailEvent.onGetPost(firstPost!.postId, firstPost.stock.code));
    } else {
      emit(state.copyWith(isLoading: false, detailCampaign: null, errorToastMessage: res.tryGetError().toString()));
    }
  }

  void onSetStock(OnSetStock event, emit) async {
    final campaignStock = event.stock;
    emit(state.copyWith(isLoading: true, selectedStock: campaignStock));
    add(CampaignDetailEvent.onGetPost(campaignStock.postId, campaignStock.stock.code));
    emit(state.copyWith(isLoading: false));
  }

  void onSearchStock(event, emit) async {
    emit(state.copyWith(
        simpleStockList: state.detailCampaign?.campaignPosts
            ?.where((stock) => stock.stock.name.toLowerCase().contains(event.searchText.toLowerCase()))
            .toList()));
  }

  void onGetPost(event, emit) async {
    emit(state.copyWith(isLoading: true));

    final post = await _getPost(
      postId: event.postId,
      stockCode: event.stockCode ?? '',
      boardGroupType: BoardGroupType.action,
    );

    if (post.isSuccess()) {
      emit(state.copyWith(detailPost: post.tryGetSuccess()?.data));
    } else {
      emit(state.copyWith(errorToastMessage: post.tryGetError().toString()));
    }
    emit(state.copyWith(isLoading: false));
  }

  void onDeleteCampaign(event, emit) async {
    emit(state.copyWith(isLoading: true));

    final res = await _deleteCampaign(event.campaignId);

    if (res.isSuccess()) {
      _broadcastCampaignChanged();
    }

    emit(state.copyWith(
      isLoading: false,
    ));
  }

  _broadcastCampaignChanged() {
    _eventBus.fire(CampaignChangedEvent());
  }

  bool isLastPage() => _commentPaging?.page == _commentPaging?.totalPage;
}
