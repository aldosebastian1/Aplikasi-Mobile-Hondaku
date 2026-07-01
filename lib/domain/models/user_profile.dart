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

  const UserProfile({
    required this.nama,
    required this.username,
    required this.email,
    required this.phone,
    required this.nik,
    required this.avatarPath,
    this.isCustomAvatar = false,
    this.avatarBgColor = const Color(0xFFC40000),
    this.initials = 'PH',
  });

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
      isCustomAvatar: json['isCustomAvatar'] as bool? ?? false,
      // For color and initials we can reconstruct them or use defaults
      initials: json['initials'] as String? ?? 'PH',
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
