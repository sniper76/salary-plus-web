import 'package:flutter/material.dart';

class AppTabBar extends StatelessWidget {
  final List<String> items;

  const AppTabBar({Key? key, required this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 2),
      decoration: BoxDecoration(
        color: const Color(0xffF2F4F7),
        borderRadius: BorderRadius.circular(50),
      ),
      child: TabBar(
        overlayColor: MaterialStateProperty.all(Colors.transparent),
        indicator: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: Colors.white,
          boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 20, offset: Offset(0, 0))],
        ),
        labelColor: Colors.black,
        unselectedLabelColor: Colors.black45,
        tabs: items.map((e) => Tab(text: e)).toList(),
      ),
    );
  }
}
