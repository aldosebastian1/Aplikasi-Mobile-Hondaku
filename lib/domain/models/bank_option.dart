import 'package:freezed_annotation/freezed_annotation.dart';

part 'bank_option.freezed.dart';
part 'bank_option.g.dart';

@freezed
abstract class BankOption with _$BankOption {
  const factory BankOption({
    required String name,
    required String logoPath,
  }) = _BankOption;

  factory BankOption.fromJson(Map<String, dynamic> json) =>
      _$BankOptionFromJson(json);
}
