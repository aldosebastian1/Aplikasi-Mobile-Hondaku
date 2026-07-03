# Hondaku - Honda Mobile Experience

> [!IMPORTANT]
> **Kredensial Akses (Demo)**
> Untuk mencoba aplikasi, silakan gunakan akun berikut pada halaman Login:
> - **Email:** `admin@gmail.com`
> - **Password:** `admin123`

Hondaku adalah aplikasi mobile modern yang dirancang khusus untuk mempermudah konsumen dalam mengeksplorasi, mensimulasikan, dan melakukan pemesanan sepeda motor Honda secara digital. Aplikasi ini menawarkan pengalaman pengguna yang premium dengan antarmuka yang bersih, responsif, dan selaras dengan identitas brand Honda.

## 🎯 Mengapa Proyek Ini Dibuat? (Portfolio Context)

### 🚨 Masalah yang Diselesaikan (Problem Statement)
Proses pembelian sepeda motor secara konvensional seringkali memakan waktu dan kurang transparan. Calon pembeli biasanya harus berkunjung ke dealer fisik berkali-kali hanya untuk melihat ketersediaan unit, menghitung simulasi kredit manual dengan *sales*, atau menyerahkan dokumen persyaratan yang mudah hilang atau terselip. 
**Hondaku** diciptakan untuk menyelesaikan masalah ini dengan mendigitalisasi seluruh pengalaman belanja (mulai dari melihat katalog 3D/Foto, kalkulasi cicilan transparan secara *real-time*, hingga penyerahan dokumen legalitas) ke dalam genggaman.

### 👥 Target Market
1. **Generasi Milenial & Gen Z**: Konsumen modern yang *tech-savvy*, menyukai efisiensi, serta mengutamakan pengalaman bertransaksi yang instan dan *cashless*.
2. **Pekerja & Profesional**: Individu dengan jadwal padat yang tidak memiliki banyak waktu luang untuk melakukan survei dari satu dealer ke dealer lain.
3. **Pembeli Motor Pertama (First-time Buyers)**: Pengguna yang membutuhkan panduan yang jelas, rincian biaya yang transparan (tanpa biaya tersembunyi), serta kebebasan bereksperimen dengan angka simulasi kredit sebelum membuat keputusan finansial.

## ✨ Fitur Utama

- **Katalog Motor Dinamis**: Jelajahi berbagai tipe unit Honda (Matic, Sport, Cub, Electric) dengan informasi detail spesifikasi dan varian warna.
- **Simulasi Kredit Instan**: Hitung cicilan secara real-time dengan berbagai pilihan tenor dan lembaga pembiayaan (Leasing) terpercaya.
- **Modern Booking Flow**: Pilih metode pembayaran fleksibel mulai dari *Booking Fee* hingga pembayaran lunas (*Full Payment*).
- **Upload Dokumen Legalitas**: Mendukung unggah foto (JPG/PNG) dan dokumen (PDF) dengan sistem validasi ukuran file (Max 5MB) untuk keamanan data.
- **Live Activity Tracking**: Pantau status pengajuan kredit dan pengiriman unit Anda secara langsung melalui dashboard aktivitas.
- **Profil Terintegrasi**: Dasbor pengguna yang menampilkan pesanan aktif dan garasi kendaraan yang sudah dimiliki secara terpisah.

## 🚀 Teknologi yang Digunakan

- **Framework**: [Flutter](https://flutter.dev) (Dart)
- **State Management**: [Riverpod](https://riverpod.dev) (Notifier, FutureProvider, & Consumer Widgets)
- **Navigation**: [GoRouter](https://pub.dev/packages/go_router) (Declarative Routing dengan Stateful Shell Route & Nested Routing)
- **Localization**: [intl](https://pub.dev/packages/intl) (Non-synthetic Localization menggunakan berkas `.arb` di `lib/l10n/`)
- **UI Design**: Modern Material Design dengan sentuhan Honda Red Branding, mendukung Mode Gelap (Dark Mode)
- **Asset Handling**: SVG Support, dynamic image rendering, dan PDF validation

## 🛠️ Cara Instalasi

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

## 📂 Struktur Project (Clean Architecture & Feature Folder Split)

Proyek Hondaku telah dimodifikasi menggunakan struktur berlapis (*layered Clean Architecture*) untuk kemudahan pemeliharaan:

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

## 📸 Aset
Aplikasi ini menggunakan berbagai aset gambar dan ikon yang terletak di folder `assets/`. Pastikan folder tersebut tetap ada agar aplikasi dapat merender UI dengan benar.

## 🗺️ Alur Navigasi & Peta Aplikasi (App Flow Map)

Untuk penjelasan lengkap mengenai logika navigasi, diagram alur (*flowchart*), dan bagaimana halaman-halaman saling terhubung menggunakan **GoRouter**, silakan merujuk ke dokumen **[flow.md](flow.md)**.

Peta alur ini disinkronkan secara otomatis dari kode sumber Flutter menggunakan utilitas sinkronisasi:
```bash
dart run tool/sync_app_flow.dart
```

---
**Hondaku** - *The Power of Dreams.*
