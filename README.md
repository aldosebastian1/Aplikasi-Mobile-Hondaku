# 🏍️ Hondaku - The Future of Digital Dealership

> [!IMPORTANT]
> **Kredensial Akses (Demo)**
> Untuk mencoba aplikasi, silakan gunakan akun berikut pada halaman Login:
> - **Email:** `admin@gmail.com`
> - **Password:** `admin123`

**Hondaku** adalah aplikasi *mobile* berkinerja tinggi yang dirancang untuk merevolusi dan mendigitalisasi pengalaman pengguna dalam mengeksplorasi, mensimulasikan pembiayaan kredit, hingga melakukan pemesanan (booking) sepeda motor Honda secara langsung dari genggaman. 

Aplikasi ini menonjol sebagai studi kasus **High-Quality Mobile Engineering**, memadukan desain antarmuka yang sangat elegan (UI/UX) dengan arsitektur kode berskala enterprise, didukung oleh pengujian yang ketat (Automated Testing) dan optimalisasi performa tingkat tinggi.

---

## 🎯 1. Latar Belakang & Masalah (Problem Statement)
Dalam industri penjualan sepeda motor konvensional, calon konsumen sering menghadapi *pain-points* (titik jenuh) berikut:
1. **Ketidaktransparanan Simulasi Kredit**: Pelanggan umumnya harus datang ke *dealer* atau menghubungi tenaga penjual hanya untuk mengetahui skema cicilan atau besaran uang muka (DP), yang memakan waktu dan kurang efisien.
2. **Proses Inden/Booking yang Kaku**: Pemesanan unit favorit seringkali mengharuskan dokumen fisik dan kehadiran langsung di *dealer*.
3. **Keterbatasan Eksplorasi Katalog**: Pelanggan kesulitan membandingkan spesifikasi motor (seperti mesin, rangka, fitur) secara detail tanpa mengumpulkan tumpukan brosur kertas.

## 💡 2. Solusi yang Ditawarkan (The Solution)
Hondaku menjawab masalah tersebut melalui platform digital terpusat yang menawarkan:
- **Smart Catalog**: Eksplorasi seluruh lini motor Honda lengkap dengan spesifikasi teknis mendalam dan visual resolusi tinggi.
- **Interactive Credit Simulation**: Kalkulator pintar yang secara *real-time* menghitung besaran cicilan per bulan berdasarkan variasi Tenor dan Uang Muka (DP).
- **Seamless Booking System**: Proses pemesanan digital dari awal hingga akhir, di mana pengguna dapat membayar *booking fee* atau melunasi unit langsung dari aplikasi, lengkap dengan pengumpulan data identitas yang aman.

## 👥 3. Target Market & Audiens
Aplikasi ini dirancang untuk:
- **Calon Pembeli (Usia 18 - 45 Tahun)**: Generasi Milenial dan Gen-Z yang memiliki mobilitas tinggi dan menginginkan kepraktisan dalam bertransaksi (semuanya melalui *smartphone*).
- **Honda Enthusiasts**: Pecinta merek Honda yang ingin selalu mendapatkan pembaruan (*update*), promosi, dan rilis motor terbaru (melalui fitur News & Promo).
- **Perencana Keuangan Pribadi**: Konsumen yang sangat teliti dalam mengkalkulasi skema cicilan kendaraan agar sesuai dengan arus kas (cashflow) bulanan mereka.

---

## ✨ 4. Fitur Utama (Key Features)
1. **🔐 Authentication & Security**: Login dan Registrasi aman. Token sesi pengguna disimpan menggunakan enkripsi *hardware-backed* (`flutter_secure_storage`).
2. **🏠 Dynamic Dashboard (Home)**: Menampilkan rekomendasi unit terlaris, promo eksklusif terbatas, dan pintasan cepat.
3. **💰 Simulasi Kredit (Kredit)**: Perhitungan matematis instan untuk skema pembiayaan dengan UI yang sangat interaktif.
4. **📝 Sistem Booking Unit (Booking)**: Formulir pemesanan terpadu dengan *smart validation*, dukungan upload dokumen, dan integrasi pemilihan metode pembayaran.
5. **🏍️ Katalog & Manajemen Wishlist (Catalog & Favorites)**: Kemampuan untuk menyimpan unit motor impian untuk ditinjau kembali di kemudian hari.
6. **📊 Pelacakan Aktivitas (Activity)**: Manajemen riwayat transaksi, melacak status pemesanan (menunggu pembayaran, diproses, dikirim).
7. **📰 Berita Otomotif (News)**: Artikel dan tips perawatan motor resmi dari Honda.

---

## 🛠️ 5. Tech Stack & Arsitektur (Tech & Architecture)
Sebagai *showcase portfolio*, proyek ini dibangun dengan standar industri:
- **Framework Utama**: [Flutter](https://flutter.dev) (Dart) - *Cross-platform mobile development*.
- **State Management**: [Riverpod](https://riverpod.dev) - Memastikan logika aplikasi terpisahkan dari UI (*Separation of Concerns*), aman dari *memory leaks*, dan bersifat *reactive*.
- **Navigasi & Routing**: [GoRouter](https://pub.dev/packages/go_router) - Mendukung konfigurasi *Deep-Linking* dan perlindungan rute *(Route Guards)* untuk akses halaman berizin.
- **Data Modeling**: **Freezed & JSON Serializable** - *Immutability* dan parsing data REST API yang aman dari *runtime exception*.
- **Penyimpanan Lokal**: **Flutter Secure Storage** untuk perlindungan data sensitif (menggantikan *Shared Preferences* standar).

---

## 🏆 6. Standar Kualitas Tinggi (QA, QC, & Engineering Excellence)
Proyek ini tidak hanya terlihat bagus, tetapi dibangun dengan prinsip *Clean Code*:
- **Atomic Design Pattern**: Memecah *God-Widgets* (ratusan baris UI) menjadi komponen atomik yang terisolasi dan dapat digunakan kembali (*reusable*), seperti `BookingPaymentCard` dan `BookingProductCard`.
- **Zero Lints Policy (100% Clean Analyzer)**: Kode melewati tahapan `flutter analyze` dengan bersih tanpa ada satu pun *warning*, *deprecated usage*, atau *dead code*.
- **Memory & Performance Optimization**: Pencegahan pembengkakan RAM (*memory bloat*) pada halaman *scroll* panjang melalui pembatasan *cache render* pada *image assets* (`cacheWidth/cacheHeight`).
- **Unified Design System (HTDS)**: Implementasi *Hondaku Toast & Dialog System* yang seragam di seluruh aplikasi, menyingkirkan inkonsistensi sistem UI *default* (menggantikan *ScaffoldMessenger* konvensional dengan *Custom Animation* bergaya premium).
- **Automated Testing (100% Pass Rate)**: Integrasi puluhan *Unit Tests* dan *Widget Tests* yang menyimulasikan perilaku pengguna dan menvalidasi kerangka responsif di beragam ukuran layar (dari layar kecil iPhone SE hingga tablet besar).

---

## 📂 7. Struktur Project (Clean Architecture & Feature Folder Split)

Proyek Hondaku dimodifikasi menggunakan struktur berlapis (*layered Clean Architecture*) untuk kemudahan pemeliharaan:

```text
lib/
├── data/              # Mock database & Riverpod Providers (Data Layer)
├── domain/            # Model Data & Entitas Bisnis Bersih (Domain Layer)
│   └── models/        # user_profile, app_settings, motorcycle, dll.
├── l10n/              # Berkas sumber lokalisasi (.arb) hasil auto-generate
└── ui/                # Antarmuka Pengguna & Presentasi (Presentation Layer)
    ├── core/          # Tema global, rute utama (router.dart), & widget bersama
    └── features/      # Pembagian fitur (Feature-Sliced Directory)
        ├── aktivitas/ # Pelacakan aktivitas order dan garasi
        ├── auth/      # Splash, Onboarding, Login, & Register screens
        ├── booking/   # Alur Checkout, Pembayaran, dan Form Pemesanan
        ├── catalog/   # Halaman katalog unit & spesifikasi detail produk
        ├── home/      # Dasbor beranda utama aplikasi
        ├── kredit/    # Simulasi kredit kalkulator & unggah dokumen legalitas
        └── profile/   # Halaman profil terintegrasi dengan sub-fitur modular
```

---

## 🚀 8. Cara Instalasi

Ikuti langkah-langkah di bawah ini untuk menjalankan project ini di lingkungan lokal Anda:

### Prasyarat
- Pastikan Anda sudah menginstal [Flutter SDK](https://docs.flutter.dev/get-started/install) (Versi terbaru direkomendasikan).
- Android Studio / VS Code dengan plugin Flutter & Dart.

### Langkah-langkah
1. **Clone Repositori**
   ```bash
   git clone https://github.com/aldosebastian1/Aplikasi-Mobile-Hondaku.git
   ```
2. **Masuk ke Direktori Project**
   ```bash
   cd Aplikasi-Mobile-Hondaku
   ```
3. **Instal Dependensi**
   Jalankan perintah ini untuk mengunduh library yang dibutuhkan (termasuk `flutter_riverpod`, `go_router`, `file_picker`, dll):
   ```bash
   flutter pub get
   ```
4. **Jalankan Aplikasi**
   Pastikan emulator atau perangkat fisik sudah terhubung:
   ```bash
   flutter run
   ```

---
**Hondaku** - *The Power of Dreams.*
