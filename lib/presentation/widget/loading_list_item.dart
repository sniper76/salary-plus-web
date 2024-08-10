import 'package:flutter/material.dart';

class LoadingListItem extends StatelessWidget {
  const LoadingListItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 20,
        height: 20,
        margin: const EdgeInsets.symmetric(vertical: 6),
        child: const CircularProgressIndicator(),
      ),
    );
  }
}
