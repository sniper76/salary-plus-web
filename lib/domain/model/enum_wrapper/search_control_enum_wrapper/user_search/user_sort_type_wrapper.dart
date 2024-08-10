import 'package:act_cms/domain/model/enum/user_sort_type.dart';
import 'package:act_cms/domain/model/enum_wrapper/search_control_enum_wrapper/search_control_enum_wrapper.dart';

class UserSortTypeWrapper extends SearchControlEnumWrapper {
  final UserSortType userSortType;

  UserSortTypeWrapper({required this.userSortType});

  @override
  String get label => userSortType.label;
}
