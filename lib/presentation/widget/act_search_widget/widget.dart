import 'package:act_web/core/util/overlay_utils.dart';
import 'package:act_web/domain/model/stock/base_stock.dart';
import 'package:act_web/presentation/widget/act_search_widget/bloc/bloc.dart';
import 'package:act_web/presentation/widget/act_text_form_field.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class ActSearchWidget extends StatefulWidget {
  const ActSearchWidget({super.key});

  @override
  State<ActSearchWidget> createState() => _ActSearchWidgetState();
}

class _ActSearchWidgetState extends State<ActSearchWidget> {
  final TextEditingController _searchTextController = TextEditingController();
  final GlobalKey<_ActSearchWidgetState> textFieldKey = GlobalKey<_ActSearchWidgetState>();
  OverlayEntry? searchResultOverlay;

  @override
  void initState() {
    super.initState();
    if (GetIt.I.isRegistered<ActSearchWidgetBloc>() == false) GetIt.I.registerSingleton(ActSearchWidgetBloc());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ActSearchWidgetBloc, ActSearchWidgetState>(
      bloc: GetIt.I<ActSearchWidgetBloc>()..add(const ActSearchWidgetEvent.init()),
      builder: (context, state) {
        return ActTextFormField(
          key: textFieldKey,
          hintText: '종목명/종목코드를 입력해주세요',
          onChanged: (String value) {
            if (value.isEmpty) {
              removeOverlay();
              return;
            }

            final List<BaseStock> targetStocks = state.stocks.where((BaseStock stock) {
              return stock.code.contains(value) || stock.name.toUpperCase().contains(value.toUpperCase());
            }).toList();

            searchResultOverlay = OverlayUtils.createBaseStockOverlayForTextField(
              context: context,
              textFieldKey: textFieldKey,
              baseStockList: targetStocks,
              onListTap: (int index) {
                final BaseStock stock = targetStocks[index];
                GetIt.I<ActSearchWidgetBloc>().add(ActSearchWidgetEvent.searchStock(stock.code));
                removeOverlay();
                _searchTextController.clear();
                context.router.pushNamed('/stock/${stock.code}');
              },
              removeOverlay: removeOverlay,
            );
          },
          keyboardType: TextInputType.name,
          textInputAction: TextInputAction.next,
          controller: _searchTextController,
          borderColor: Colors.grey.shade500,
          suffixIcon: _searchTextController.text.isEmpty
              ? const SizedBox.shrink()
              : GestureDetector(
                  onTap: () => _searchTextController.clear(),
                  child: const Icon(
                    key: Key('delete_search_text'),
                    Icons.close,
                  ),
                ),
        );
      },
    );
  }

  void removeOverlay() {
    searchResultOverlay?.remove();
    searchResultOverlay = null;
  }

  @override
  void dispose() {
    GetIt.I.unregister<ActSearchWidgetBloc>();
    removeOverlay();
    super.dispose();
  }
}
