import 'package:flutter/material.dart';

class CustomRefreshIndicator extends StatelessWidget {
  final Future<void> Function() onRefresh;
  final Widget child;
  final double edgeOffset;

  const CustomRefreshIndicator({
    super.key,
    required this.onRefresh,
    required this.child,
    this.edgeOffset = 110.0,
  });

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh,
      color: const Color(0xFFC40000), // Honda Red
      backgroundColor: Colors.white,
      edgeOffset: edgeOffset,
      strokeWidth: 3.0,
      displacement: 40.0,
      child: child,
    );
  }
}
