import 'package:freezed_annotation/freezed_annotation.dart';

part 'aktivitas_item.freezed.dart';
part 'aktivitas_item.g.dart';

enum TipeTransaksi { cash, kredit }

enum StatusAktivitas {
  bookingBerhasil,
  verifikasiSales,
  persiapanUnit,
  pengiriman,
  selesai,
  ditolak,
}

@freezed
abstract class AktivitasItem with _$AktivitasItem {
  const factory AktivitasItem({
    required String id,
    required String namaMotor,
    required String tipeUnit,
    required String dealer,
    required String imagePath,
    required DateTime tanggal,
    required TipeTransaksi tipe,
    required StatusAktivitas status,
  }) = _AktivitasItem;

  factory AktivitasItem.fromJson(Map<String, dynamic> json) =>
      _$AktivitasItemFromJson(json);
}
