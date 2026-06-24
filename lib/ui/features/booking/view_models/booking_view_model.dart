import 'package:flutter_riverpod/flutter_riverpod.dart';

class BookingFormState {
  final String nama;
  final String nik;
  final String phone;
  final String email;
  final String alamat;
  final String? selectedKecamatan;
  final String? selectedKelurahan;
  final bool isFullPayment;
  final String? errorMessage;
  final bool isSubmitting;
  final int selectedPaymentMethodIndex; // 0 for Cash, 1 for Credit

  const BookingFormState({
    this.nama = '',
    this.nik = '',
    this.phone = '',
    this.email = '',
    this.alamat = '',
    this.selectedKecamatan,
    this.selectedKelurahan,
    this.isFullPayment = false,
    this.errorMessage,
    this.isSubmitting = false,
    this.selectedPaymentMethodIndex = 0,
  });

  BookingFormState copyWith({
    String? nama,
    String? nik,
    String? phone,
    String? email,
    String? alamat,
    String? selectedKecamatan,
    String? selectedKelurahan,
    bool? isFullPayment,
    String? errorMessage,
    bool? isSubmitting,
    int? selectedPaymentMethodIndex,
  }) {
    return BookingFormState(
      nama: nama ?? this.nama,
      nik: nik ?? this.nik,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      alamat: alamat ?? this.alamat,
      selectedKecamatan: selectedKecamatan ?? this.selectedKecamatan,
      selectedKelurahan: selectedKelurahan ?? this.selectedKelurahan,
      isFullPayment: isFullPayment ?? this.isFullPayment,
      errorMessage: errorMessage ?? this.errorMessage,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      selectedPaymentMethodIndex: selectedPaymentMethodIndex ?? this.selectedPaymentMethodIndex,
    );
  }

  bool get isValid {
    return nama.trim().isNotEmpty &&
        nik.trim().length >= 15 &&
        phone.trim().isNotEmpty &&
        alamat.trim().isNotEmpty &&
        email.trim().contains('@') &&
        selectedKecamatan != null &&
        selectedKelurahan != null;
  }

  String get validationMessage {
    if (nama.trim().isEmpty) return "Nama belum diisi";
    if (nik.trim().length < 15) return "NIK harus minimal 15-16 digit";
    if (email.trim().isEmpty) return "Email belum diisi";
    if (!email.contains('@')) return "Format email tidak valid (butuh @)";
    if (selectedKecamatan == null) return "Kecamatan belum dipilih";
    if (selectedKelurahan == null) return "Kelurahan belum dipilih";
    if (phone.trim().isEmpty) return "Nomor HP belum diisi";
    if (alamat.trim().isEmpty) return "Alamat belum diisi";
    return "";
  }
}

class BookingViewModel extends Notifier<BookingFormState> {
  @override
  BookingFormState build() {
    return const BookingFormState();
  }

  void updateNama(String nama) {
    state = state.copyWith(nama: nama);
  }

  void updateNik(String nik) {
    state = state.copyWith(nik: nik);
  }

  void updatePhone(String phone) {
    state = state.copyWith(phone: phone);
  }

  void updateEmail(String email) {
    state = state.copyWith(email: email);
  }

  void updateAlamat(String alamat) {
    state = state.copyWith(alamat: alamat);
  }

  void updateKecamatan(String? kecamatan) {
    state = state.copyWith(selectedKecamatan: kecamatan);
  }

  void updateKelurahan(String? kelurahan) {
    state = state.copyWith(selectedKelurahan: kelurahan);
  }

  void updatePaymentType({required bool isFullPayment}) {
    state = state.copyWith(isFullPayment: isFullPayment);
  }

  void updateSelectedPaymentMethodIndex(int index) {
    state = state.copyWith(selectedPaymentMethodIndex: index);
  }

  bool submitForm() {
    if (!state.isValid) {
      state = state.copyWith(errorMessage: state.validationMessage);
      return false;
    }
    state = state.copyWith(errorMessage: null, isSubmitting: true);
    state = state.copyWith(isSubmitting: false);
    return true;
  }
}

final bookingViewModelProvider = NotifierProvider<BookingViewModel, BookingFormState>(() {
  return BookingViewModel();
});
