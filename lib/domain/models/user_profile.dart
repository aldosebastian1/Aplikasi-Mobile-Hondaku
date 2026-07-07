import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_profile.freezed.dart';
part 'user_profile.g.dart';

class ColorConverter implements JsonConverter<Color, int> {
  const ColorConverter();

  @override
  Color fromJson(int json) => Color(json);

  @override
  int toJson(Color object) => object.toARGB32();
}

@freezed
abstract class UserProfile with _$UserProfile {
  const UserProfile._();

  const factory UserProfile({
    @Default('Pengguna Hondaku') String nama,
    @Default('') String username,
    @Default('') String email,
    @Default('-') String phone,
    @Default('-') String nik,
    @Default('assets/images/profile.png') String avatarPath,
    @Default(true) bool isCustomAvatar,
    @ColorConverter() required Color avatarBgColor,
    required String initials,
  }) = _UserProfile;

  factory UserProfile.create({
    required String nama,
    required String username,
    required String email,
    required String phone,
    required String nik,
    required String avatarPath,
    bool isCustomAvatar = true,
    Color? avatarBgColor,
    String? initials,
  }) {
    return UserProfile(
      nama: nama,
      username: username,
      email: email,
      phone: phone,
      nik: nik,
      avatarPath: avatarPath,
      isCustomAvatar: isCustomAvatar,
      avatarBgColor: avatarBgColor ?? _getAvatarColor(nama),
      initials: initials ?? _getInitials(nama),
    );
  }

  factory UserProfile.fromJson(Map<String, dynamic> json) =>
      _$UserProfileFromJson(json);

  static String _getInitials(String name) {
    if (name.isEmpty) return 'U';
    final parts = name.trim().split(RegExp(r'\s+'));
    if (parts.length > 1) {
      return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    }
    return parts[0].substring(0, parts[0].length >= 2 ? 2 : 1).toUpperCase();
  }

  static Color _getAvatarColor(String name) {
    final colors = [
      const Color(0xFFE57373), // Red
      const Color(0xFFF06292), // Pink
      const Color(0xFFBA68C8), // Purple
      const Color(0xFF7986CB), // Indigo
      const Color(0xFF64B5F6), // Blue
      const Color(0xFF4FC3F7), // Light Blue
      const Color(0xFF4DB6AC), // Teal
      const Color(0xFF81C784), // Green
      const Color(0xFFFFB74D), // Orange
      const Color(0xFFFF8A65), // Deep Orange
    ];
    
    if (name.isEmpty) return colors[0];
    
    int hash = 0;
    for (int i = 0; i < name.length; i++) {
      hash = name.codeUnitAt(i) + ((hash << 5) - hash);
    }
    return colors[hash.abs() % colors.length];
  }
}
