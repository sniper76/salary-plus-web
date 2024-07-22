extension ExceptionExtension on Exception {
  String get message => toString().replaceFirst('Exception: ', '');
}
