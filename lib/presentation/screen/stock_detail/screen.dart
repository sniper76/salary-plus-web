import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class StockDetailScreen extends StatefulWidget {
  final String stockCode;

  const StockDetailScreen({
    super.key,
    @pathParam required this.stockCode,
  });

  @override
  State<StockDetailScreen> createState() => _StockDetailScreenState();
}

// TODO: need refactoring
class _StockDetailScreenState extends State<StockDetailScreen> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return const AutoRouter();
  }
}
