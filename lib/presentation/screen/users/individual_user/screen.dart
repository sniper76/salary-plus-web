import 'package:act_cms/config/theme.dart';
import 'package:act_cms/core/extension/number_extension.dart';
import 'package:act_cms/domain/model/enum/user_search_category.dart';
import 'package:act_cms/domain/model/enum/user_filter_type.dart';
import 'package:act_cms/domain/model/enum/user_sort_type.dart';
import 'package:act_cms/domain/model/enum_wrapper/search_control_enum_wrapper/user_search/user_filter_type_wrapper.dart';
import 'package:act_cms/domain/model/enum_wrapper/search_control_enum_wrapper/user_search/user_sort_type_wrapper.dart';

import 'package:act_cms/domain/model/user.dart';
import 'package:act_cms/presentation/base/base_bloc_layout.dart';
import 'package:act_cms/presentation/screen/users/individual_user/bloc/bloc.dart';
import 'package:act_cms/presentation/widget/act_card_item_list.dart';
import 'package:act_cms/presentation/widget/act_data_grid.dart';
import 'package:act_cms/presentation/widget/act_pagination.dart';
import 'package:act_cms/presentation/widget/act_search_control_widget.dart';
import 'package:act_cms/presentation/widget/custom_dropdown.dart';
import 'package:act_cms/presentation/widget/main_app_bar.dart';
import 'package:act_cms/presentation/widget/search_bar.dart';
import 'package:act_cms/presentation/widget/user_item.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:number_paginator/number_paginator.dart';

@RoutePage()
class UsersScreen extends StatefulWidget {
  const UsersScreen({super.key});

  @override
  State<UsersScreen> createState() => _UsersState();
}

class _UsersState extends State<UsersScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final PageController pageController = PageController(initialPage: 0);
  final _numberPaginatorController = NumberPaginatorController();
  final TextEditingController searchTextController = TextEditingController();

  @override
  void dispose() {
    EasyLoading.dismiss();
    super.dispose();
  }

  void _onFireAdmin(int userId) async {
    final bloc = _scaffoldKey.currentContext?.read<UsersBloc>();
    if (bloc == null) return;
    await showDialog(
      context: context,
      builder: (context) => _buildDialog(
        message: "관리자에서 해지하시겠습니까?",
        actionButton: _buildDialogButton(
          onPressed: () {
            Navigator.pop(context, true);
          },
          buttonText: '해지',
          color: const Color(0xffFF0000),
        ),
      ),
    ).then((value) {
      if (value) {
        bloc.add(UsersEvent.addRoleToUserEvent(userId, "USER"));
      }
    });
  }

  void _assignAdmin(int userId) {
    final bloc = _scaffoldKey.currentContext?.read<UsersBloc>();
    if (bloc == null) return;

    showDialog(
      context: context,
      builder: (context) => _buildDialog(
        message: "관리자로 지정하시겠습니까?",
        actionButton: _buildDialogButton(
          onPressed: () {
            bloc.add(UsersEvent.assignAdminEvent(userId));
            Navigator.pop(context);
          },
          buttonText: '지정',
        ),
      ),
    );
  }

  void _onRefresh() {
    final bloc = _scaffoldKey.currentContext?.read<UsersBloc>();
    if (bloc == null) return;
    bloc.add(const UsersEvent.refresh());
  }

  void _moveDetailScreen(int userId) {
    context.router.pushNamed('userList/$userId').then((value) {
      if (value == true) _onRefresh();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BaseBlocLayout<UsersBloc, UsersState>(
      scaffoldKey: _scaffoldKey,
      create: (context) => UsersBloc()
        ..add(
          const UsersEvent.init(),
        ),
      listener: (context, state) {},
      builder: (context, bloc, state) {
        if (state.isLoading) {
          EasyLoading.show();
        }

        return _buildUserScreen(context, bloc, state);
      },
    );
  }

  Widget _buildUserScreen(BuildContext context, UsersBloc bloc, UsersState state) {
    return BlocListener<UsersBloc, UsersState>(
      listenWhen: (previousState, currentState) {
        return previousState.refreshPage != currentState.refreshPage;
      },
      listener: (context, state) {
        bloc.add(UsersEvent.fetchUsers(
          page: state.paging.page,
          size: apiLoadSize,
          searchKeyword: state.searchKeyword,
          searchCategory: state.selectedCategory,
        ));
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: MainAppBar(
          mainTitle: '유저(개인)',
          trailingWidgets: [
            Text(
              "총 ${(state.paging.total > state.totalCount ? state.paging.total : state.totalCount).toNumberFormat}명",
              style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500, color: Color(0xff666666)),
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 32, right: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomSearchBar(
                controller: searchTextController,
                onSearch: () {
                  bloc.add(UsersEvent.fetchUsers(
                    page: 1,
                    size: apiLoadSize,
                    searchKeyword: searchTextController.text,
                    searchCategory: state.selectedCategory,
                  ));
                  _numberPaginatorController.currentPage = 0;
                },
                onChange: (value) {
                  // bloc.add(PushListEvent.postOnSetSearchKeyword(value));
                },
                hintText: state.selectedCategory.placeholder,
                prefixWidget: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  // flex: 2, // Giving more width to dropdown
                  width: 200,
                  child: CustomDropdown<UserSearchCategory>(
                      value: state.selectedCategory,
                      items: UserSearchCategory.values.toList(),
                      getText: (UserSearchCategory value) => value.title,
                      onChanged: (UserSearchCategory? newValue) {
                        if (state.selectedCategory != newValue) {
                          bloc.add(UsersEvent.usersOnSelectCategory(newValue!));
                        }
                      }),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ActSearchControlWidget<UserFilterTypeWrapper>(
                    onTapControlButton: (UserFilterTypeWrapper curIndexFilterTypeWrapper) {
                      bloc.add(UsersEvent.changeFilterType(curIndexFilterTypeWrapper.userFilterType));
                    },
                    searchControlTypeWrapperList: state.userFilterTypeWrapperList,
                    selectedControlTypeWrapper: UserFilterTypeWrapper(
                      userFilterType: state.selectedFilterType,
                    ),
                  ),
                  ActSearchControlWidget<UserSortTypeWrapper>(
                    onTapControlButton: (UserSortTypeWrapper curIndexSortTypeWrapper) {
                      bloc.add(UsersEvent.changeSortType(curIndexSortTypeWrapper.userSortType));
                    },
                    searchControlTypeWrapperList: state.userSortTypeWrapperList,
                    selectedControlTypeWrapper: UserSortTypeWrapper(
                      userSortType: state.selectedSortType,
                    ),
                  ),
                ],
              ),
              if (state.userDataList.isNotEmpty) ...[
                const SizedBox(
                  height: 16.0,
                ),
                ActCardItemList(
                  totalSize: state.userDataList.length,
                  itemWidget: (int index) => _buildSimpleProfile(context, bloc, state, state.userDataList[index]),
                ),
              ],
              if (state.userDataList.isNotEmpty)
                ActPagination<UsersBloc, UsersState>(
                  paging: state.paging,
                  onPageChange: (int page) {
                    bloc.add(UsersEvent.fetchUsersLoadMore(
                      page: page,
                    ));
                  },
                )
            ],
          ),
        ),
      ),
    );
  }

  String formatPhoneNumber(String rawNumber) {
    // 숫자만 포함된 문자열을 기대합니다.
    if (rawNumber.length == 11) {
      return '${rawNumber.substring(0, 3)}-${rawNumber.substring(3, 7)}-${rawNumber.substring(7, 11)}';
    } else if (rawNumber.length == 10) {
      // 일부 번호는 10자리일 수 있습니다.
      return '${rawNumber.substring(0, 3)}-${rawNumber.substring(3, 6)}-${rawNumber.substring(6, 10)}';
    }
    return rawNumber; // 다른 길이의 번호는 수정하지 않고 반환합니다.
  }

  Widget _buildSimpleProfile(BuildContext context, UsersBloc bloc, UsersState state, User userData) {
    return UserItem(
      name: userData.name,
      number: formatPhoneNumber(userData.phoneNumber),
      nickname: userData.nickname,
      email: userData.email,
      profileImageUrl: userData.profileImageUrl,
      isAdmin: userData.isAdmin,
      isSolidarityLeader: userData.leadingSolidarityStockCodes!.isNotEmpty,
      actionButtons: [
        _buildUserButton(
          buttonText: '자세히 보기',
          color: const Color(0xff666666),
          onPressed: () => _moveDetailScreen(userData.id),
        ),
        const SizedBox(height: 12),
        if (userData.isAdmin)
          _buildUserButton(
            buttonText: "관리자 해지",
            color: const Color(0xffFF0000),
            onPressed: !(userData.isActiveStatus) ? null : () => _onFireAdmin(userData.id),
          ),
        if (!userData.isAdmin && userData.isActiveStatus)
          _buildUserButton(
            buttonText: "관리자 지정",
            color: AppTheme.primaryColor[700],
            onPressed: () => _assignAdmin(userData.id),
          ),
      ],
    );
  }

  Widget _buildUserButton({Color? color, required String buttonText, Function()? onPressed}) {
    final buttonColor = color ?? const Color(0xffFF0000);
    return OutlinedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        fixedSize: const Size(120, 40),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
        foregroundColor: buttonColor,
        backgroundColor: Colors.white,
        shadowColor: null,
        side: BorderSide(color: buttonColor, width: 0.7),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      child: Text(buttonText, style: TextStyle(color: buttonColor, fontSize: 12.0, fontWeight: FontWeight.w500)),
    );
  }

  Widget _buildDialog({Widget? actionButton, required String message}) {
    return Dialog(
      child: Container(
        width: 550,
        padding: const EdgeInsets.all(40),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
                height: 54, alignment: Alignment.center, child: Text(message, style: const TextStyle(fontSize: 16))),
            const SizedBox(height: 20),
            if (actionButton != null) actionButton
          ],
        ),
      ),
    );
  }

  Widget _buildDialogButton({
    required Function() onPressed,
    required String buttonText,
    Color? color,
  }) {
    final buttonColor = color ?? AppTheme.primaryColor[700];

    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: buttonColor, // Button text color
        minimumSize: const Size(double.infinity, 54),
      ),
      child: Text(buttonText, style: const TextStyle(fontSize: 16)),
    );
  }
}
