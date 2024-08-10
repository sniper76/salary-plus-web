import 'package:flutter/material.dart';

class MultiButtons<T> extends StatefulWidget {
  final String title;
  final List<T> buttonList;
  final ValueChanged<T> onSelectionChanged;
  final String Function(T option) getTitle;
  final double? labelSize;

  const MultiButtons({
    Key? key,
    required this.title,
    required this.onSelectionChanged,
    required this.buttonList,
    required this.getTitle,
    this.labelSize,
  }) : super(key: key);

  @override
  _MultiButtonsState createState() => _MultiButtonsState<T>();
}

class _MultiButtonsState<T> extends State<MultiButtons<T>> {
  late T _selectedOption = widget.buttonList.first;
  final titleTextStyle =
      const TextStyle(color: Color(0xFF333333), fontSize: 16, fontFamily: 'Inter', fontWeight: FontWeight.w700);
  final decoration = const ShapeDecoration(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8))),
  );

  final buttonTextStyle = const TextStyle(
    color: Colors.white,
    fontSize: 12,
    fontFamily: 'Inter',
    fontWeight: FontWeight.w700,
    letterSpacing: -0.18,
  );

  _getSelectedColor(bool isSelected) => isSelected ? const Color(0xFF0027A3) : const Color(0xFFD9D9D9);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _buildLabel(),
        const SizedBox(width: 30),
        Container(
          clipBehavior: Clip.hardEdge,
          decoration: decoration,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: widget.buttonList.map((e) => _buildOption(e)).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildLabel() {
    return SizedBox(width: widget.labelSize, child: Text(widget.title, style: titleTextStyle));
  }

  Widget _buildOption(T option) {
    return InkWell(
      onTap: () {
        if (_selectedOption != option) {
          widget.onSelectionChanged(option);
          setState(() => _selectedOption = option);
        }
      },
      child: _buildButton(buttonText: widget.getTitle(option), isSelected: _selectedOption == option),
    );
  }

  Widget _buildButton({required String buttonText, required bool isSelected}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      margin: const EdgeInsets.only(right: 1),
      color: _getSelectedColor(isSelected),
      child: Center(child: Text(buttonText, style: buttonTextStyle)),
    );
  }
}
