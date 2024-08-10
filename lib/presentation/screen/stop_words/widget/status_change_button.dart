part of '../screen.dart';

class _StatusChangeButton extends StatelessWidget {
  final StopWord stopWord;

  late final bool showInActiveButton = stopWord.status == StopWordStatus.active;
  late final StopWordStatus targetStatus = showInActiveButton ? StopWordStatus.inactiveByAdmin : StopWordStatus.active;
  late final Color buttonColor = showInActiveButton ? Colors.orange : Colors.green;
  late final String actionString = targetStatus.label;

  _StatusChangeButton({
    required this.stopWord,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _onChangeStopWordStatus(context, stopWord),
      child: Container(
        alignment: Alignment.center,
        width: 90,
        height: 40,
        decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
        child: Text(
          '$actionString하기',
          style: const TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
    );
  }
}
