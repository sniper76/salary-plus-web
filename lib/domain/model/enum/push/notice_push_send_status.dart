enum NoticePushSendStatus {
  notSend('NOTSEND', '미발송'),
  send('SEND', '발송'),
  ;

  final String value;
  final String title;

  const NoticePushSendStatus(this.value, this.title);
}
