import 'package:act_web/domain/model/stock/solidarity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MySolidarityOrderItemWidget extends StatelessWidget {
  final Solidarity solidarity;
  final int index;
  final Function(int) onClickUpButton;
  final Function(int) onClickDownButton;
  final Function(int) onClickTopButton;
  final Function(int) onClickBottomButton;

  const MySolidarityOrderItemWidget({
    super.key,
    required this.solidarity,
    required this.index,
    required this.onClickUpButton,
    required this.onClickDownButton,
    required this.onClickTopButton,
    required this.onClickBottomButton,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      key: key,
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(solidarity.name),
          Row(
            children: [
              InkWell(
                onTap: () {
                  onClickTopButton(index);
                },
                child: SvgPicture.asset(
                  'assets/images/ic_arrow_to_end.svg',
                  width: 22,
                ),
              ),
              const SizedBox(width: 8.0),
              InkWell(
                onTap: () {
                  onClickBottomButton(index);
                },
                child: Transform.flip(
                  flipY: true,
                  child: SvgPicture.asset(
                    'assets/images/ic_arrow_to_end.svg',
                    width: 22,
                  ),
                ),
              ),
              const SizedBox(width: 8.0),
              InkWell(
                onTap: () {
                  onClickUpButton(index);
                },
                child: SvgPicture.asset(
                  'assets/images/ic_arrow.svg',
                  width: 16,
                ),
              ),
              const SizedBox(width: 8.0),
              InkWell(
                onTap: () {
                  onClickDownButton(index);
                },
                child: Transform.flip(
                  flipY: true,
                  child: SvgPicture.asset(
                    'assets/images/ic_arrow.svg',
                    width: 16,
                  ),
                ),
              ),
              const SizedBox(width: 8.0),
              ReorderableDragStartListener(
                index: index,
                child: const Icon(Icons.drag_indicator),
              ),
            ],
          )
        ],
      ),
    );
  }
}
