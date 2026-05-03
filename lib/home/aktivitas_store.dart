import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

enum TipeTransaksi { cash, kredit }

enum StatusAktivitas {
  menunggu,
  diproses,
  diverifikasi,
  disetujui,
  ditolak,
  selesai,
}

@immutable
class AktivitasItem {
  final String id;
  final String namaMotor;
  final String tipeUnit;
  final DateTime tanggal;
  final TipeTransaksi tipe;
  final StatusAktivitas status;

  const AktivitasItem({
    required this.id,
    required this.namaMotor,
    required this.tipeUnit,
    required this.tanggal,
    required this.tipe,
    required this.status,
  });

  AktivitasItem copyWith({
    String? id,
    String? namaMotor,
    String? tipeUnit,
    DateTime? tanggal,
    TipeTransaksi? tipe,
    StatusAktivitas? status,
  }) {
    return AktivitasItem(
      id: id ?? this.id,
      namaMotor: namaMotor ?? this.namaMotor,
      tipeUnit: tipeUnit ?? this.tipeUnit,
      tanggal: tanggal ?? this.tanggal,
      tipe: tipe ?? this.tipe,
      status: status ?? this.status,
    );
  }
}

class AktivitasStore {
  static final ValueNotifier<List<AktivitasItem>> items =
      ValueNotifier<List<AktivitasItem>>(<AktivitasItem>[]);

  static const Set<StatusAktivitas> _cashAllowed = {
    StatusAktivitas.menunggu,
    StatusAktivitas.diproses,
    StatusAktivitas.selesai,
  };

  static const Set<StatusAktivitas> _kreditAllowed = {
    StatusAktivitas.menunggu,
    StatusAktivitas.diverifikasi,
    StatusAktivitas.disetujui,
    StatusAktivitas.ditolak,
  };

  static void upsertCashCompleted({
    required String id,
    required String namaMotor,
    required String tipeUnit,
  }) {
    _upsert(
      AktivitasItem(
        id: id,
        namaMotor: namaMotor,
        tipeUnit: tipeUnit,
        tanggal: DateTime.now(),
        tipe: TipeTransaksi.cash,
        status: StatusAktivitas.selesai,
      ),
    );
  }

  static void upsertKreditSubmitted({
    required String id,
    required String namaMotor,
    required String tipeUnit,
  }) {
    _upsert(
      AktivitasItem(
        id: id,
        namaMotor: namaMotor,
        tipeUnit: tipeUnit,
        tanggal: DateTime.now(),
        tipe: TipeTransaksi.kredit,
        status: StatusAktivitas.diverifikasi,
      ),
    );
  }

  static StatusAktivitas _normalize(
    TipeTransaksi tipe,
    StatusAktivitas status,
  ) {
    if (tipe == TipeTransaksi.cash && !_cashAllowed.contains(status)) {
      return StatusAktivitas.menunggu;
    }
    if (tipe == TipeTransaksi.kredit && !_kreditAllowed.contains(status)) {
      return StatusAktivitas.menunggu;
    }
    return status;
  }

  static void _upsert(AktivitasItem incoming) {
    final normalized = incoming.copyWith(
      status: _normalize(incoming.tipe, incoming.status),
    );
    final current = List<AktivitasItem>.from(items.value);
    final index = current.indexWhere((e) => e.id == normalized.id);

    if (index >= 0) {
      current[index] = normalized;
    } else {
      current.insert(0, normalized);
    }

    items.value = current;
  }
}
