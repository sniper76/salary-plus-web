import 'package:act_cms/core/extension/datetime_extension.dart';
import 'package:act_cms/domain/model/stock_reference_date.dart';
import 'package:act_cms/domain/model/user_stock_data.dart';
import 'package:act_cms/presentation/base/base_bloc_layout.dart';
import 'package:act_cms/presentation/screen/post/common/post_simple_stock_overlay.dart';
import 'package:act_cms/presentation/screen/stock/cmsDummyStock/bloc/bloc.dart';
import 'package:act_cms/presentation/widget/act_field_container.dart';
import 'package:act_cms/presentation/widget/act_round_based_widget.dart';
import 'package:act_cms/presentation/widget/custom_dropdown.dart';
import 'package:act_cms/presentation/widget/main_app_bar.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class CmsDummyStockScreen extends StatelessWidget {
  final int userId;

  CmsDummyStockScreen({super.key, required this.userId});

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final textFieldTargetKey = GlobalKey();
  final controller = TextEditingController();
  OverlayEntry? overlayEntry;

  _removeOverlay() {
    overlayEntry?.remove();
    overlayEntry = null;
  }

  _onCreateOverlayList(BuildContext context) {
    final currentContext = _scaffoldKey.currentContext;
    if (currentContext == null) return;
    final bloc = BlocProvider.of<CmsDummyBloc>(currentContext);
    final currentState = bloc.state;

    overlayEntry = createSimpleStockOverlay(
      context: context,
      textFieldKey: textFieldTargetKey,
      simpleStockList: currentState.simpleStockList.map((stock) => stock).toList(),
      onListTap: (int i) {
        controller.text = currentState.simpleStockList[i].name;
        bloc.add(CmsDummyEvent.onSelectedStock(currentState.simpleStockList[i]));
        _removeOverlay();
      },
      oldOverlayEntry: overlayEntry,
      removeOverlay: _removeOverlay,
      sidebarSize: 300,
    );
  }

  _onAddDummyStock() {
    final bloc = _scaffoldKey.currentContext?.read<CmsDummyBloc>();
    if (bloc == null) return;

    bloc.add(CmsDummyEvent.onAddDummyStock(userId));
  }

  @override
  Widget build(BuildContext context) {
    return BaseBlocLayout<CmsDummyBloc, CmsDummyState>(
      scaffoldKey: _scaffoldKey,
      backgroundColor: const Color(0xfff5f5f5),
      appBar: MainAppBar(mainTitle: "더미 데이터 추가하기", context: context),
      create: (context) => CmsDummyBloc()..add(const CmsDummyEvent.onInit()),
      listener: (BuildContext context, CmsDummyState state) {
        final stock = state.selectedStock;
        final referenceDate = state.selectedReferenceDate;
        if (state.isComplete && stock != null && referenceDate != null) {
          final dummyStock = UserStockData(
            code: stock.code,
            name: stock.name,
            quantity: 500,
            referenceDate: referenceDate.referenceDate,
            registerDate: DateTime.now(),
          );

          context.router.pop(dummyStock);
        }
      },
      builder: (BuildContext context, CmsDummyBloc bloc, CmsDummyState state) {
        return ActRoundBasedWidget(
            child: Column(
          children: [
            _buildSearchStock(context, bloc),
            const SizedBox(height: 12),
            _buildReferenceDate(bloc, state.referenceDates, state.selectedReferenceDate),
            const Spacer(),
            _buildRegisterButton(),
          ],
        ));
      },
    );
  }

  Widget _buildSearchStock(BuildContext context, CmsDummyBloc bloc) {
    return ActFieldContainer(
      title: '종목',
      children: [
        BlocListener<CmsDummyBloc, CmsDummyState>(
          listenWhen: (previousState, currentState) => previousState.simpleStockList != currentState.simpleStockList,
          listener: (context, state) {
            if (state.simpleStockList.isNotEmpty) {
              _onCreateOverlayList(context);
            } else {
              _removeOverlay();
            }
          },
          child: Expanded(
            child: TextField(
              key: textFieldTargetKey,
              controller: controller,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: const BorderSide(color: Color(0xffD9D9D9)),
                ),
              ),
              onChanged: (searchText) {
                bloc.add(CmsDummyEvent.onSearchKeyword(searchText));
              },
              onTap: () => _onCreateOverlayList(context),
            ),
          ),
        )
      ],
    );
  }

  Widget _buildReferenceDate(
      CmsDummyBloc bloc, List<StockReferenceDate> referenceDates, StockReferenceDate? selectedReferenceDate) {
    return ActFieldContainer(
      title: '기준일',
      children: [
        CustomDropdown<StockReferenceDate?>(
          value: referenceDates.contains(selectedReferenceDate) ? selectedReferenceDate : null,
          items: referenceDates,
          getText: (value) => value!.referenceDate.toFormatString(),
          hintText: '기준일 선택',
          onChanged: (newValue) {
            if (newValue != null) {
              bloc.add(CmsDummyEvent.onSelectedReferenceDate(newValue));
            }
          },
        )
      ],
    );
  }

  Widget _buildRegisterButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [ElevatedButton(onPressed: _onAddDummyStock, child: const Text('등록'))],
    );
  }
}
