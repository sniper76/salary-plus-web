import 'package:act_cms/core/util/file_download_utill.dart';
import 'package:act_cms/domain/model/digital_document_download.dart';
import 'package:act_cms/domain/model/enum/action_post_type.dart';
import 'package:act_cms/domain/model/enum/board_group_type.dart';
import 'package:act_cms/domain/model/enum/file_download_status.dart';
import 'package:act_cms/domain/model/local_storage_zip_file.dart';
import 'package:act_cms/presentation/dialog/zip_file_download_dialog/bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class ZipFileDownloadDialog extends StatefulWidget {
  final int id;
  final BoardGroupType? boardGroupType;
  final String? stockCode;
  final DigitalDocumentDownload? digitalDocumentDownload;
  final ActionPostType type;
  final void Function(bool isLock)? onRequestFile;

  const ZipFileDownloadDialog({
    super.key,
    required this.id,
    required this.type,
    this.digitalDocumentDownload,
    this.onRequestFile,
    this.boardGroupType,
    this.stockCode,
  });

  @override
  State<ZipFileDownloadDialog> createState() => _ZipFileDownloadDialogState();
}

class _ZipFileDownloadDialogState extends State<ZipFileDownloadDialog> {
  void _startRequestZipFile() {
    final dialogBloc = BlocProvider.of<DialogBloc>(context);
    dialogBloc.requestZipFile(
      id: widget.id,
      type: widget.type,
      code: widget.stockCode,
      boardGroupType: widget.boardGroupType,
    );
  }

  _requestFile(Function(bool isLock)? handler, bool isLock) {
    if (handler != null) {
      _startRequestZipFile();
      handler(isLock);
    }
  }

  void _pasteLink(String zipFileKey) {
    FileDownloadUtils(context: context).pasteLink(key: zipFileKey);
  }

  void _downloadLink(String zipFileKey) {
    FileDownloadUtils(context: context).downloadLink(key: zipFileKey);
  }

  bool _checkIsDownload(FileDownloadStatusType zipFileStatus) => zipFileStatus != FileDownloadStatusType.complete;

  bool _checkIsRequest(FileDownloadStatusType zipFileStatus) => zipFileStatus == FileDownloadStatusType.processing;

  String _getRequestButtonText(bool isLock) => 'ZIP 파일 생성 \n (비밀번호 ${isLock ? '' : '미'}포함)';

  @override
  void initState() {
    super.initState();

    final dialogBloc = BlocProvider.of<DialogBloc>(context);

    dialogBloc.add(
      DialogEvent.onInit(
        zipFileData: LocalStorageZipFile(
          id: widget.id,
          type: widget.type,
          code: widget.stockCode,
          boardGroupType: widget.boardGroupType,
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DialogBloc, DialogState>(
      builder: (context, state) {
        return AlertDialog(
          contentPadding: const EdgeInsets.all(40),
          content: _buildContent(),
        );
      },
    );
  }

  Widget _buildContent() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildDialogTitle(),
        _buildDownloadDateText(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [_buildRequestButtons(), const SizedBox(width: 12), _buildDownloadButtons()],
        ),
      ],
    );
  }

  Widget _buildDialogTitle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text('ZIP 다운로드', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
        IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.of(context).pop()),
      ],
    );
  }

  Widget _buildDownloadDateText() {
    return BlocBuilder<DialogBloc, DialogState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 24),
          child: Row(
            children: [
              Text(
                  '최신다운로드 (${state.updatedDownloadData != null ? DateFormat('yyyy-MM-dd HH:mm:ss').format(state.updatedDownloadData!) : '요청 필요'})'),
              if (state.isLoading) const CircularProgressIndicator()
            ],
          ),
        );
      },
    );
  }

  Widget _buildRequestButtons() {
    return BlocBuilder<DialogBloc, DialogState>(
      builder: (context, state) {
        return Column(
          children: [
            _buildCustomButton(
              onPressed: () {
                _requestFile(widget.onRequestFile, true);
              },
              buttonText: _getRequestButtonText(true),
              disabled: _checkIsRequest(state.zipFileStatus),
            ),
            const SizedBox(height: 12),
            _buildCustomButton(
              onPressed: () {
                _requestFile(widget.onRequestFile, false);
              },
              buttonText: _getRequestButtonText(false),
              disabled: _checkIsRequest(state.zipFileStatus),
            )
          ],
        );
      },
    );
  }

  Widget _buildDownloadButtons() {
    return BlocBuilder<DialogBloc, DialogState>(
      builder: (context, state) {
        return Column(
          children: [
            _buildCustomButton(
              onPressed: () {
                if (state.fileKey != null) {
                  _pasteLink(state.fileKey!);
                }
              },
              buttonText: '링크복사',
              disabled: _checkIsDownload(state.zipFileStatus),
            ),
            const SizedBox(height: 12),
            _buildCustomButton(
              onPressed: () {
                if (state.fileKey != null) {
                  _downloadLink(state.fileKey!);
                }
              },
              buttonText: '다운로드',
              disabled: _checkIsDownload(state.zipFileStatus),
            )
          ],
        );
      },
    );
  }

  Widget _buildCustomButton({required void Function()? onPressed, required String buttonText, bool disabled = false}) {
    return ElevatedButton(
      onPressed: disabled || onPressed == null ? null : onPressed,
      style: ElevatedButton.styleFrom(fixedSize: const Size(230, 74)),
      child: Text(
        buttonText,
        textAlign: TextAlign.center,
      ),
    );
  }
}
