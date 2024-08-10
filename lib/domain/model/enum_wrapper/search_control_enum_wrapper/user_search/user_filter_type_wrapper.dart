import 'package:act_cms/domain/model/enum/user_filter_type.dart';
import 'package:act_cms/domain/model/enum_wrapper/search_control_enum_wrapper/search_control_enum_wrapper.dart';

class UserFilterTypeWrapper extends SearchControlEnumWrapper {
  final UserFilterType userFilterType;

  UserFilterTypeWrapper({required this.userFilterType});

  @override
  String get label => userFilterType.label;
}
