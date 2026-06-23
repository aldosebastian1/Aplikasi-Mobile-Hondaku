import 'package:freezed_annotation/freezed_annotation.dart';

part 'garage_item.freezed.dart';
part 'garage_item.g.dart';

@freezed
abstract class GarageItem with _$GarageItem {
  const factory GarageItem({
    required String id,
    required String name,
    required String type,
    required String imagePath,
    required String category,
  }) = _GarageItem;

  factory GarageItem.fromJson(Map<String, dynamic> json) =>
      _$GarageItemFromJson(json);
}
