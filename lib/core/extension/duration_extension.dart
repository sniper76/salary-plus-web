extension DurationExtension on Duration {
  String format() =>
      '${(inMinutes.remainder(60)).toString().padLeft(2, '0')}:${(inSeconds.remainder(60)).toString().padLeft(2, '0')}';
}
