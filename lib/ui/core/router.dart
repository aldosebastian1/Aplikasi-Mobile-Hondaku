import 'package:go_router/go_router.dart';
import '../features/auth/views/splash_screen.dart';
import '../features/auth/views/onboarding_screen.dart';
import '../features/auth/views/login_screen.dart';
import '../features/auth/views/register_screen.dart';
import '../features/auth/views/phone_login_screen.dart';
import '../features/auth/views/otp_screen.dart';
import 'hondaku_app.dart';
import '../features/home/views/home_page.dart';
import '../features/catalog/views/catalog_page.dart';
import '../features/aktivitas/views/aktivitas_page.dart';
import '../features/profile/views/profile.dart';
import '../features/profile/views/informasi_pribadi_page.dart';
import '../features/profile/views/metode_pembayaran_page.dart';
import '../features/profile/views/bantuan_dukungan_page.dart';
import '../features/profile/views/pengaturan_page.dart';
import '../features/profile/views/static_content_page.dart';
import '../features/favorites/views/favorite_page.dart';
import '../features/catalog/views/product_detail_screen.dart';
import '../features/booking/views/booking_form_page.dart';
import '../features/booking/views/checkout_payment_method_page.dart';
import '../features/booking/views/ringkasan_pembayaran_page.dart';
import '../features/booking/views/pembayaran_booking_page.dart';
import '../features/booking/views/booking_berhasil_page.dart';
import '../features/booking/views/status_pesanan_page.dart';
import '../features/booking/views/konfirmasi_pesanan_page.dart';
import '../features/kredit/views/simulasi_kredit_page.dart';
import '../features/kredit/views/upload_dokumen_kredit_page.dart';
import '../features/kredit/views/konfirmasi_pengajuan_page.dart';
import '../../domain/models/motorcycle.dart';
import '../../domain/models/aktivitas_item.dart';
import '../../domain/models/bank_option.dart';
import 'error_page.dart';

final goRouter = GoRouter(
  initialLocation: '/',
  errorBuilder: (context, state) => ErrorPage(error: state.error),
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/onboarding',
      builder: (context, state) => const OnboardingScreen(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/register',
      builder: (context, state) => const RegisterScreen(),
    ),
    GoRoute(
      path: '/phone-login',
      builder: (context, state) {
        final isLoginMode = (state.extra as bool?) ?? true;
        return PhoneLoginScreen(isLoginMode: isLoginMode);
      },
    ),
    GoRoute(
      path: '/otp',
      builder: (context, state) {
        final extra = state.extra as Map<String, dynamic>;
        final verificationId = extra['verificationId'] as String;
        final isLoginMode = extra['isLoginMode'] as bool? ?? true;
        return OtpScreen(verificationId: verificationId, isLoginMode: isLoginMode);
      },
    ),
    
    // Stateful Shell Route for tabs (main navigation stack preservation)
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return HondakuApp(navigationShell: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/home',
              builder: (context, state) => HalamanHome(
                onSeeAll: () => context.go('/catalog'),
                onProfileClick: () => context.go('/profile'),
              ),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/catalog',
              builder: (context, state) => CatalogPage(
                onProfileClick: () => context.go('/profile'),
              ),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/aktivitas',
              builder: (context, state) => AktivitasPage(
                onProfileClick: () => context.go('/profile'),
                onStartShopping: () => context.go('/catalog'),
              ),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/profile',
              builder: (context, state) => const ProfilePage(),
              routes: [
                GoRoute(
                  path: 'personal-info',
                  builder: (context, state) => const InformasiPribadiPage(),
                ),
                GoRoute(
                  path: 'payment-methods',
                  builder: (context, state) => const MetodePembayaranPage(),
                ),
                GoRoute(
                  path: 'help',
                  builder: (context, state) => const BantuanDukunganPage(),
                ),
                GoRoute(
                  path: 'settings',
                  builder: (context, state) => const PengaturanPage(),
                ),
                GoRoute(
                  path: 'favorites',
                  builder: (context, state) => const FavoritePage(),
                ),
                GoRoute(
                  path: 'terms',
                  builder: (context, state) => const StaticContentPage(title: 'Syarat & Ketentuan'),
                ),
                GoRoute(
                  path: 'privacy',
                  builder: (context, state) => const StaticContentPage(title: 'Kebijakan Privasi'),
                ),
              ],
            ),
          ],
        ),
      ],
    ),
    
    // Product Detail
    GoRoute(
      path: '/product-detail',
      builder: (context, state) {
        if (state.extra is Map<String, dynamic>) {
          final extra = state.extra as Map<String, dynamic>;
          final motor = extra['motor'] as Motorcycle;
          final parentIndex = extra['parentIndex'] as int? ?? 1;
          return ProductDetailScreen(motor: motor, parentIndex: parentIndex);
        }
        final motor = state.extra as Motorcycle;
        return ProductDetailScreen(motor: motor);
      },
    ),
    
    // Booking Form
    GoRoute(
      path: '/booking-form',
      builder: (context, state) {
        final motor = state.extra as Motorcycle;
        return BookingFormPage(motor: motor);
      },
    ),
    
    // Checkout Payment Method
    GoRoute(
      path: '/checkout-payment',
      builder: (context, state) {
        final motor = state.extra as Motorcycle;
        return CheckoutPaymentMethodPage(motor: motor);
      },
    ),
    
    // Ringkasan Pembayaran
    GoRoute(
      path: '/ringkasan-pembayaran',
      builder: (context, state) {
        final extra = state.extra as Map<String, dynamic>;
        final motor = extra['motor'] as Motorcycle;
        final isFullPayment = extra['isFullPayment'] as bool? ?? false;
        return RingkasanPembayaranPage(motor: motor, isFullPayment: isFullPayment);
      },
    ),
    
    // Pembayaran Booking
    GoRoute(
      path: '/pembayaran-booking',
      builder: (context, state) {
        final extra = state.extra as Map<String, dynamic>;
        final motor = extra['motor'] as Motorcycle;
        final initialBank = extra['initialBank'] as BankOption;
        final isFullPayment = extra['isFullPayment'] as bool? ?? false;
        return PembayaranBookingPage(
          motor: motor,
          initialBank: initialBank,
          isFullPayment: isFullPayment,
        );
      },
    ),
    
    // Booking Berhasil
    GoRoute(
      path: '/booking-berhasil',
      builder: (context, state) {
        final extra = state.extra as Map<String, dynamic>;
        return BookingBerhasilPage(
          orderId: extra['orderId'] as String,
          tipeUnit: extra['tipeUnit'] as String,
          dealer: extra['dealer'] as String,
          namaMotor: extra['namaMotor'] as String,
        );
      },
    ),
    
    // Status Pesanan
    GoRoute(
      path: '/status-pesanan',
      builder: (context, state) {
        final item = state.extra as AktivitasItem;
        return StatusPesananPage(item: item);
      },
    ),
    
    // Konfirmasi Pesanan
    GoRoute(
      path: '/konfirmasi-pesanan',
      builder: (context, state) {
        final item = state.extra as AktivitasItem;
        return KonfirmasiPesananPage(item: item);
      },
    ),
    
    // Simulasi Kredit
    GoRoute(
      path: '/simulasi-kredit',
      builder: (context, state) {
        final motor = state.extra as Motorcycle;
        return SimulasiKreditPage(motor: motor);
      },
    ),
    
    // Upload Dokumen Kredit
    GoRoute(
      path: '/upload-dokumen-kredit',
      builder: (context, state) {
        final extra = state.extra as Map<String, dynamic>;
        return UploadDokumenKreditPage(
          namaMotor: extra['namaMotor'] as String,
          selectedLeasing: extra['selectedLeasing'] as String,
          angsuran: extra['angsuran'] as double,
          tenor: extra['tenor'] as int,
          dpNominal: extra['dpNominal'] as double,
          hargaOTR: extra['hargaOTR'] as double,
        );
      },
    ),
    
    // Konfirmasi Pengajuan Kredit
    GoRoute(
      path: '/konfirmasi-pengajuan',
      builder: (context, state) {
        final extra = state.extra as Map<String, dynamic>;
        return KonfirmasiPengajuanPage(
          referenceId: extra['referenceId'] as String,
          namaMotor: extra['namaMotor'] as String,
          leasing: extra['leasing'] as String,
          angsuranPerBulan: extra['angsuranPerBulan'] as double,
          tenor: extra['tenor'] as int,
          dpNominal: extra['dpNominal'] as double,
          hargaOTR: extra['hargaOTR'] as double,
        );
      },
    ),
  ],
);
