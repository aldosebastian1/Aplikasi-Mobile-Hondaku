# Hondaku App Flow

Dokumen ini menjelaskan alur navigasi dan arah logika aplikasi berdasarkan struktur file.
Struktur file telah dikelompokkan ke dalam folder arsitektur bersih (*Clean Architecture*) untuk mempermudah pemeliharaan dan pelacakan dependensi.

## Struktur Direktori Utama (`lib/`)

- **`domain/models/`**: Representasi entitas bisnis bersih (seperti `UserProfile`, `AppSettings`, `PaymentMethodItem`, `Motorcycle`, dll) yang terpisah dari logika presentasi.
- **`data/`**: Data tiruan (*mock database*) dan `providers.dart` sebagai penghubung reaktif (Riverpod FutureProviders) untuk menyuplai data ke UI.
- **`l10n/`**: Berkas lokalisasi `.arb` untuk dukungan multibahasa (Indonesia/English).
- **`ui/core/`**: Router utama (`router.dart` dengan GoRouter), konfigurasi tema (`theme.dart`), shell navigasi bawah (`hondaku_app.dart`), dan widget global (`hondaku_avatar.dart`).
- **`ui/features/`**: Fitur modular yang terbagi menjadi komponen presentasi, halaman, dan view model:
  - **`auth/`**: Alur masuk pengguna (Splash -> Onboarding -> Login -> Register).
  - **`home/`**: Dasbor utama dengan pencarian, kategori motor, dan spanduk banner dinamis.
  - **`catalog/`**: Katalog pencarian motor dan halaman spesifikasi detail produk.
  - **`booking/`**: Alur checkout tunai (Pilih Pembayaran -> Isi Data -> Ringkasan -> Pembayaran -> Berhasil).
  - **`kredit/`**: Alur simulasi kredit dan unggah dokumen persyaratan leasing.
  - **`aktivitas/`**: Alur pelacakan status pesanan aktif dan daftar motor di garasi pengguna.
  - **`profile/`**: Dasbor pengguna beserta halaman pengaturan modular terpisah:
    - *Informasi Pribadi* (`informasi_pribadi_page.dart`)
    - *Metode Pembayaran* (`metode_pembayaran_page.dart` & `AddPaymentMethodSheet`)
    - *Bantuan & Dukungan* (`bantuan_dukungan_page.dart` & `SupportTicketSheet`)
    - *Pengaturan Preferensi* (`pengaturan_page.dart`)

## Flow Utama User

1. **Auth**: Splash Screen -> Onboarding -> Login/Register
2. **Utama**: Home / Katalog -> Pilih Motor -> Detail Motor -> Beli (Checkout)
   - *Logic*: Data `Motorcycle` diteruskan dari list utama ke Detail dan Checkout untuk memastikan konsistensi informasi unit.
3. **State Management**: Router GoRouter memanfaatkan `StatefulShellRoute.indexedStack` untuk menjaga state aktif Bottom Navigation Bar saat user menelusuri detail motor atau masuk ke halaman sub-profil.
4. **Checkout (Tunai)**: Pilih Tunai -> Isi Data Pemesan -> Ringkasan Pembayaran -> Instruksi Pembayaran -> Berhasil
5. **Checkout (Kredit)**: Pilih Kredit -> Simulasi Kredit -> Upload Dokumen -> Konfirmasi Pengajuan

---

<!-- AUTO_FLOW_START -->
## Auto-Generated Flow Map

> Bagian ini dihasilkan otomatis oleh `tool/sync_app_flow.dart`.
> Jangan edit manual di antara marker START/END karena akan ditimpa saat sinkronisasi.

**Generated at:** 2026-06-24 19:05:49.395678
**Detected nodes:** 21
**Detected transitions:** 35

```mermaid
flowchart TD
  AktivitasPage -->|context.go| CatalogPage
  AktivitasPage -->|context.push| StatusPesananPage
  BookingBerhasilPage -->|context.go| AktivitasPage
  BookingBerhasilPage -->|context.go| HalamanHome
  BookingBerhasilPage -->|context.go| HalamanHome
  BookingBerhasilPage -->|context.go| HalamanHome
  BookingFormPage -->|context.push| RingkasanPembayaranPage
  CheckoutPaymentMethodPage -->|context.push| BookingFormPage
  CheckoutPaymentMethodPage -->|context.push| SimulasiKreditPage
  HalamanHome -->|context.go| CatalogPage
  KonfirmasiPengajuanPage -->|context.go| HalamanHome
  KonfirmasiPengajuanPage -->|context.go| HalamanHome
  KonfirmasiPengajuanPage -->|context.go| HalamanHome
  KonfirmasiPesananPage -->|context.go| HalamanHome
  LoginScreen -->|context.go| HalamanHome
  LoginScreen -->|context.push| RegisterScreen
  MotorcycleCardWidget -->|context.push| CheckoutPaymentMethodPage
  MotorcycleCardWidget -->|context.push| ProductDetailScreen
  OnboardingScreen -->|context.go| LoginScreen
  PembayaranBookingPage -->|context.pushReplacement| BookingBerhasilPage
  ProductDetailScreen -->|context.push| CheckoutPaymentMethodPage
  ProfilePage -->|context.go| LoginScreen
  ProfilePage -->|context.push| StatusPesananPage
  ProfilePage -->|context.push| StatusPesananPage
  RegisterScreen -->|context.go| HalamanHome
  RingkasanPembayaranPage -->|context.push| PembayaranBookingPage
  Router -->|context.go| CatalogPage
  Router -->|context.go| CatalogPage
  Router -->|context.go| ProfilePage
  Router -->|context.go| ProfilePage
  Router -->|context.go| ProfilePage
  SimulasiKreditPage -->|context.push| UploadDokumenKreditPage
  SplashScreen -->|context.go| OnboardingScreen
  StatusPesananPage -->|context.pushReplacement| KonfirmasiPesananPage
  UploadDokumenKreditPage -->|context.push| KonfirmasiPengajuanPage
```

### Detected Transitions

- AktivitasPage -> CatalogPage (context.go) [lib/ui/features/aktivitas/views/aktivitas_page.dart:281]
- AktivitasPage -> StatusPesananPage (context.push) [lib/ui/features/aktivitas/views/aktivitas_page.dart:332]
- BookingBerhasilPage -> AktivitasPage (context.go) [lib/ui/features/booking/views/booking_berhasil_page.dart:219]
- BookingBerhasilPage -> HalamanHome (context.go) [lib/ui/features/booking/views/booking_berhasil_page.dart:245]
- BookingBerhasilPage -> HalamanHome (context.go) [lib/ui/features/booking/views/booking_berhasil_page.dart:27]
- BookingBerhasilPage -> HalamanHome (context.go) [lib/ui/features/booking/views/booking_berhasil_page.dart:37]
- BookingFormPage -> RingkasanPembayaranPage (context.push) [lib/ui/features/booking/views/booking_form_page.dart:769]
- CheckoutPaymentMethodPage -> BookingFormPage (context.push) [lib/ui/features/booking/views/checkout_payment_method_page.dart:548]
- CheckoutPaymentMethodPage -> SimulasiKreditPage (context.push) [lib/ui/features/booking/views/checkout_payment_method_page.dart:544]
- HalamanHome -> CatalogPage (context.go) [lib/ui/features/home/views/home_page.dart:338]
- KonfirmasiPengajuanPage -> HalamanHome (context.go) [lib/ui/features/kredit/views/konfirmasi_pengajuan_page.dart:292]
- KonfirmasiPengajuanPage -> HalamanHome (context.go) [lib/ui/features/kredit/views/konfirmasi_pengajuan_page.dart:41]
- KonfirmasiPengajuanPage -> HalamanHome (context.go) [lib/ui/features/kredit/views/konfirmasi_pengajuan_page.dart:51]
- KonfirmasiPesananPage -> HalamanHome (context.go) [lib/ui/features/booking/views/konfirmasi_pesanan_page.dart:313]
- LoginScreen -> HalamanHome (context.go) [lib/ui/features/auth/views/login_screen.dart:274]
- LoginScreen -> RegisterScreen (context.push) [lib/ui/features/auth/views/login_screen.dart:393]
- MotorcycleCardWidget -> CheckoutPaymentMethodPage (context.push) [lib/ui/core/widgets/motorcycle_card_widget.dart:179]
- MotorcycleCardWidget -> ProductDetailScreen (context.push) [lib/ui/core/widgets/motorcycle_card_widget.dart:151]
- OnboardingScreen -> LoginScreen (context.go) [lib/ui/features/auth/views/onboarding_screen.dart:44]
- PembayaranBookingPage -> BookingBerhasilPage (context.pushReplacement) [lib/ui/features/booking/views/pembayaran_booking_page.dart:619]
- ProductDetailScreen -> CheckoutPaymentMethodPage (context.push) [lib/ui/features/catalog/views/product_detail_screen.dart:470]
- ProfilePage -> LoginScreen (context.go) [lib/ui/features/profile/views/profile.dart:959]
- ProfilePage -> StatusPesananPage (context.push) [lib/ui/features/profile/views/profile.dart:259]
- ProfilePage -> StatusPesananPage (context.push) [lib/ui/features/profile/views/profile.dart:450]
- RegisterScreen -> HalamanHome (context.go) [lib/ui/features/auth/views/register_screen.dart:180]
- RingkasanPembayaranPage -> PembayaranBookingPage (context.push) [lib/ui/features/booking/views/ringkasan_pembayaran_page.dart:457]
- Router -> CatalogPage (context.go) [lib/ui/core/router.dart:61]
- Router -> CatalogPage (context.go) [lib/ui/core/router.dart:83]
- Router -> ProfilePage (context.go) [lib/ui/core/router.dart:82]
- Router -> ProfilePage (context.go) [lib/ui/core/router.dart:72]
- Router -> ProfilePage (context.go) [lib/ui/core/router.dart:62]
- SimulasiKreditPage -> UploadDokumenKreditPage (context.push) [lib/ui/features/kredit/views/simulasi_kredit_page.dart:416]
- SplashScreen -> OnboardingScreen (context.go) [lib/ui/features/auth/views/splash_screen.dart:41]
- StatusPesananPage -> KonfirmasiPesananPage (context.pushReplacement) [lib/ui/features/booking/views/status_pesanan_page.dart:51]
- UploadDokumenKreditPage -> KonfirmasiPengajuanPage (context.push) [lib/ui/features/kredit/views/upload_dokumen_kredit_page.dart:141]
<!-- AUTO_FLOW_END -->
