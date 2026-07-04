// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'aktivitas_item.dart';

// JsonSerializableGenerator

_AktivitasItem _$AktivitasItemFromJson(Map<String, dynamic> json) =>
    _AktivitasItem(
      id: json['id'] as String,
      namaMotor: json['namaMotor'] as String,
      tipeUnit: json['tipeUnit'] as String,
      dealer: json['dealer'] as String,
      imagePath: json['imagePath'] as String,
      tanggal: DateTime.parse(json['tanggal'] as String),
      tipe: $enumDecode(_$TipeTransaksiEnumMap, json['tipe']),
      status: $enumDecode(_$StatusAktivitasEnumMap, json['status']),
    );

Map<String, dynamic> _$AktivitasItemToJson(_AktivitasItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'namaMotor': instance.namaMotor,
      'tipeUnit': instance.tipeUnit,
      'dealer': instance.dealer,
      'imagePath': instance.imagePath,
      'tanggal': instance.tanggal.toIso8601String(),
      'tipe': _$TipeTransaksiEnumMap[instance.tipe]!,
      'status': _$StatusAktivitasEnumMap[instance.status]!,
    };

const _$TipeTransaksiEnumMap = {
  TipeTransaksi.cash: 'cash',
  TipeTransaksi.kredit: 'kredit',
};

const _$StatusAktivitasEnumMap = {
  StatusAktivitas.bookingBerhasil: 'bookingBerhasil',
  StatusAktivitas.verifikasiSales: 'verifikasiSales',
  StatusAktivitas.persiapanUnit: 'persiapanUnit',
  StatusAktivitas.pengiriman: 'pengiriman',
  StatusAktivitas.selesai: 'selesai',
  StatusAktivitas.ditolak: 'ditolak',
};
