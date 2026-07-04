import 'package:flutter/material.dart';

@immutable
class UserProfile {
  final String nama;
  final String username;
  final String email;
  final String phone;
  final String nik;
  final String avatarPath;
  final bool isCustomAvatar;
  final Color avatarBgColor;
  final String initials;

  UserProfile({
    required this.nama,
    required this.username,
    required this.email,
    required this.phone,
    required this.nik,
    required this.avatarPath,
    this.isCustomAvatar = true, // Default to true (using initials) like modern apps
    Color? avatarBgColor,
    String? initials,
  })  : avatarBgColor = avatarBgColor ?? _getAvatarColor(nama),
        initials = initials ?? _getInitials(nama);

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

  UserProfile copyWith({
    String? nama,
    String? username,
    String? email,
    String? phone,
    String? nik,
    String? avatarPath,
    bool? isCustomAvatar,
    Color? avatarBgColor,
    String? initials,
  }) {
    return UserProfile(
      nama: nama ?? this.nama,
      username: username ?? this.username,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      nik: nik ?? this.nik,
      avatarPath: avatarPath ?? this.avatarPath,
      isCustomAvatar: isCustomAvatar ?? this.isCustomAvatar,
      avatarBgColor: avatarBgColor ?? this.avatarBgColor,
      initials: initials ?? this.initials,
    );
  }

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      nama: json['nama'] as String? ?? 'Pengguna Hondaku',
      username: json['username'] as String? ?? '',
      email: json['email'] as String? ?? '',
      phone: json['phone'] as String? ?? '-',
      nik: json['nik'] as String? ?? '-',
      avatarPath: json['avatarPath'] as String? ?? 'assets/images/profile.png',
      isCustomAvatar: json['isCustomAvatar'] as bool? ?? true,
      initials: json['initials'] as String?, // will fall back to auto-generated from name if null
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nama': nama,
      'username': username,
      'email': email,
      'phone': phone,
      'nik': nik,
      'avatarPath': avatarPath,
      'isCustomAvatar': isCustomAvatar,
      'initials': initials,
      // We don't save avatarBgColor to Firestore usually since it's UI specific, but we could save a hex
    };
  }
}
