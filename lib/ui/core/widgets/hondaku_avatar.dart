import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../features/profile/view_models/profile_view_model.dart';

class HondakuAvatar extends ConsumerWidget {
  final double radius;
  final double fontSize;

  const HondakuAvatar({
    super.key,
    this.radius = 20,
    this.fontSize = 12,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userProfile = ref.watch(userProfileProvider);
    if (userProfile.isCustomAvatar) {
      return CircleAvatar(
        radius: radius,
        backgroundColor: userProfile.avatarBgColor,
        child: Text(
          userProfile.initials,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: fontSize,
          ),
        ),
      );
    } else {
      if (userProfile.avatarPath.startsWith('http')) {
        return CircleAvatar(
          radius: radius,
          backgroundImage: NetworkImage(userProfile.avatarPath),
        );
      } else {
        return CircleAvatar(
          radius: radius,
          backgroundImage: AssetImage(userProfile.avatarPath),
        );
      }
    }
  }
}
