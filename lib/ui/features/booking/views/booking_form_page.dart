import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import '../../../core/widgets/hondaku_toast.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../profile/view_models/profile_view_model.dart';
import '../../../../data/providers.dart';
import '../../../../domain/models/kecamatan.dart';
import '../view_models/booking_view_model.dart';
import '../../../../domain/models/motorcycle.dart';
import '../widgets/booking_product_card.dart';
import '../widgets/booking_payment_card.dart';
import '../widgets/booking_form_components.dart';

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

  @override
  void initState() {
    super.initState();
    
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final userProfile = ref.read(userProfileProvider);
      
      if (userProfile.nama != 'Pengguna Hondaku' && userProfile.nama != 'Guest' && userProfile.nama != 'Memuat...' && userProfile.nama != 'Error') {
        _namaController.text = userProfile.nama;
      }
      if (userProfile.email != '-' && userProfile.email != '...' && userProfile.email != 'Error') {
        _emailController.text = userProfile.email;
      }
      if (userProfile.phone != '-' && userProfile.phone != '...' && userProfile.phone != 'Error') {
        _phoneController.text = userProfile.phone;
      }
      if (userProfile.nik != '-' && userProfile.nik != '...' && userProfile.nik != 'Error') {
        _nikController.text = userProfile.nik;
      }
    });

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

  // BUILD
  @override
  Widget build(BuildContext context) {
    final bookingState = ref.watch(bookingViewModelProvider);
    final errorMessage = bookingState.errorMessage;
    
    final locationsAsync = ref.watch(locationsProvider);
    final List<Kecamatan> locations = locationsAsync.value ?? [];
    
    final List<String> kecamatanNames = locations.map((e) => e.name).toList();
    List<String> kelurahanNames = [];
    if (_selectedKecamatan != null) {
      final selectedKecObj = locations.cast<Kecamatan?>().firstWhere(
        (e) => e?.name == _selectedKecamatan, 
        orElse: () => null
      );
      if (selectedKecObj != null) {
        kelurahanNames = selectedKecObj.kelurahan;
      }
    }
    
    final nameError = errorMessage?.contains("Nama") == true ? errorMessage : null;
    final nikError = errorMessage?.contains("NIK") == true ? errorMessage : null;
    final emailError = (errorMessage?.toLowerCase().contains("email") == true) ? errorMessage : null;
    final kecamatanError = errorMessage?.contains("Kecamatan") == true ? errorMessage : null;
    final kelurahanError = errorMessage?.contains("Kelurahan") == true ? errorMessage : null;
    final phoneError = errorMessage?.contains("Nomor HP") == true ? errorMessage : null;
    final alamatError = errorMessage?.contains("Alamat") == true ? errorMessage : null;

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
                    BookingProductCard(motor: widget.motor),
                    const SizedBox(height: 20),
                    BookingPaymentCard(
                      motor: widget.motor,
                      isFullPayment: _isFullPayment,
                      onPaymentTypeChanged: (isFull) {
                        ref.read(bookingViewModelProvider.notifier).updatePaymentType(
                          isFullPayment: isFull,
                        );
                      },
                    ),
                    const SizedBox(height: 24),
                    _buildPageHeader(),
                    const SizedBox(height: 16),

                    const BookingSectionTitle(
                      iconWidget: BookingIdCardIcon(),
                      title: 'Informasi Identitas (KTP)',
                    ),
                    const SizedBox(height: 14),
                    const BookingLabel('Nama Lengkap (Sesuai KTP)'),
                    const SizedBox(height: 6),
                    BookingInputField(
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
                    const BookingLabel('Nomor NIK'),
                    const SizedBox(height: 6),
                    BookingInputField(
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
                    const BookingLabel('Email Address'),
                    const SizedBox(height: 6),
                    BookingInputField(
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

                    const BookingSectionTitle(
                      iconWidget: Icon(
                        Icons.location_on,
                        color: Color(0xFFD32F2F),
                        size: 18,
                      ),
                      title: 'Domisili Medan',
                    ),
                    const SizedBox(height: 14),
                    locationsAsync.when(
                      data: (_) => Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const BookingLabel('Kecamatan'),
                                const SizedBox(height: 6),
                                BookingDropdown(
                                  value: _selectedKecamatan,
                                  hint: 'Pilih Kecamatan',
                                  semanticsLabel: 'Kecamatan',
                                  items: kecamatanNames,
                                  onChanged: (v) {
                                    ref.read(bookingViewModelProvider.notifier).updateKecamatan(v);
                                    ref.read(bookingViewModelProvider.notifier).updateKelurahan(null);
                                  },
                                  errorText: kecamatanError,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const BookingLabel('Kelurahan'),
                                const SizedBox(height: 6),
                                BookingDropdown(
                                  value: _selectedKelurahan,
                                  hint: 'Pilih Kelurahan',
                                  semanticsLabel: 'Kelurahan',
                                  items: kelurahanNames,
                                  onChanged: (v) => ref.read(bookingViewModelProvider.notifier).updateKelurahan(v),
                                  errorText: kelurahanError,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      loading: () => const Padding(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        child: Center(child: CircularProgressIndicator()),
                      ),
                      error: (err, stack) => const Text('Gagal memuat data wilayah', style: TextStyle(color: Colors.red)),
                    ),
                    const SizedBox(height: 14),
                    const BookingLabel('No. HP (WhatsApp Aktif)'),
                    const SizedBox(height: 6),
                    BookingPhoneField(
                      controller: _phoneController,
                      focusNode: _phoneFocusNode,
                      textInputAction: TextInputAction.next,
                      onSubmitted: (_) => FocusScope.of(context).requestFocus(_alamatFocusNode),
                      errorText: phoneError,
                    ),
                    const SizedBox(height: 14),
                    const BookingLabel('Alamat Pengiriman (Medan)'),
                    const SizedBox(height: 6),
                    BookingInputField(
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

  // APPBAR
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


  // PAGE HEADER
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


  // CTA BUTTON
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
            HondakuToast.showError(context, _getValidationMessage());
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

  // PRODUCT CARD


  // PAYMENT TOGGLE  (Tunai / Kredit chips)
  // BOTTOM BAR
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
