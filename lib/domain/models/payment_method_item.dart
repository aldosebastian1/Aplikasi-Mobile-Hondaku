import 'package:freezed_annotation/freezed_annotation.dart';

part 'payment_method_item.freezed.dart';
part 'payment_method_item.g.dart';

@freezed
abstract class PaymentMethodItem with _$PaymentMethodItem {
  const factory PaymentMethodItem({
    required String id,
    required String title,
    required String subtitle,
    required String logoPath,
    @Default(false) bool isDefault,
    required String type, // e.g., 'VA', 'CARD', 'EWALLET'
  }) = _PaymentMethodItem;

  factory PaymentMethodItem.fromJson(Map<String, dynamic> json) => _$PaymentMethodItemFromJson(json);
}
