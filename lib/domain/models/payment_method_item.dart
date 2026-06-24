import 'package:flutter/material.dart';

@immutable
class PaymentMethodItem {
  final String id;
  final String title;
  final String subtitle;
  final String logoPath;
  final bool isDefault;
  final String type; // e.g., 'VA', 'CARD', 'EWALLET'

  const PaymentMethodItem({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.logoPath,
    required this.isDefault,
    required this.type,
  });

  PaymentMethodItem copyWith({
    String? id,
    String? title,
    String? subtitle,
    String? logoPath,
    bool? isDefault,
    String? type,
  }) {
    return PaymentMethodItem(
      id: id ?? this.id,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      logoPath: logoPath ?? this.logoPath,
      isDefault: isDefault ?? this.isDefault,
      type: type ?? this.type,
    );
  }
}
