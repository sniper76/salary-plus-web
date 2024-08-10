part of '../post_detail_screen.dart';

class _ElectionApplicationTextBox extends StatelessWidget {
  final String text;
  const _ElectionApplicationTextBox({required this.text, super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      width: screenWidth * 0.8, // 화면 너비의 80%로 설정
      decoration: BoxDecoration(border: Border.all(), borderRadius: BorderRadius.circular(8.0)),
      padding: const EdgeInsets.all(12.0),
      child: Text(text),
    );
  }
}
