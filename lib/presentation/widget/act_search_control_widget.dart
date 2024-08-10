import 'package:act_cms/domain/model/enum_wrapper/search_control_enum_wrapper/search_control_enum_wrapper.dart';
import 'package:flutter/material.dart';

class ActSearchControlWidget<T extends SearchControlEnumWrapper> extends StatelessWidget {
  final Function onTapControlButton;
  final List<T> searchControlTypeWrapperList;
  final T selectedControlTypeWrapper;

  const ActSearchControlWidget({
    required this.onTapControlButton,
    required this.searchControlTypeWrapperList,
    required this.selectedControlTypeWrapper,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 16.0,
      children: List.generate(searchControlTypeWrapperList.length, (index) {
        final T curIndexControlTypeWrapper = searchControlTypeWrapperList[index];
        return _buildControlButton(onTapControlButton, curIndexControlTypeWrapper);
      }),
    );
  }

  Widget _buildControlButton(Function onTapControlButton, T curIndexControlTypeWrapper) {
    return InkWell(
      borderRadius: BorderRadius.circular(4.0),
      onTap: () {
        onTapControlButton(curIndexControlTypeWrapper);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        child: Text(
          curIndexControlTypeWrapper.label,
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: selectedControlTypeWrapper.label == curIndexControlTypeWrapper.label ? Colors.black : Colors.grey,
          ),
        ),
      ),
    );
  }
}
