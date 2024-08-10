import 'package:act_cms/core/extension/context_extension.dart';
import 'package:act_cms/core/util/icons_util.dart';
import 'package:act_cms/domain/model/holder_list_read_and_copy_digital_document.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HolderListReadAndCopyDocsWidget extends StatelessWidget {
  final HolderListReadAndCopyDigitalDocument digitalDocument;
  final VoidCallback? onTapDownloadButton;

  const HolderListReadAndCopyDocsWidget({
    required this.digitalDocument,
    required this.onTapDownloadButton,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadius.circular(8.0),
      ),
      height: 88,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '첨부파일',
                style: context.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
              ),
              GestureDetector(
                onTap: onTapDownloadButton,
                child: SvgPicture.asset(
                  'assets/images/ic_download.svg',
                  width: 24,
                  height: 24,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12.0),
          Row(
            children: [
              Icon(
                IconsUtil.getFileExtensionIcon(digitalDocument.getFileExtension),
                color: Colors.red,
              ),
              const SizedBox(width: 8.0),
              Flexible(
                child: Text(
                  digitalDocument.getName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
