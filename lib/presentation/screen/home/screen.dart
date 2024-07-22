import 'package:act_web/config/constants.dart';
import 'package:act_web/domain/enum/board_group_type.dart';
import 'package:act_web/presentation/base/base_bloc_layout.dart';
import 'package:act_web/presentation/screen/home/bloc/bloc.dart';
import 'package:act_web/presentation/widget/act_download_widget/widget.dart';
import 'package:act_web/presentation/widget/act_footer_widget.dart';
import 'package:act_web/presentation/widget/act_ranking_widget/widget.dart';
import 'package:act_web/presentation/widget/default_act_web_app_bar.dart';
import 'package:act_web/presentation/widget/simple_post_list_widget.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

@RoutePage()
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
  }

  @override
  Widget build(BuildContext context) {
    return BaseBlocLayout<HomeBloc, HomeState>(
      appBarbuilder: (context, bloc, state) {
        return DefaultActWebAppBar();
      },
      backgroundColor: Colors.white,
      create: (_) => HomeBloc()..add(const HomeEvent.init()),
      listener: (context, state) {},
      builder: (context, bloc, state) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 100.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SimplePostListWidget(
                    titleSvgAssetPath: 'assets/images/ic_global_board.svg',
                    posts: state.globalBoardPosts,
                    boardGroupType: BoardGroupType.globalboard,
                  ),
                  const SizedBox(height: 100.0),
                  const SizedBox(
                    width: AppConfig.leftSectionWidth,
                    child: ActDownloadWidget(),
                  ),
                  const SizedBox(height: 150.0),
                  const ActFooterWidget(),
                ],
              ),
              const Column(
                children: [
                  SizedBox(
                    width: AppConfig.rankingWidgetWidth,
                    child: ActRankingWidget(),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
