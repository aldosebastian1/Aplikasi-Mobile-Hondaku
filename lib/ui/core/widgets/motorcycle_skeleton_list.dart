import 'package:flutter/material.dart';

class MotorcycleSkeletonList extends StatelessWidget {
  final int count;
  final bool isCompact;
  final bool isSliver;

  const MotorcycleSkeletonList({
    super.key,
    this.count = 5,
    this.isCompact = true,
    this.isSliver = true,
  });

  @override
  Widget build(BuildContext context) {
    Widget buildItem() {
      return Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade100),
        ),
        child: Row(
          children: [
            Container(
              width: isCompact ? 100 : 120,
              height: isCompact ? 100 : 120,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(height: 16, width: double.infinity, color: Colors.grey.shade200),
                  const SizedBox(height: 8),
                  Container(height: 14, width: 120, color: Colors.grey.shade200),
                  const SizedBox(height: 16),
                  Container(height: 20, width: 140, color: Colors.grey.shade200),
                ],
              ),
            ),
          ],
        ),
      );
    }

    if (isSliver) {
      return SliverList(
        delegate: SliverChildBuilderDelegate(
          (_, i) => buildItem(),
          childCount: count,
        ),
      );
    } else {
      return ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: count,
        itemBuilder: (_, i) => buildItem(),
      );
    }
  }
}
