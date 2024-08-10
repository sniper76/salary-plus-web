import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  final VoidCallback onTap;

  const Logo({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: InkWell(
        onTap: onTap,
        child: Text(
            "Salary Plus",
            style: TextStyle(color: Colors.white, fontSize: 18),
        )
      ),
    );
  }
}
