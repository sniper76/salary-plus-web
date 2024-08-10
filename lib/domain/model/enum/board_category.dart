import 'package:json_annotation/json_annotation.dart';

enum BoardCategoryType {
  @JsonValue('ALL')
  all('ALL', '전체'),
  @JsonValue('DIGITAL_DELEGATION')
  digitalDelegation('DIGITAL_DELEGATION', '의결권위임'),
  @JsonValue('SURVEYS')
  surveys('SURVEYS', '설문'),
  @JsonValue('CO_HOLDING_ARRANGEMENTS')
  coHoldingArrangements('CO_HOLDING_ARRANGEMENTS', '공동보유'),
  @JsonValue('EVENT')
  event('EVENT', '이벤트'),
  @JsonValue('CAMPAIGN')
  campaign('CAMPAIGN', '캠페인'),
  @JsonValue('ETC')
  etc('ETC', '10초서명'),
  @JsonValue('NOTICE')
  notice('NOTICE', '공지사항'),
  @JsonValue('HOLDER_LIST_READ_AND_COPY')
  holderListReadAndCopy('HOLDER_LIST_READ_AND_COPY', '주주명부 열람/등사'),
  ;

  const BoardCategoryType(this.value, this.title);

  final String value;
  final String title;
}
