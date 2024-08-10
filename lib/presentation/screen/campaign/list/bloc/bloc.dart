import 'dart:async';

import 'package:act_cms/config/app_event.dart';
import 'package:act_cms/core/injection.dart';
import 'package:act_cms/domain/model/board_group_category.dart';
import 'package:act_cms/domain/model/campaign.dart';
import 'package:act_cms/domain/model/enum/campaign_search_type.dart';
import 'package:act_cms/domain/model/paging.dart';
import 'package:act_cms/domain/model/upload_image_file.dart';
import 'package:act_cms/domain/usecase/admin_campaign/campaign_download_csv.dart';
import 'package:act_cms/domain/usecase/admin_campaign/get_campaign.dart';
import 'package:act_cms/domain/usecase/admin_campaign/get_campaigns.dart';
import 'package:act_cms/domain/usecase/admin_campaign/request_zipfile.dart';
import 'package:act_cms/presentation/widget/act_data_grid.dart';
import 'package:act_cms/presentation/widget/act_pagination.dart';
import 'package:bloc/bloc.dart';
import 'package:event_bus_plus/event_bus_plus.dart';
import 'package:flutter/material.dart';

import '../../../../base/base_state.dart';

part 'event.dart';
part 'state.dart';

class CampaignListBloc extends Bloc<CampaignListEvent, CampaignListState> {
  final _eventBus = getIt<IEventBus>();
  final _getCampaigns = getIt<GetCampaigns>();
  final _getCampaign = getIt<GetCampaign>();
  final _downloadExcel = getIt<CampaignDownloadCsv>();
  final _createZipFile = getIt<RequestZipFile>();
  late StreamSubscription _campaignChangedEventSubscription;

  CampaignListBloc() : super(const CampaignListState()) {
    on<OnInit>(onInit);
    on<OnPageRefresh>(onPageRefresh);
    on<OnSetSearchType>(onSetSearchType);
    on<OnSetBoardCategory>(onSetBoardCategory);
    on<OnLoadMore>(onGetCampaignsMore);
    on<OnDownloadCSV>(onDownloadCsv);
    on<OnRequestZipFile>(onRequestZipFile);
    on<OnGetCampaignDetail>(onGetCampaignDetail);
  }

  void onInit(event, emit) async {
    emit(state.copyWith(isLoading: true, searchType: CampaignSearchType.title));

    _campaignChangedEventSubscription = _eventBus.on<CampaignChangedEvent>().listen((e) {
      add(const CampaignListEvent.onPageRefresh());
    });

    final campaignsRes = await _getCampaigns(searchType: state.searchType, searchKeyword: "");
    if (campaignsRes.isSuccess()) {
      final pagingData = campaignsRes.tryGetSuccess();

      emit(state.copyWith(
        isLoading: false,
        campaigns: pagingData?.data,
        paging: pagingData?.paging,
      ));
    } else {
      emit(state.copyWith(isLoading: false, errorToastMessage: campaignsRes.tryGetError().toString()));
    }
  }

  void onPageRefresh(event, emit) async {
    emit(state.copyWith(isLoading: true));

    final campaignsRes = await _getCampaigns(
      searchType: state.searchType,
      searchKeyword: state.searchKeyword,
      boardCategory: state.boardCategory,
      page: state.paging.page,
      size: apiLoadSize,
    );

    if (campaignsRes.isSuccess()) {
      final pagingData = campaignsRes.tryGetSuccess();

      emit(state.copyWith(
        isLoading: false,
        campaigns: pagingData?.data,
        paging: pagingData?.paging,
      ));
    } else {
      emit(state.copyWith(isLoading: false, errorToastMessage: campaignsRes.tryGetError().toString()));
    }
  }

  void onSetSearchType(event, emit) {
    emit(state.copyWith(searchType: event.searchType));
  }

  void onSetBoardCategory(event, emit) {
    emit(state.copyWith(isLoading: true));
    emit(state.copyWith(boardCategory: event.boardCategory));
    add(const CampaignListEvent.onLoadMore());
    emit(state.copyWith(isLoading: false));
  }

  void onGetCampaignDetail(event, emit) async {
    if (state.isLoading) {
      return;
    }
    emit(state.copyWith(isLoading: true));
    final res = await _getCampaign(event.campaignId);
    if (res.isSuccess()) {
      final campaignDetail = res.tryGetSuccess()?.data;
      emit(state.copyWith(isLoading: false, selectedCampaignDetail: campaignDetail));
    } else {
      emit(state.copyWith(
          isLoading: false, selectedCampaignDetail: null, errorToastMessage: res.tryGetError().toString()));
    }
  }

  void onGetCampaignsMore(event, emit) async {
    if (state.isLoading) {
      return;
    }
    emit(state.copyWith(isLoading: true));

    final campaignsRes = await _getCampaigns(
      searchType: state.searchType,
      searchKeyword: event.searchKeyword,
      boardCategory: state.boardCategory,
      size: event.size ?? apiLoadSize,
      page: event.page ?? 1,
    );

    if (campaignsRes.isSuccess()) {
      final pagingData = campaignsRes.tryGetSuccess();
      final campaignsMoreList = pagingData?.data;
      final campaignsMorepage = pagingData?.paging;

      emit(state.copyWith(
        isLoading: false,
        paging: campaignsMorepage,
        campaigns: campaignsMoreList,
      ));
    } else {
      emit(state.copyWith(
        isLoading: false,
        errorToastMessage: campaignsRes.tryGetError().toString(),
      ));
    }
  }

  void onDownloadCsv(event, emit) async {
    emit(state.copyWith(isLoading: true));

    emit(state.copyWith(isLoading: true));
    final res = await _downloadExcel(campaignId: event.campaignId);
    if (res.isSuccess()) {
      emit(state.copyWith(
        isLoading: false,
      ));
    } else {
      emit(state.copyWith(
        isLoading: false,
        errorToastMessage: res.tryGetError().toString(),
      ));
    }
  }

  void onRequestZipFile(event, emit) async {
    emit(state.copyWith(isLoading: true));

    final requestZipFile = await _createZipFile(campaignId: event.campaignId, isSecured: event.isSecured);
    if (requestZipFile.isSuccess()) {
      add(CampaignListEvent.onGetCampaignDetail(event.campaignId));
    } else {}
    emit(state.copyWith(
        isLoading: false,
        errorToastMessage: requestZipFile.isError() ? requestZipFile.tryGetError().toString() : null));
  }
}
