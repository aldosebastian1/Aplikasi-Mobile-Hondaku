import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../view_models/booking_view_model.dart';
import '../../../../data/motorcycle_data.dart';

class BookingFormPage extends ConsumerStatefulWidget {
  final Motorcycle motor;
  const BookingFormPage({super.key, required this.motor});

  @override
  ConsumerState<BookingFormPage> createState() => _BookingFormPageState();
}

class _BookingFormPageState extends ConsumerState<BookingFormPage> {
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _nikController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _alamatController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  final FocusNode _namaFocusNode = FocusNode();
  final FocusNode _nikFocusNode = FocusNode();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _phoneFocusNode = FocusNode();
  final FocusNode _alamatFocusNode = FocusNode();

  bool _isNavigating = false;

  static const List<String> _kecamatanList = [
    'Medan Kota',
    'Medan Baru',
    'Medan Petisah',
    'Medan Sunggal',
    'Medan Helvetia',
    'Medan Johor',
    'Medan Amplas',
    'Medan Denai',
    'Medan Tembung',
    'Medan Timur',
  ];

  static const List<String> _kelurahanList = [
    'Suka Maju',
    'Suka Ramai',
    'Pandau Hulu',
    'Sei Agul',
    'Pulo Brayan',
  ];

  @override
  void initState() {
    super.initState();
    _namaController.addListener(() {
      ref.read(bookingViewModelProvider.notifier).updateNama(_namaController.text);
    });
    _nikController.addListener(() {
      ref.read(bookingViewModelProvider.notifier).updateNik(_nikController.text);
    });
    _phoneController.addListener(() {
      ref.read(bookingViewModelProvider.notifier).updatePhone(_phoneController.text);
    });
    _alamatController.addListener(() {
      ref.read(bookingViewModelProvider.notifier).updateAlamat(_alamatController.text);
    });
    _emailController.addListener(() {
      ref.read(bookingViewModelProvider.notifier).updateEmail(_emailController.text);
    });
  }

  @override
  void dispose() {
    _namaController.dispose();
    _nikController.dispose();
    _phoneController.dispose();
    _alamatController.dispose();
    _emailController.dispose();
    _namaFocusNode.dispose();
    _nikFocusNode.dispose();
    _emailFocusNode.dispose();
    _phoneFocusNode.dispose();
    _alamatFocusNode.dispose();
    super.dispose();
  }

  String? get _selectedKecamatan => ref.watch(bookingViewModelProvider).selectedKecamatan;
  String? get _selectedKelurahan => ref.watch(bookingViewModelProvider).selectedKelurahan;
  bool get _isFullPayment => ref.watch(bookingViewModelProvider).isFullPayment;

  String _getValidationMessage() => ref.read(bookingViewModelProvider).validationMessage;

  // ─────────────────────────────────────────────────────────
  // BUILD
  // ─────────────────────────────────────────────────────────
  @override
  Widget build(BuildContext context) {
    final bookingState = ref.watch(bookingViewModelProvider);
    final errorMessage = bookingState.errorMessage;
    
    final nameError = errorMessage == "Nama belum diisi" ? errorMessage : null;
    final nikError = errorMessage == "NIK harus minimal 15-16 digit" ? errorMessage : null;
    final emailError = (errorMessage == "Email belum diisi" || errorMessage == "Format email tidak valid (butuh @)") ? errorMessage : null;
    final kecamatanError = errorMessage == "Kecamatan belum dipilih" ? errorMessage : null;
    final kelurahanError = errorMessage == "Kelurahan belum dipilih" ? errorMessage : null;
    final phoneError = errorMessage == "Nomor HP belum diisi" ? errorMessage : null;
    final alamatError = errorMessage == "Alamat belum diisi" ? errorMessage : null;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: _buildAppBar(),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                color: Colors.white,
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(16, 20, 16, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildProductCard(),
                    const SizedBox(height: 20),
                    _buildPaymentTypeSelector(),
                    const SizedBox(height: 16),
                    _buildPaymentDetailCard(),
                    const SizedBox(height: 24),
                    _buildPageHeader(),
                    const SizedBox(height: 16),

                    // ── Informasi Identitas ──
                    _buildSectionTitle(
                      iconWidget: _buildIdCardIcon(),
                      title: 'Informasi Identitas (KTP)',
                    ),
                    const SizedBox(height: 14),
                    _buildLabel('Nama Lengkap (Sesuai KTP)'),
                    const SizedBox(height: 6),
                    _buildInputField(
                      controller: _namaController,
                      hint: 'Contoh: Budi Setiawan',
                      semanticsLabel: 'Nama Lengkap (Sesuai KTP)',
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.next,
                      focusNode: _namaFocusNode,
                      onSubmitted: (_) => FocusScope.of(context).requestFocus(_nikFocusNode),
                      errorText: nameError,
                    ),
                    const SizedBox(height: 14),
                    _buildLabel('Nomor NIK'),
                    const SizedBox(height: 6),
                    _buildInputField(
                      controller: _nikController,
                      hint: '16 digit angka KTP',
                      semanticsLabel: 'Nomor NIK',
                      keyboardType: TextInputType.number,
                      formatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(16),
                      ],
                      textInputAction: TextInputAction.next,
                      focusNode: _nikFocusNode,
                      onSubmitted: (_) => FocusScope.of(context).requestFocus(_emailFocusNode),
                      errorText: nikError,
                    ),
                    const SizedBox(height: 14),
                    _buildLabel('Email Address'),
                    const SizedBox(height: 6),
                    _buildInputField(
                      controller: _emailController,
                      hint: 'contoh@email.com',
                      semanticsLabel: 'Email Address',
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      focusNode: _emailFocusNode,
                      onSubmitted: (_) => FocusScope.of(context).requestFocus(_phoneFocusNode),
                      errorText: emailError,
                    ),
                    const SizedBox(height: 22),

                    // ── Domisili ──
                    _buildSectionTitle(
                      iconWidget: const Icon(
                        Icons.location_on,
                        color: Color(0xFFD32F2F),
                        size: 18,
                      ),
                      title: 'Domisili Medan',
                    ),
                    const SizedBox(height: 14),
                    _buildLabel('Kecamatan'),
                    const SizedBox(height: 6),
                    _buildDropdown(
                      value: _selectedKecamatan,
                      hint: 'Pilih Kecamatan',
                      semanticsLabel: 'Kecamatan',
                      items: _kecamatanList,
                      onChanged: (v) => ref.read(bookingViewModelProvider.notifier).updateKecamatan(v),
                      errorText: kecamatanError,
                    ),
                    const SizedBox(height: 14),
                    _buildLabel('Kelurahan'),
                    const SizedBox(height: 6),
                    _buildDropdown(
                      value: _selectedKelurahan,
                      hint: 'Pilih Kelurahan',
                      semanticsLabel: 'Kelurahan',
                      items: _kelurahanList,
                      onChanged: (v) => ref.read(bookingViewModelProvider.notifier).updateKelurahan(v),
                      errorText: kelurahanError,
                    ),
                    const SizedBox(height: 14),
                    _buildLabel('No. HP (WhatsApp Aktif)'),
                    const SizedBox(height: 6),
                    _buildPhoneField(
                      focusNode: _phoneFocusNode,
                      textInputAction: TextInputAction.next,
                      onSubmitted: (_) => FocusScope.of(context).requestFocus(_alamatFocusNode),
                      errorText: phoneError,
                    ),
                    const SizedBox(height: 14),
                    _buildLabel('Alamat Pengiriman (Medan)'),
                    const SizedBox(height: 6),
                    _buildInputField(
                      controller: _alamatController,
                      hint: 'Jl. Ahmad Yani No. 123, Medan',
                      semanticsLabel: 'Alamat Pengiriman (Medan)',
                      keyboardType: TextInputType.streetAddress,
                      textInputAction: TextInputAction.done,
                      focusNode: _alamatFocusNode,
                      onSubmitted: (_) => FocusScope.of(context).unfocus(),
                      errorText: alamatError,
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ),
          // Fixed Bottom Section
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 10,
                  offset: const Offset(0, -5),
                ),
              ],
            ),
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 28),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildBottomBar(),
                const SizedBox(height: 12),
                _buildPilihBookingButton(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ─────────────────────────────────────────────────────────
  // APPBAR
  // ─────────────────────────────────────────────────────────
  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
      leading: IconButton(
        icon: const ExcludeSemantics(
          child: Icon(Icons.arrow_back, color: Colors.black, size: 22),
        ),
        onPressed: () => Navigator.maybePop(context),
        tooltip: 'Kembali',
      ),
      title: const Text(
        'Metode Pembayaran',
        style: TextStyle(
          color: Colors.black,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
      actions: [
        IconButton(
          icon: const ExcludeSemantics(
            child: Icon(Icons.info_outline, color: Colors.black, size: 22),
          ),
          tooltip: 'Panduan Pengisian Form',
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Panduan Pengisian Form'),
                content: const Text(
                  'Harap isi data Anda dengan benar sesuai dengan KTP untuk mempercepat proses verifikasi oleh pihak dealer:\n\n'
                  '• Nama Lengkap: Sesuai yang tertera pada KTP.\n'
                  '• NIK: 16 digit nomor induk kependudukan.\n'
                  '• Email: Pastikan aktif untuk menerima salinan kwitansi/invoice.\n'
                  '• Alamat Pengiriman: Lokasi tujuan pengiriman unit motor di wilayah Medan.',
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Tutup', style: TextStyle(color: Color(0xFFD32F2F))),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }


  // ─────────────────────────────────────────────────────────
  // PRODUCT CARD
  // ─────────────────────────────────────────────────────────
  Widget _buildProductCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFEEEEEE)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 15,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          // 1. Image Section
          Container(
            width: 110,
            height: 85,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFFF9F9F9),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Image.asset(
              widget.motor.imageAsset,
              semanticLabel: 'Foto Motor ${widget.motor.name}',
              fit: BoxFit.contain,
              errorBuilder: (_, _, _) => const Icon(
                Icons.two_wheeler,
                color: Color(0xFFD32F2F),
                size: 40,
              ),
            ),
          ),
          const SizedBox(width: 14),
          // 2. Info Section
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  widget.motor.name,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w800,
                    color: Colors.black,
                    letterSpacing: -0.4,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  widget.motor.subtitle,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF757575),
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 10),
                // Location & Price row for better space usage
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Row(
                      children: [
                        ExcludeSemantics(
                          child: Icon(Icons.location_on, size: 12, color: Color(0xFFD32F2F)),
                        ),
                        SizedBox(width: 3),
                        Text(
                          'Medan',
                          style: TextStyle(
                            fontSize: 11,
                            color: Color(0xFF616161),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: const Color(0xFFE0E0E0), width: 1.0),
                      ),
                      child: Text(
                        widget.motor.price,
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFFD32F2F),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ─────────────────────────────────────────────────────────
  // PAGE HEADER
  // ─────────────────────────────────────────────────────────
  Widget _buildPageHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Detail Pemesan',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          'Lengkapi data diri Anda untuk melanjutkan proses\npemesanan unit ${widget.motor.name} di Medan.',
          style: const TextStyle(
            fontSize: 13,
            color: Color(0xFF757575),
            height: 1.45,
          ),
        ),
      ],
    );
  }

  // ─────────────────────────────────────────────────────────
  // TANDA JADI CARD
  // ─────────────────────────────────────────────────────────
  Widget _buildPaymentTypeSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Tipe Pembayaran Cash',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            _buildTypeChip('Booking Unit', !_isFullPayment),
            const SizedBox(width: 10),
            _buildTypeChip('Pelunasan Full', _isFullPayment),
          ],
        ),
      ],
    );
  }

  Widget _buildTypeChip(String label, bool isSelected) {
    return Expanded(
      child: Material(
        color: isSelected ? const Color(0xFFD32F2F) : Colors.white,
        borderRadius: BorderRadius.circular(8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide(
            color: isSelected ? const Color(0xFFD32F2F) : const Color(0xFFE0E0E0),
          ),
        ),
        child: InkWell(
          onTap: () => ref.read(bookingViewModelProvider.notifier).updatePaymentType(
                isFullPayment: label == 'Pelunasan Full',
              ),
          borderRadius: BorderRadius.circular(8),
          child: Container(
            height: 48,
            alignment: Alignment.center,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: isSelected ? Colors.white : const Color(0xFF707070),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPaymentDetailCard() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFFF9F9F9),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE0E0E0), width: 1),
      ),
      padding: const EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _isFullPayment ? 'TOTAL PELUNASAN (FULL)' : 'BIAYA RESERVASI (BOOKING)',
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF555555),
                    letterSpacing: 0.8,
                  ),
                ),
                const SizedBox(height: 4),
                RichText(
                  text: TextSpan(
                    children: [
                      const TextSpan(
                        text: 'Rp ',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFFD32F2F),
                        ),
                      ),
                      TextSpan(
                        text: _isFullPayment ? widget.motor.price.replaceAll('Rp ', '') : '500.000',
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFFD32F2F),
                          letterSpacing: -1,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  _isFullPayment
                      ? 'Pembayaran penuh untuk unit ${widget.motor.name}. Anda tidak perlu membayar lagi saat serah terima unit.'
                      : 'Biaya untuk mengamankan antrian unit. Akan memotong harga OTR saat pelunasan nanti.',
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF555555),
                    height: 1.45,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          ExcludeSemantics(
            child: Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: const Color(0xFFEEEEEE)),
              ),
              child: const Icon(Icons.payments_outlined, color: Color(0xFFD32F2F), size: 24),
            ),
          ),
        ],
      ),
    );
  }

  // ─────────────────────────────────────────────────────────
  // SECTION TITLE  (icon + bold label)
  // ─────────────────────────────────────────────────────────
  Widget _buildSectionTitle({
    required Widget iconWidget,
    required String title,
  }) {
    return Row(
      children: [
        ExcludeSemantics(child: iconWidget),
        const SizedBox(width: 7),
        Text(
          title,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
      ],
    );
  }

  // KTP card icon (red outline rectangle with face & lines)
  Widget _buildIdCardIcon() {
    return ExcludeSemantics(
      child: SizedBox(
        width: 20,
        height: 20,
        child: Stack(
          children: [
            // Card border
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2),
                  border: Border.all(color: const Color(0xFFD32F2F), width: 1.8),
                ),
              ),
            ),
            // Face circle
            Positioned(
              left: 2,
              top: 3,
              child: Container(
                width: 6,
                height: 6,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: const Color(0xFFD32F2F), width: 1.5),
                ),
              ),
            ),
            // Text lines
            Positioned(
              right: 2,
              top: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 7,
                    height: 1.5,
                    color: const Color(0xFFD32F2F),
                  ),
                  const SizedBox(height: 2.5),
                  Container(
                    width: 5,
                    height: 1.5,
                    color: const Color(0xFFD32F2F),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ─────────────────────────────────────────────────────────
  // FORM HELPERS
  // ─────────────────────────────────────────────────────────
  Widget _buildLabel(String text) {
    return ExcludeSemantics(
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w500,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String hint,
    required String semanticsLabel,
    TextInputType keyboardType = TextInputType.text,
    List<TextInputFormatter>? formatters,
    TextInputAction? textInputAction,
    FocusNode? focusNode,
    ValueChanged<String>? onSubmitted,
    String? errorText,
  }) {
    return Semantics(
      label: semanticsLabel,
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        keyboardType: keyboardType,
        inputFormatters: formatters,
        textInputAction: textInputAction,
        onSubmitted: onSubmitted,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(fontSize: 14, color: Color(0xFF707070)),
          errorText: errorText,
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Color(0xFFE0E0E0), width: 1.2),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Color(0xFFD32F2F), width: 1.2),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Color(0xFFD32F2F), width: 1.2),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Color(0xFFD32F2F), width: 1.2),
          ),
          errorStyle: const TextStyle(fontSize: 12, color: Color(0xFFD32F2F)),
        ),
      ),
    );
  }

  Widget _buildDropdown({
    required String? value,
    required String hint,
    required String semanticsLabel,
    required List<String> items,
    required ValueChanged<String?> onChanged,
    String? errorText,
  }) {
    return Semantics(
      label: semanticsLabel,
      child: DropdownButtonFormField<String>(
        value: value,
        isExpanded: true,
        hint: Text(
          hint,
          style: const TextStyle(fontSize: 14, color: Color(0xFF707070)),
        ),
        icon: const ExcludeSemantics(
          child: Icon(
            Icons.keyboard_arrow_down,
            color: Color(0xFF707070),
            size: 22,
          ),
        ),
        style: const TextStyle(fontSize: 14, color: Colors.black),
        items: items
            .map((e) => DropdownMenuItem<String>(value: e, child: Text(e)))
            .toList(),
        onChanged: onChanged,
        decoration: InputDecoration(
          errorText: errorText,
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Color(0xFFE0E0E0), width: 1.2),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Color(0xFFD32F2F), width: 1.2),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Color(0xFFD32F2F), width: 1.2),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Color(0xFFD32F2F), width: 1.2),
          ),
          errorStyle: const TextStyle(fontSize: 12, color: Color(0xFFD32F2F)),
        ),
      ),
    );
  }

  Widget _buildPhoneField({
    required FocusNode focusNode,
    required TextInputAction textInputAction,
    required ValueChanged<String>? onSubmitted,
    String? errorText,
  }) {
    return Semantics(
      label: 'No. HP (WhatsApp Aktif)',
      child: TextField(
        controller: _phoneController,
        focusNode: focusNode,
        keyboardType: TextInputType.phone,
        textInputAction: textInputAction,
        onSubmitted: onSubmitted,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        style: const TextStyle(fontSize: 14, color: Colors.black),
        decoration: InputDecoration(
          hintText: '812xxxx',
          hintStyle: const TextStyle(fontSize: 14, color: Color(0xFF707070)),
          errorText: errorText,
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
          prefixIcon: Container(
            margin: const EdgeInsets.only(right: 8),
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: const BoxDecoration(
              border: Border(
                right: BorderSide(color: Color(0xFFE0E0E0), width: 1.2),
              ),
            ),
            child: const Text(
              '+62',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
          ),
          prefixIconConstraints: const BoxConstraints(
            minWidth: 58,
            minHeight: 48,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Color(0xFFE0E0E0), width: 1.2),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Color(0xFFD32F2F), width: 1.2),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Color(0xFFD32F2F), width: 1.2),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Color(0xFFD32F2F), width: 1.2),
          ),
          errorStyle: const TextStyle(fontSize: 12, color: Color(0xFFD32F2F)),
        ),
      ),
    );
  }

  // ─────────────────────────────────────────────────────────
  // CTA BUTTON
  // ─────────────────────────────────────────────────────────
  Widget _buildPilihBookingButton() {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: _isNavigating ? null : () async {
          setState(() {
            _isNavigating = true;
          });
          final success = ref.read(bookingViewModelProvider.notifier).submitForm();
          if (!success) {
            setState(() {
              _isNavigating = false;
            });
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(_getValidationMessage()),
                backgroundColor: const Color(0xFFD32F2F),
              ),
            );
            return;
          }

          await context.push(
            '/ringkasan-pembayaran',
            extra: {
              'motor': widget.motor,
              'isFullPayment': _isFullPayment,
            },
          );
          if (mounted) {
            setState(() {
              _isNavigating = false;
            });
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFD32F2F),
          foregroundColor: Colors.white,
          disabledBackgroundColor: Colors.grey.shade300,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          elevation: 0,
        ),
        child: const Text(
          'Pilih Pembayaran Booking',
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  // ─────────────────────────────────────────────────────────
  // PRODUCT CARD
  // ─────────────────────────────────────────────────────────


  // ─────────────────────────────────────────────────────────
  // PAYMENT TOGGLE  (Tunai / Kredit chips)
  // ─────────────────────────────────────────────────────────
  // BOTTOM BAR
  // ─────────────────────────────────────────────────────────
  Widget _buildBottomBar() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Harga OTR Unit',
              style: TextStyle(fontSize: 13, color: Color(0xFF707070)),
            ),
            Text(
              widget.motor.price,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                _isFullPayment ? 'Total Bayar Sekarang' : 'Total Bayar Booking (Sekarang)',
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFFD32F2F),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Text(
              _isFullPayment ? widget.motor.price : 'Rp 500.000',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: Color(0xFFD32F2F),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
