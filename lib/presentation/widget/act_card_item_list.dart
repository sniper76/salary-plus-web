import 'package:flutter/material.dart';

class ActCardItemList extends StatefulWidget {
  const ActCardItemList({super.key, required this.itemWidget, required this.totalSize});

  final Widget Function(int index) itemWidget;
  final int totalSize;

  @override
  State<ActCardItemList> createState() => _ActCardItemListState();
}

class _ActCardItemListState extends State<ActCardItemList> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width * 0.8;
    double height = MediaQuery.of(context).size.height;

    bool changeView = width > height;
    return Expanded(
      child: GridView.builder(
        itemCount: widget.totalSize,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: changeView ? 2 : 1,
          childAspectRatio: changeView ? 4 / 1 : 2,
          mainAxisSpacing: 30,
          crossAxisSpacing: 30,
        ),
        itemBuilder: (BuildContext context, int index) {
          return _buildItem(
            child: widget.itemWidget(index),
          );
        },
      ),
    );
  }

  Widget _buildItem({required Widget child}) {
    return InkWell(
      onTap: () {},
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white, // 배경색
          borderRadius: const BorderRadius.all(Radius.circular(8.0)),
          border: Border.all(color: const Color(0xFFD9D9D9), width: 0.5),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 0,
              blurRadius: 11,
              offset: const Offset(0, 3), // 그림자 위치
            ),
          ],
        ),
        child: child,
      ),
    );
  }
}
