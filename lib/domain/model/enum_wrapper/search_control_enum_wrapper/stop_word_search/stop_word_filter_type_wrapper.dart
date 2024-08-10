import 'package:act_cms/domain/model/enum/stop_word_filter_type.dart';
import 'package:act_cms/domain/model/enum_wrapper/search_control_enum_wrapper/search_control_enum_wrapper.dart';

class StopWordFilterTypeWrapper extends SearchControlEnumWrapper {
  final StopWordFilterType stopWordFilterType;

  StopWordFilterTypeWrapper({required this.stopWordFilterType});

  @override
  String get label => stopWordFilterType.label;
}
