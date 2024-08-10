import 'package:act_cms/domain/model/board_group_category.dart';
import 'package:act_cms/presentation/screen/event_board/widget/list/widget.dart';
import 'package:act_cms/presentation/widget/main_app_bar.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class CampaignScreen extends StatelessWidget {
  const CampaignScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: MainAppBar(
        mainTitle: BoardGroupCategory.campaign().displayName,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: EventBoardList(
          boardGroupCategory: BoardGroupCategory.campaign(),
        ),
      ),
    );
  }
}
