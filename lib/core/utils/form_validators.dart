class FormValidators {
  static String? validateName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Nama belum diisi";
    }
    return null;
  }

  static String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Email belum diisi";
    }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value.trim())) {
      return "Format email tidak valid";
    }
    return null;
  }

  static String? validatePhone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Nomor HP belum diisi";
    }
    final phoneRegex = RegExp(r'^\+?[0-9]{9,15}$');
    if (!phoneRegex.hasMatch(value.trim())) {
      return "Format nomor HP tidak valid (hanya angka)";
    }
    return null;
  }

  static String? validateNik(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "NIK belum diisi";
    }
    if (value.trim().length < 15 || value.trim().length > 16) {
      return "NIK harus 15-16 digit";
    }
    final numRegex = RegExp(r'^[0-9]+$');
    if (!numRegex.hasMatch(value.trim())) {
      return "NIK hanya boleh berisi angka";
    }
    return null;
  }

  static String? validateAddress(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Alamat belum diisi";
    }
    if (value.trim().length < 5) {
      return "Alamat terlalu singkat";
    }
    return null;
  }
}
