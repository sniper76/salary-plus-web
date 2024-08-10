part of '../screen.dart';

class _StockContainer extends StatelessWidget {
  final List<Widget> children;

  const _StockContainer({required this.children});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(defaultPadding),
      child: Container(
        width: 800,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(
            color: const Color(0xffD9D9D9), // Set border color
            width: 1.0, // Set border width
          ),
        ),
        child: Column(children: children),
      ),
    );
  }
}
