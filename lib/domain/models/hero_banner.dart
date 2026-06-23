import 'package:freezed_annotation/freezed_annotation.dart';

part 'hero_banner.freezed.dart';
part 'hero_banner.g.dart';

@freezed
abstract class HeroBanner with _$HeroBanner {
  const factory HeroBanner({
    required String image,
    required String tag,
    required String title1,
    required String title2,
    required String subtitle,
  }) = _HeroBanner;

  factory HeroBanner.fromJson(Map<String, dynamic> json) =>
      _$HeroBannerFromJson(json);
}
