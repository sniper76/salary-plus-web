import 'package:act_cms/domain/model/enum/stop_word_sort_type.dart';
import 'package:act_cms/domain/model/enum_wrapper/search_control_enum_wrapper/search_control_enum_wrapper.dart';

class StopWordSortTypeWrapper extends SearchControlEnumWrapper {
  final StopWordSortType stopWordSortType;

  StopWordSortTypeWrapper({required this.stopWordSortType});

  @override
  String get label => stopWordSortType.label;
}
