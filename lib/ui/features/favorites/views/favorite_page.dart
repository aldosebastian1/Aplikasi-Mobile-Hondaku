import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hondaku/core/utils/error_handler.dart';
import '../providers/favorite_provider.dart';
import '../../../core/widgets/motorcycle_card_widget.dart';
import '../../../../data/providers.dart'; // import motorcyclesProvider

class FavoritePage extends ConsumerWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoriteIds = ref.watch(favoriteProvider);
    final motorcyclesAsync = ref.watch(motorcyclesProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Wishlist Motor',
          style: TextStyle(
            color: Color(0xFF1A1A1A),
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.black87),
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(color: const Color(0xFFE9E9E9), height: 1),
        ),
      ),
      body: motorcyclesAsync.when(
        loading: () => const Center(child: CircularProgressIndicator(color: Color(0xFFC40000))),
        error: (err, stack) => Center(child: Text(AppErrorHandler.getMessage(err))),
        data: (allMotorcycles) {
          final favoriteMotors = allMotorcycles
              .where((motor) => favoriteIds.contains(motor.id))
              .toList();

          if (favoriteMotors.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.favorite_border,
                    size: 80,
                    color: Colors.grey.shade300,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Belum ada motor favorit',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black54,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Cari motor impian Anda dan simpan ke wishlist!',
                    style: TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () => context.go('/catalog'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFC40000),
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text('Cari Motor', style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: favoriteMotors.length,
            separatorBuilder: (context, index) => const SizedBox(height: 16),
            itemBuilder: (context, index) {
              final motor = favoriteMotors[index];
              return MotorcycleCardWidget(
                motor: motor,
                isCompact: true,
                parentIndex: 0,
              );
            },
          );
        },
      ),
    );
  }
}
