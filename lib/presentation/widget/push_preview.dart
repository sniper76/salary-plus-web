import 'package:act_cms/domain/model/enum/push/push_send_type.dart';
import 'package:act_cms/domain/model/enum/push/push_target_type.dart';
import 'package:act_cms/domain/model/simple_stock.dart';
import 'package:flutter/material.dart';

class PushPreview extends StatelessWidget {
  final DateTime? targetDatetime;
  final PushTargetType targetSearchType;
  final String? title;
  final String content;
  final SimpleStock? selectedSimpleStock;

  const PushPreview({
    super.key,
    required this.targetSearchType,
    required this.content,
    this.title,
    this.selectedSimpleStock,
    this.targetDatetime,
  });

  static const placeHolder = "내용을 입력하세요.";

  @override
  Widget build(BuildContext context) {
    return Expanded(
      // Flexible 위젯을 사용해 TextField가 Row의 대부분을 차지하도록 함
      child: Container(
        padding: const EdgeInsets.all(24.0),
        decoration: BoxDecoration(
          color: Colors.white, // 배경색을 흰색으로 설정
          border: Border.all(
            color: const Color(0xffD9D9D9), // 테두리 색상 설정
          ),
          borderRadius: BorderRadius.circular(8), // 모서리 둥글기 설정
        ),
        child: Row(
          children: [
            _buildPushIcon(),
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title ?? ''),
                  if (targetSearchType == PushTargetType.stock) _buildContentForStock(),
                  if (targetSearchType != PushTargetType.stock) _buildContent(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPushIcon() {
    return Image.asset(
      'assets/splash_round.png',
      width: 40,
      height: 40,
    );
  }

  Widget _buildContentForStock() {
    return Text(
        "[${selectedSimpleStock == null ? "종목코드" : selectedSimpleStock!.name}] ${content.isNotEmpty ? content : placeHolder} ");
  }

  Widget _buildContent() {
    return Text("${content.isNotEmpty ? content : placeHolder} ");
  }
}
