import 'dart:async';
import 'dart:convert';

import 'package:act_cms/config/app_event.dart';
import 'package:act_cms/core/injection.dart';
import 'package:act_cms/domain/model/digital_document_download.dart';
import 'package:act_cms/domain/model/enum/action_post_type.dart';
import 'package:act_cms/domain/model/enum/board_group_type.dart';
import 'package:act_cms/domain/model/enum/file_download_status.dart';
import 'package:act_cms/domain/model/local_storage_zip_file.dart';
import 'package:act_cms/domain/usecase/admin_campaign/get_campaign.dart';
import 'package:act_cms/domain/usecase/admin_post/get_post.dart';
import 'package:act_cms/domain/usecase/admin_zip_file_download/delete_zip_file_data.dart';
import 'package:act_cms/domain/usecase/admin_zip_file_download/get_zip_file_data.dart';
import 'package:act_cms/domain/usecase/admin_zip_file_download/get_zip_file_data_list.dart';
import 'package:act_cms/domain/usecase/admin_zip_file_download/polling_zip_file_list.dart';
import 'package:act_cms/domain/usecase/admin_zip_file_download/save_zip_file_data.dart';
import 'package:act_cms/presentation/base/base_state.dart';
import 'package:bloc/bloc.dart';
import 'package:event_bus_plus/event_bus_plus.dart';
import 'package:meta/meta.dart';
import 'package:multiple_result/multiple_result.dart';

part 'event.dart';
part 'state.dart';

class DialogBloc extends Bloc<DialogEvent, DialogState> {
  final _eventBus = getIt<IEventBus>();
  final _getZipFileData = getIt<GetZipFileData>();
  final _deleteZipFileData = getIt<DeleteZipFileData>();
  final _saveZipFileData = getIt<SaveZipFileData>();
  final _getCampaign = getIt<GetCampaign>();
  final _getPost = getIt<GetPost>();
  final _pollingData = getIt<PollingZipFileList>();
  final _getZipFileDataList = getIt<GetZipFileDataList>();

  late StreamSubscription _postItemChangeEventSubscription;

  DialogBloc(ActionPostType type) : super(const DialogState()) {
    on<OnInit>(onInit);
    on<OnRequestZipFile>(onRequestZipFile);
    on<OnPollingData>(onPollingData);
    on<OnComplete>(onComplete);

    _postItemChangeEventSubscription = _eventBus.on<LoadingZipFileEvent>().listen((e) {
      add(DialogEvent.onComplete(e.fileKey));
    });
  }

  void onInit(OnInit event, emit) async {
    emit(state.copyWith(isLoading: true));
    final Result? downloadResult = await getDigitalDocumentDownloadResult(zipFileData: event.zipFileData);
    final DigitalDocumentDownload? digitalDocs = getDownloadedDocs(downloadResult, event.zipFileData.type);

    final hasData = _getZipFileData(event.zipFileData.id.toString());
    emit(
      state.copyWith(
        isLoading: hasData == null ? false : true,
        zipFileStatus: hasData == null ? digitalDocs?.zipFileStatus : FileDownloadStatusType.processing,
        fileKey: digitalDocs?.zipFileStatus == FileDownloadStatusType.complete ? digitalDocs?.zipFileKey : null,
        updatedDownloadData: digitalDocs?.updatedAt,
      ),
    );
  }

  void onComplete(OnComplete event, emit) {
    emit(state.copyWith(
      zipFileStatus: FileDownloadStatusType.complete,
      isLoading: false,
      fileKey: event.fileKey,
    ));
  }

  void onRequestZipFile(OnRequestZipFile event, emit) {
    final data = _getZipFileData(event.id.toString());
    if (data == null) {
      emit(state.copyWith(isLoading: true, zipFileStatus: FileDownloadStatusType.request));

      final data = LocalStorageZipFile(
        id: event.id,
        type: event.type,
        code: event.code,
        boardGroupType: event.boardGroupType,
        fileKey: event.fileKey,
      );
      Map<String, dynamic> zipFileJson = data.toJson();
      final stringFileData = jsonEncode(zipFileJson);

      _saveZipFileData(event.id.toString(), stringFileData);
      add(const OnPollingData());
    }
  }

  void onPollingData(OnPollingData event, emit) {
    emit(state.copyWith(isLoading: true, zipFileStatus: FileDownloadStatusType.processing));

    _pollingData(
      callback: ({required LocalStorageZipFile zipFileData}) {
        pollingDataCallback(zipFileData: zipFileData, emit: emit);
      },
      getZipFileDataList: _getZipFileDataList,
    );
  }

  void requestZipFile({
    required int id,
    required ActionPostType type,
    String? code,
    BoardGroupType? boardGroupType,
  }) {
    add(OnRequestZipFile(id: id, type: type, code: code, boardGroupType: boardGroupType));
  }

  void deleteZipFileData({FileDownloadStatusType? zipFileStatus, required int id, required String fileKey}) {
    if (zipFileStatus == FileDownloadStatusType.complete) {
      _deleteZipFileData(id.toString());
      _eventBus.fire(OpenZipFileToastMessageEvent(fileKey: fileKey));
      _eventBus.fire(LoadingZipFileEvent(fileKey: fileKey));
    }
  }

  void pollingDataCallback({
    required LocalStorageZipFile zipFileData,
    required Emitter emit,
  }) async {
    DigitalDocumentDownload? downloadDocs;

    final Result? downloadResult = await getDigitalDocumentDownloadResult(zipFileData: zipFileData);

    if (downloadResult != null && downloadResult.isSuccess()) {
      downloadDocs = getDownloadedDocs(downloadResult, zipFileData.type);
    }

    if (downloadDocs != null) {
      deleteZipFileData(
        zipFileStatus: downloadDocs.zipFileStatus,
        id: zipFileData.id,
        fileKey: downloadDocs.zipFileKey!,
      );
    } else {
      // zip 파일 요청 실패
      _deleteZipFileData(zipFileData.id.toString());
      emit(state.copyWith(
        errorToastMessage: downloadResult?.tryGetError().message,
      ));
    }
  }

  Future<Result?> getDigitalDocumentDownloadResult({
    required LocalStorageZipFile zipFileData,
  }) async {
    Result? res;

    if (zipFileData.type == ActionPostType.campaign) {
      res = await _getCampaign(zipFileData.id);
    }
    if (zipFileData.type == ActionPostType.action) {
      res = await _getPost(
        postId: zipFileData.id,
        stockCode: zipFileData.code ?? '',
        boardGroupType: zipFileData.boardGroupType ?? BoardGroupType.action,
      );
    }

    return res;
  }

  DigitalDocumentDownload? getDownloadedDocs(Result? downloadResult, ActionPostType zipFileDataType) {
    switch (zipFileDataType) {
      case ActionPostType.campaign:
        final campaignDetail = downloadResult?.tryGetSuccess()?.data;
        return campaignDetail?.sourcePost?.digitalDocument?.digitalDocumentDownload;
      case ActionPostType.action:
        final campaignDetail = downloadResult?.tryGetSuccess()?.data;
        return campaignDetail?.digitalDocument?.digitalDocumentDownload;
      default:
        return null;
    }
  }

  @override
  Future<void> close() {
    _postItemChangeEventSubscription.cancel();
    return super.close();
  }
}
