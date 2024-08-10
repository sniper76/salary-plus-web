import 'package:act_cms/config/constants.dart';
import 'package:act_cms/config/theme.dart';
import 'package:act_cms/core/extension/context_extension.dart';
import 'package:act_cms/core/extension/datetime_extension.dart';
import 'package:act_cms/domain/model/enum/stop_word_status.dart';
import 'package:act_cms/domain/model/enum_wrapper/search_control_enum_wrapper/stop_word_search/stop_word_filter_type_wrapper.dart';
import 'package:act_cms/domain/model/enum_wrapper/search_control_enum_wrapper/stop_word_search/stop_word_sort_type_wrapper.dart';
import 'package:act_cms/domain/model/stop_word.dart';
import 'package:act_cms/presentation/base/base_bloc_layout.dart';
import 'package:act_cms/presentation/screen/stop_words/bloc/bloc.dart';
import 'package:act_cms/presentation/widget/act_data_grid.dart';
import 'package:act_cms/presentation/widget/act_pagination.dart';
import 'package:act_cms/presentation/widget/act_search_control_widget.dart';
import 'package:act_cms/presentation/widget/main_app_bar.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';

part 'handler.dart';
part 'widget/sections.dart';
part 'widget/status_change_button.dart';
part 'widget/stop_word_data_grid.dart';
part 'widget/stop_word_search_button.dart';
part 'widget/stop_word_create_button.dart';
part 'widget/stop_word_delete_button.dart';

@RoutePage()
class StopWordsScreen extends StatefulWidget {
  const StopWordsScreen({super.key});

  @override
  State<StopWordsScreen> createState() => _StopWordsState();
}

class _StopWordsState extends State<StopWordsScreen> {
  final TextEditingController searchTextController = TextEditingController();
  final TextEditingController dialogController = TextEditingController();

  @override
  void dispose() {
    EasyLoading.dismiss();
    searchTextController.dispose();
    dialogController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseBlocLayout<StopWordsBloc, StopWordsState>(
      backgroundColor: Colors.white,
      appBar: MainAppBar(
        mainTitle: AppConfig.stopWordText,
      ),
      create: (context) => StopWordsBloc()..add(const StopWordsEvent.init()),
      builder: (context, bloc, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: BlocListener<StopWordsBloc, StopWordsState>(
            listener: (context, state) => _listenStateChange(context, dialogController),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                _SearchBarSection(searchTextController: searchTextController),
                const SizedBox(
                  height: 10.0,
                ),
                _StopWordCreateButton(dialogController: dialogController),
                const SizedBox(
                  height: 10.0,
                ),
                _SearchControlSection(bloc: bloc),
                const SizedBox(
                  height: 10.0,
                ),
                _StopWordGridSection(state: state),
                if (state.stopWordList.isNotEmpty)
                  ActPagination<StopWordsBloc, StopWordsState>(
                    paging: state.paging,
                    onPageChange: (int page) {
                      bloc.add(StopWordsEvent.loadMore(
                        page: page,
                      ));
                    },
                  )
              ],
            ),
          ),
        );
      },
    );
  }
}
