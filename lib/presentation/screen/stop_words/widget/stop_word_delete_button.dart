part of '../screen.dart';

class _StopWordDeleteButton extends StatelessWidget {
  final StopWord stopWord;

  const _StopWordDeleteButton({required this.stopWord});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _onDeleteStopWord(context, stopWord),
      child: Container(
        alignment: Alignment.center,
        width: 80,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
        child: const Text(
          '삭제',
          style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
    );
  }
}
