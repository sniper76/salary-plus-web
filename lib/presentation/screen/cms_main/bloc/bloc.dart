import 'dart:async';
import 'dart:ui';

import 'package:act_cms/config/app_event.dart';
import 'package:act_cms/core/injection.dart';
import 'package:act_cms/core/service/user_auth_service.dart';
import 'package:act_cms/domain/model/digital_document_download.dart';
import 'package:act_cms/domain/model/enum/action_post_type.dart';
import 'package:act_cms/domain/model/enum/board_group_type.dart';
import 'package:act_cms/domain/model/enum/file_download_status.dart';
import 'package:act_cms/domain/model/local_storage_zip_file.dart';
import 'package:act_cms/domain/model/user.dart';
import 'package:act_cms/domain/usecase/admin_campaign/get_campaign.dart';
import 'package:act_cms/domain/usecase/admin_post/get_post.dart';
import 'package:act_cms/domain/usecase/admin_zip_file_download/delete_zip_file_data.dart';
import 'package:act_cms/domain/usecase/admin_zip_file_download/get_zip_file_data_list.dart';
import 'package:act_cms/domain/usecase/admin_zip_file_download/polling_zip_file_list.dart';
import 'package:act_cms/presentation/base/base_state.dart';
import 'package:bloc/bloc.dart';
import 'package:event_bus_plus/event_bus_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:meta/meta.dart';
import 'package:multiple_result/multiple_result.dart';

import '../../../../act_cms_app.dart';

part 'event.dart';
part 'state.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  final _eventBus = getIt<IEventBus>();
  final _pullingData = getIt<PollingZipFileList>();
  final _getCampaign = getIt<GetCampaign>();
  final _getPost = getIt<GetPost>();
  final _deleteZipFileData = getIt<DeleteZipFileData>();
  final _getZipFileDataList = getIt<GetZipFileDataList>();
  final _authService = getIt<UserAuthService>();
  late StreamSubscription _postItemChangeEventSubscription;

  MainBloc() : super(const MainState()) {
    on<OnInitial>(_onInitial);
    on<OnAddZipFileDownloadList>(_onAddZipFileDownloadList);
    on<OnLogout>(_onLogout);

    _postItemChangeEventSubscription = _eventBus.on<OpenZipFileToastMessageEvent>().listen((e) {
      add(MainEvent.onAddZipFileDownloadList(e.fileKey));
    });
  }

  void _onInitial(event, emit) async {
    onPollingData();
    final userMe = _authService.userMe;
    emit(state.copyWith(userMe: userMe));
  }

  void _onLogout(event, emit) async {
    _authService.logout();
  }

  void _onAddZipFileDownloadList(event, emit) async {
    emit(state.copyWith(zipFileDownloadList: [event.fileKey, ...state.zipFileDownloadList]));
  }

  void onPollingData() {
    _pullingData(
      callback: ({
        required LocalStorageZipFile zipFileData,
      }) async {
        DigitalDocumentDownload? downloadDocs;
        Result res;

        if (zipFileData.type == ActionPostType.campaign) {
          res = await _getCampaign(zipFileData.id);
          if (res.isSuccess()) {
            final campaignDetail = res.tryGetSuccess()?.data;
            downloadDocs = campaignDetail?.sourcePost?.digitalDocument?.digitalDocumentDownload;
          }
        } else {
          res = await _getPost(
            postId: zipFileData.id,
            stockCode: zipFileData.code ?? '',
            boardGroupType: zipFileData.boardGroupType ?? BoardGroupType.action,
          );
          if (res.isSuccess()) {
            final actionPostDetail = res.tryGetSuccess()?.data;
            downloadDocs = actionPostDetail?.digitalDocument?.digitalDocumentDownload;
          }
        }

        if (downloadDocs != null) {
          deleteZipFileData(
              zipFileStatus: downloadDocs.zipFileStatus, id: zipFileData.id, fileKey: downloadDocs.zipFileKey!);
        } else {
          EasyLoading.showToast(res.tryGetError().message);
          _deleteZipFileData(zipFileData.id.toString());
        }
      },
      getZipFileDataList: _getZipFileDataList,
    );
  }

  void deleteZipFileData({FileDownloadStatusType? zipFileStatus, required int id, required String fileKey}) {
    if (zipFileStatus == FileDownloadStatusType.complete) {
      _deleteZipFileData(id.toString());
      _eventBus.fire(OpenZipFileToastMessageEvent(fileKey: fileKey));
    }
  }
}
