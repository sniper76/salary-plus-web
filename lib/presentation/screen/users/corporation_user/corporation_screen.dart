import 'package:act_cms/core/route/app_router.dart';
import 'package:act_cms/domain/model/enum/corporation_search_type.dart';
import 'package:act_cms/presentation/base/base_bloc_layout.dart';
import 'package:act_cms/presentation/screen/users/corporation_user/bloc/bloc.dart';
import 'package:act_cms/presentation/widget/act_card_item_list.dart';
import 'package:act_cms/presentation/widget/act_pagination.dart';
import 'package:act_cms/presentation/widget/button/act_event_button.dart';
import 'package:act_cms/presentation/widget/corporation_list_item.dart';
import 'package:act_cms/presentation/widget/custom_dropdown.dart';
import 'package:act_cms/presentation/widget/main_app_bar.dart';
import 'package:act_cms/presentation/widget/search_bar.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

@RoutePage()
class CorporationScreen extends StatefulWidget {
  const CorporationScreen({super.key});

  @override
  State<CorporationScreen> createState() => _CorporationScreenState();
}

class _CorporationScreenState extends State<CorporationScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _controller = TextEditingController();

  void _onSetSearchType(CorporationSearchType? newType) {
    final bloc = _scaffoldKey.currentContext?.read<CorporationListBloc>();
    if (bloc == null || newType == null) return;

    bloc.add(CorporationListEvent.setSearchType(newType));
  }

  void _onPageChange(int page) {
    final bloc = _scaffoldKey.currentContext?.read<CorporationListBloc>();
    if (bloc == null) return;

    bloc.add(CorporationListEvent.onGetCorporationList(page: page));
  }

  void _onSearch() {
    final bloc = _scaffoldKey.currentContext?.read<CorporationListBloc>();
    if (bloc == null) return;

    bloc.add(CorporationListEvent.onGetCorporationList(searchKeyword: _controller.text));
  }

  void _onCorporationRegister() {
    final bloc = _scaffoldKey.currentContext?.read<CorporationListBloc>();
    if (bloc == null) return;

    context.router.push(CorporationRegisterRoute()).then((res) {
      if (res == true) bloc.add(const CorporationListEvent.init());
    });
  }

  @override
  Widget build(BuildContext context) {
    return BaseBlocLayout<CorporationListBloc, CorporationListState>(
      scaffoldKey: _scaffoldKey,
      create: (context) => CorporationListBloc()
        ..add(
          const CorporationListEvent.init(),
        ),
      appBar: MainAppBar(
        mainTitle: '유저(법인)',
        trailingWidgets: [_buildCountCorporation()],
      ),
      builder: (context, bloc, state) {
        if (state.isLoading) {
          EasyLoading.show();
        }

        return Padding(
          padding: const EdgeInsets.only(left: 32, right: 32),
          child: Column(
            children: [
              _buildSearchBar(state),
              const SizedBox(height: 18),
              _buildRegisterButton(),
              const SizedBox(height: 18),
              ActCardItemList(
                itemWidget: (int index) {
                  final corporationUser = state.corporations[index];
                  return CorporationListItem(
                    corporation: corporationUser,
                    onTab: () {
                      context.router.push(
                          CorporationUserDetailRoute(corporationUser: corporationUser, userId: corporationUser.userId));
                    },
                  );
                },
                totalSize: state.corporations.length,
              ),
              if (state.corporations.isNotEmpty) _buildPagination(state)
            ],
          ),
        );
      },
    );
  }

  Widget _buildCountCorporation() {
    return BlocBuilder<CorporationListBloc, CorporationListState>(
      buildWhen: (CorporationListState previous, CorporationListState current) {
        return previous.corporations.length != current.corporations.length;
      },
      builder: (BuildContext context, CorporationListState state) {
        return Text(
          " 총 개수: ${state.corporations.length}",
          style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500, color: Color(0xff666666)),
        );
      },
    );
  }

  Widget _buildSearchBar(CorporationListState state) {
    return CustomSearchBar(
      controller: _controller,
      onSearch: _onSearch,
      onChange: (value) => {},
      prefixWidget: CustomDropdown<CorporationSearchType>(
        value: state.searchType,
        items: CorporationSearchType.values.where((type) => type != CorporationSearchType.unknown).toList(),
        getText: (value) => value.title,
        onChanged: _onSetSearchType,
      ),
    );
  }

  Widget _buildRegisterButton() {
    return Row(mainAxisAlignment: MainAxisAlignment.end, children: [
      ActEventButton(onPressed: _onCorporationRegister, size: const Size(140, 40), title: '법인 등록'),
    ]);
  }

  Widget _buildPagination(CorporationListState state) {
    return ActPagination<CorporationListBloc, CorporationListState>(
      paging: state.paging,
      onPageChange: _onPageChange,
    );
  }
}
