import 'package:act_cms/domain/model/enum/option_type.dart';
import 'package:flutter/material.dart';

class DigitalDocumentSelector extends StatefulWidget {
  final String title;
  final ValueChanged<OptionType> onSelectionChanged;

  const DigitalDocumentSelector({Key? key, required this.title, required this.onSelectionChanged}) : super(key: key);

  @override
  _DigitalDocumentSelectorState createState() => _DigitalDocumentSelectorState();
}

class _DigitalDocumentSelectorState extends State<DigitalDocumentSelector> {
  OptionType _selectedOption = OptionType.required; // Default selection

  @override
  Widget build(BuildContext context) {
    Color activeColor = const Color(0xFF0027A3);
    Color inactiveColor = const Color(0xFFD9D9D9);

    return Column(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.8, // Relative width
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                  width: 150, // Adjust flex as needed
                  child: Text(
                    widget.title,
                    style: const TextStyle(
                      color: Color(0xFF333333),
                      fontSize: 16,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w700,
                    ),
                  )),
              const SizedBox(width: 12),
              Expanded(
                flex: 2, // Adjust flex as needed
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _buildOption(OptionType.required, activeColor, inactiveColor, "left"),
                    const SizedBox(
                      width: 1,
                    ),
                    _buildOption(OptionType.optional, activeColor, inactiveColor, "middle"),
                    const SizedBox(
                      width: 1,
                    ),
                    _buildOption(OptionType.none, activeColor, inactiveColor, "right"),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildOption(OptionType option, Color activeColor, Color inactiveColor, String position) {
    return InkWell(
      onTap: () {
        if (_selectedOption != option) {
          widget.onSelectionChanged(option);
          setState(() => _selectedOption = option);
        }
      },
      child: position == "left"
          ? Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              clipBehavior: Clip.antiAlias,
              decoration: ShapeDecoration(
                color: _selectedOption == option ? activeColor : inactiveColor,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8),
                    bottomLeft: Radius.circular(8),
                  ),
                ),
              ),
              child: Center(
                child: Text(
                  option.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w700,
                    letterSpacing: -0.18,
                  ),
                ),
              ),
            )
          : position == "middle"
              ? Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  color: _selectedOption == OptionType.optional ? activeColor : inactiveColor,
                  child: Center(
                    child: Text(
                      OptionType.optional.title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w700,
                        letterSpacing: -0.18,
                      ),
                    ),
                  ),
                )
              : Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  clipBehavior: Clip.antiAlias,
                  decoration: ShapeDecoration(
                    color: _selectedOption == option ? activeColor : inactiveColor,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(8),
                        bottomRight: Radius.circular(8),
                      ),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      option.title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w700,
                        letterSpacing: -0.18,
                      ),
                    ),
                  ),
                ),
    );
  }
}
