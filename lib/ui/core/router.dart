import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../auth/splash_screen.dart';
import '../../auth/onboarding_screen.dart';
import '../../auth/login_screen.dart';
import '../../auth/register_screen.dart';
import '../../core/hondaku_app.dart';
import '../../home/product_detail_screen.dart';
import '../../booking/booking_form_page.dart';
import '../../booking/checkout_payment_method_page.dart';
import '../../booking/ringkasan_pembayaran_page.dart';
import '../../booking/pembayaran_booking_page.dart';
import '../../booking/booking_berhasil_page.dart';
import '../../booking/status_pesanan_page.dart';
import '../../kredit/simulasi_kredit_page.dart';
import '../../kredit/upload_dokumen_kredit_page.dart';
import '../../kredit/konfirmasi_pengajuan_page.dart';
import '../../domain/models/motorcycle.dart';

final goRouter = GoRouter(
  initialLocation: '/',
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
      path: '/app',
      builder: (context, state) {
        final tab = state.uri.queryParameters['tab'];
        final initialIndex = tab != null ? int.tryParse(tab) ?? 0 : 0;
        return HondakuApp(initialIndex: initialIndex);
      },
    ),
    GoRoute(
      path: '/product-detail',
      builder: (context, state) {
        final motor = state.extra as Motorcycle;
        return ProductDetailScreen(motor: motor);
      },
    ),
    GoRoute(
      path: '/booking-form',
      builder: (context, state) {
        final motor = state.extra as Motorcycle;
        return BookingFormPage(motor: motor);
      },
    ),
    GoRoute(
      path: '/checkout-payment',
      builder: (context, state) {
        final motor = state.extra as Motorcycle;
        return CheckoutPaymentMethodPage(motor: motor);
      },
    ),
    GoRoute(
      path: '/simulasi-kredit',
      builder: (context, state) {
        final motor = state.extra as Motorcycle;
        return SimulasiKreditPage(motor: motor);
      },
    ),
  ],
);
