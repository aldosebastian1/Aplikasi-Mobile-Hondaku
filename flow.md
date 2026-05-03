# Hondaku App Flow

Dokumen ini menjelaskan alur navigasi dan arah logika aplikasi berdasarkan struktur file.
Struktur file telah dikelompokkan ke dalam folder fungsional untuk memudahkan pencarian (*keywords*) dan audit kode.

## Struktur Direktori Utama (`lib/`)

- **`core/`**: File inti seperti `hondaku_app.dart` (shell navigasi bawah) dan `main.dart` (entry point).
- **`auth/`**: Flow masuk pengguna (Splash -> Onboarding -> Login -> Register).
- **`home/`**: Halaman utama (Home, Katalog, Detail Produk, Profil, Aktivitas).
- **`booking/`**: Flow pemesanan unit dan pembayaran (Pilih Metode Pembayaran -> Data Pemesan -> Ringkasan -> Pembayaran -> Berhasil).
- **`kredit/`**: Flow pengajuan kredit (Simulasi Kredit -> Upload Dokumen -> Konfirmasi).

## Flow Utama User

1. **Auth**: Splash Screen -> Onboarding -> Login/Register
2. **Utama**: Home / Katalog -> Pilih Motor -> Detail Motor -> Beli (Checkout)
3. **Checkout (Tunai)**: Pilih Tunai -> Isi Data Pemesan -> Ringkasan Pembayaran -> Instruksi Pembayaran -> Berhasil
4. **Checkout (Kredit)**: Pilih Kredit -> Simulasi Kredit -> Upload Dokumen -> Konfirmasi Pengajuan

---

<!-- AUTO_FLOW_START -->
## Auto-Generated Flow Map

> Bagian ini dihasilkan otomatis oleh `tool/sync_app_flow.dart`.
> Jangan edit manual di antara marker START/END karena akan ditimpa saat sinkronisasi.

**Generated at:** 2026-05-03 20:46:41.301178
**Detected nodes:** 18
**Detected transitions:** 22

```mermaid
flowchart TD
  AktivitasPage -->|pushAndRemoveUntil| HalamanKatalog
  BookingBerhasilPage -->|pushAndRemoveUntil| HondakuApp
  BookingBerhasilPage -->|pushAndRemoveUntil| HondakuApp
  CheckoutPaymentMethodPage -->|push| DataPemesanPage
  CheckoutPaymentMethodPage -->|push| SimulasiKreditPage
  DataPemesanPage -->|push| RingkasanPembayaranPage
  HalamanHome -->|push| CheckoutPaymentMethodPage
  HalamanHome -->|push| ProductDetailScreen
  HalamanKatalog -->|push| CheckoutPaymentMethodPage
  HalamanKatalog -->|push| ProductDetailScreen
  LoginScreen -->|pushReplacement| HondakuApp
  LoginScreen -->|push| RegisterScreen
  MyApp -->|MaterialApp.home| SplashScreen
  OnboardingScreen -->|pushReplacement| LoginScreen
  PembayaranBookingPage -->|pushReplacement| BookingBerhasilPage
  ProductDetailScreen -->|push| CheckoutPaymentMethodPage
  ProductDetailScreen -->|pushAndRemoveUntil| HondakuApp
  RegisterScreen -->|pushReplacement| HondakuApp
  RingkasanPembayaranPage -->|push| PembayaranBookingPage
  SimulasiKreditPage -->|push| UploadDokumenKreditPage
  SplashScreen -->|pushReplacement| OnboardingScreen
  UploadDokumenKreditPage -->|push| KonfirmasiPengajuanPage
```

### Detected Transitions

- AktivitasPage -> HalamanKatalog (pushAndRemoveUntil) [lib/home/aktivitas_page.dart:166]
- BookingBerhasilPage -> HondakuApp (pushAndRemoveUntil) [lib/booking/booking_berhasil_page.dart:181]
- BookingBerhasilPage -> HondakuApp (pushAndRemoveUntil) [lib/booking/booking_berhasil_page.dart:213]
- CheckoutPaymentMethodPage -> DataPemesanPage (push) [lib/booking/checkout_payment_method_page.dart:516]
- CheckoutPaymentMethodPage -> SimulasiKreditPage (push) [lib/booking/checkout_payment_method_page.dart:507]
- DataPemesanPage -> RingkasanPembayaranPage (push) [lib/booking/data_pemesan_page.dart:567]
- HalamanHome -> CheckoutPaymentMethodPage (push) [lib/home/home_page.dart:540]
- HalamanHome -> ProductDetailScreen (push) [lib/home/home_page.dart:512]
- HalamanKatalog -> CheckoutPaymentMethodPage (push) [lib/home/catalog_page.dart:427]
- HalamanKatalog -> ProductDetailScreen (push) [lib/home/catalog_page.dart:399]
- LoginScreen -> HondakuApp (pushReplacement) [lib/auth/login_screen.dart:197]
- LoginScreen -> RegisterScreen (push) [lib/auth/login_screen.dart:307]
- MyApp -> SplashScreen (MaterialApp.home) [lib/main.dart:20]
- OnboardingScreen -> LoginScreen (pushReplacement) [lib/auth/onboarding_screen.dart:42]
- PembayaranBookingPage -> BookingBerhasilPage (pushReplacement) [lib/booking/pembayaran_booking_page.dart:501]
- ProductDetailScreen -> CheckoutPaymentMethodPage (push) [lib/home/product_detail_screen.dart:636]
- ProductDetailScreen -> HondakuApp (pushAndRemoveUntil) [lib/home/product_detail_screen.dart:686]
- RegisterScreen -> HondakuApp (pushReplacement) [lib/auth/register_screen.dart:157]
- RingkasanPembayaranPage -> PembayaranBookingPage (push) [lib/booking/ringkasan_pembayaran_page.dart:477]
- SimulasiKreditPage -> UploadDokumenKreditPage (push) [lib/kredit/simulasi_kredit_page.dart:373]
- SplashScreen -> OnboardingScreen (pushReplacement) [lib/auth/splash_screen.dart:18]
- UploadDokumenKreditPage -> KonfirmasiPengajuanPage (push) [lib/kredit/upload_dokumen_kredit_page.dart:97]
<!-- AUTO_FLOW_END -->
