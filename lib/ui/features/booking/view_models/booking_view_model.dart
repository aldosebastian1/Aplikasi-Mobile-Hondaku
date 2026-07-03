import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/utils/form_validators.dart';
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
    final nameError = FormValidators.validateName(nama);
    if (nameError != null) return nameError;

    final nikError = FormValidators.validateNik(nik);
    if (nikError != null) return nikError;

    final emailError = FormValidators.validateEmail(email);
    if (emailError != null) return emailError;

    if (selectedKecamatan == null) return "Kecamatan belum dipilih";
    if (selectedKelurahan == null) return "Kelurahan belum dipilih";

    final phoneError = FormValidators.validatePhone(phone);
    if (phoneError != null) return phoneError;

    final addressError = FormValidators.validateAddress(alamat);
    if (addressError != null) return addressError;

    return "";
  }
}

class BookingViewModel extends Notifier<BookingFormState> {
  @override
  BookingFormState build() {
    return const BookingFormState();
  }

  void updateNama(String nama) {
    state = state.copyWith(nama: nama, errorMessage: null);
  }

  void updateNik(String nik) {
    state = state.copyWith(nik: nik, errorMessage: null);
  }

  void updatePhone(String phone) {
    state = state.copyWith(phone: phone, errorMessage: null);
  }

  void updateEmail(String email) {
    state = state.copyWith(email: email, errorMessage: null);
  }

  void updateAlamat(String alamat) {
    state = state.copyWith(alamat: alamat, errorMessage: null);
  }

  void updateKecamatan(String? kecamatan) {
    state = state.copyWith(selectedKecamatan: kecamatan, errorMessage: null);
  }

  void updateKelurahan(String? kelurahan) {
    state = state.copyWith(selectedKelurahan: kelurahan, errorMessage: null);
  }

  void updatePaymentType({required bool isFullPayment}) {
    state = state.copyWith(isFullPayment: isFullPayment, errorMessage: null);
  }

  void updateSelectedPaymentMethodIndex(int index) {
    state = state.copyWith(selectedPaymentMethodIndex: index, errorMessage: null);
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
