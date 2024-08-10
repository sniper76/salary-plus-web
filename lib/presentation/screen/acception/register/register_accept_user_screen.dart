import 'package:act_cms/core/extension/context_extension.dart';
import 'package:act_cms/domain/model/accept_user.dart';
import 'package:act_cms/domain/model/enum/corporation_search_type.dart';
import 'package:act_cms/domain/model/enum/user_search_category.dart';
import 'package:act_cms/domain/model/enum/user_type.dart';
import 'package:act_cms/domain/model/paging.dart';
import 'package:act_cms/presentation/base/base_bloc_layout.dart';
import 'package:act_cms/presentation/screen/acception/register/bloc/bloc.dart';
import 'package:act_cms/presentation/widget/act_card_item_list.dart';
import 'package:act_cms/presentation/widget/act_pagination.dart';
import 'package:act_cms/presentation/widget/custom_dropdown.dart';
import 'package:act_cms/presentation/widget/search_bar.dart';
import 'package:act_cms/presentation/widget/sub_app_bar.dart';
import 'package:act_cms/presentation/widget/user_item.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class RegisterAcceptUserScreen extends StatelessWidget {
  final String stockCode;

  RegisterAcceptUserScreen({super.key, required this.stockCode});

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  void _onChangeUserType(UserType? userType) {
    final bloc = _scaffoldKey.currentContext?.read<RegisterAcceptUserBloc>();
    if (bloc == null || userType == null) return;

    bloc.add(RegisterAcceptUserEvent.onChangeCategories(userType: userType));
  }

  void _onChangeCorporationSearchType(CorporationSearchType? corporationSearchType) {
    final bloc = _scaffoldKey.currentContext?.read<RegisterAcceptUserBloc>();
    if (bloc == null || corporationSearchType == null) return;

    bloc.add(RegisterAcceptUserEvent.onChangeCategories(corporationSearchType: corporationSearchType));
  }

  void _onChangeUserSearchCategory(UserSearchCategory? individualSearchType) {
    final bloc = _scaffoldKey.currentContext?.read<RegisterAcceptUserBloc>();
    if (bloc == null || individualSearchType == null) return;

    bloc.add(RegisterAcceptUserEvent.onChangeCategories(individualSearchType: individualSearchType));
  }

  void _onChangeSearchKeyword(String searchKeyword) {
    final bloc = _scaffoldKey.currentContext?.read<RegisterAcceptUserBloc>();
    if (bloc == null) return;

    bloc.add(RegisterAcceptUserEvent.onChangeSearchKeyword(searchKeyword));
  }

  void _onSearchList(UserType userType) {
    final bloc = _scaffoldKey.currentContext?.read<RegisterAcceptUserBloc>();
    if (bloc == null) return;

    bloc.add(const RegisterAcceptUserEvent.onGetUserList());
  }

  void _onChangePaging(int page) {
    final bloc = _scaffoldKey.currentContext?.read<RegisterAcceptUserBloc>();
    if (bloc == null) return;

    bloc.add(RegisterAcceptUserEvent.onChangePaging(page));
  }

  void _onAssignAcceptUser(AcceptUser acceptUser) {
    final bloc = _scaffoldKey.currentContext?.read<RegisterAcceptUserBloc>();
    if (bloc == null) return;

    bloc.add(RegisterAcceptUserEvent.onAssignAcceptUser(acceptUser: acceptUser, stockCode: stockCode));
  }

  void _onOpenAcceptUserDialog(BuildContext context, AcceptUser acceptUser) async {
    final res = await context.showConfirmDialog(title: '수임인 선임', message: '수임인을 선임하시겠습니까?');

    if (res == true) _onAssignAcceptUser(acceptUser);
  }

  @override
  Widget build(BuildContext context) {
    return BaseBlocLayout<RegisterAcceptUserBloc, RegisterAcceptUserState>(
      scaffoldKey: _scaffoldKey,
      create: (BuildContext context) => RegisterAcceptUserBloc(),
      listener: (BuildContext context, RegisterAcceptUserState state) {
        if (state.isComplete) context.router.pop(true);
      },
      appBar: SubAppBar(title: '수임인 선임하기', context: context),
      builder: (BuildContext context, RegisterAcceptUserBloc bloc, RegisterAcceptUserState state) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
          child: Column(
            children: [
              _buildSearchBar(
                userType: state.userType,
                corporationSearchType: state.corporationSearchType,
                individualSearchType: state.individualSearchType,
              ),
              const SizedBox(height: 20),
              _buildList(context, state.acceptUser),
              if (state.acceptUser.isNotEmpty) _buildPagination(state.paging),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSearchBar({
    required UserType userType,
    required CorporationSearchType corporationSearchType,
    required UserSearchCategory individualSearchType,
  }) {
    return CustomSearchBar(
      onSearch: () => _onSearchList(userType),
      onChange: _onChangeSearchKeyword,
      prefixWidget: _buildSearchCategories(userType, corporationSearchType, individualSearchType),
    );
  }

  Widget _buildSearchCategories(
    UserType userType,
    CorporationSearchType corporationSearchType,
    UserSearchCategory individualSearchType,
  ) {
    return Wrap(
      spacing: 6,
      children: [
        CustomDropdown<UserType>(
          value: userType,
          items: UserType.values,
          getText: (value) => value.title,
          onChanged: _onChangeUserType,
        ),
        if (userType == UserType.individual)
          CustomDropdown<UserSearchCategory>(
            value: individualSearchType,
            items: UserSearchCategory.values.toList(),
            getText: (UserSearchCategory value) => value.title,
            onChanged: _onChangeUserSearchCategory,
          ),
        if (userType == UserType.corporation)
          CustomDropdown<CorporationSearchType>(
            value: corporationSearchType,
            items: CorporationSearchType.values.where((type) => type != CorporationSearchType.unknown).toList(),
            getText: (value) => value.title,
            onChanged: _onChangeCorporationSearchType,
          ),
      ],
    );
  }

  Widget _buildList(BuildContext context, List<AcceptUser> userList) {
    return ActCardItemList(
      itemWidget: (int index) {
        final user = userList[index];
        return UserItem(
          name: user.name,
          number: user.uniqueNumber,
          nickname: user.nickname,
          email: user.email,
          profileImageUrl: user.profileImageUrl,
          isAdmin: user.isAdmin,
          isSolidarityLeader: user.isSolidarityLeader,
          actionButtons: [
            ElevatedButton(onPressed: () => _onOpenAcceptUserDialog(context, user), child: const Text('선택'))
          ],
        );
      },
      totalSize: userList.length,
    );
  }

  Widget _buildPagination(Paging paging) {
    return ActPagination<RegisterAcceptUserBloc, RegisterAcceptUserState>(
      paging: paging,
      onPageChange: _onChangePaging,
    );
  }
}
