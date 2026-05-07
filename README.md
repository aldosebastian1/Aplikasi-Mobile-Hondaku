# Hondaku - Honda Mobile Experience

> [!IMPORTANT]
> **Kredensial Akses (Demo)**
> Untuk mencoba aplikasi, silakan gunakan akun berikut pada halaman Login:
> - **Email:** `admin@gmail.com`
> - **Password:** `admin123`

Hondaku adalah aplikasi mobile modern yang dirancang khusus untuk mempermudah konsumen dalam mengeksplorasi, mensimulasikan, dan melakukan pemesanan sepeda motor Honda secara digital. Aplikasi ini menawarkan pengalaman pengguna yang premium dengan antarmuka yang bersih, responsif, dan selaras dengan identitas brand Honda.

## ✨ Fitur Utama

- **Katalog Motor Dinamis**: Jelajahi berbagai tipe unit Honda (Matic, Sport, Cub, Electric) dengan informasi detail spesifikasi dan varian warna.
- **Simulasi Kredit Instan**: Hitung cicilan secara real-time dengan berbagai pilihan tenor dan lembaga pembiayaan (Leasing) terpercaya.
- **Modern Booking Flow**: Pilih metode pembayaran fleksibel mulai dari *Booking Fee* hingga pembayaran lunas (*Full Payment*).
- **Upload Dokumen Legalitas**: Mendukung unggah foto (JPG/PNG) dan dokumen (PDF) dengan sistem validasi ukuran file (Max 5MB) untuk keamanan data.
- **Live Activity Tracking**: Pantau status pengajuan kredit dan pengiriman unit Anda secara langsung melalui dashboard aktivitas.
- **Profil Terintegrasi**: Dasbor pengguna yang menampilkan pesanan aktif dan garasi kendaraan yang sudah dimiliki secara terpisah.

## 🚀 Teknologi yang Digunakan

- **Framework**: [Flutter](https://flutter.dev) (Dart)
- **State Management**: ValueNotifier & Custom Store Architecture
- **Navigation**: Navigator 1.0 (Imperative)
- **UI Design**: Modern Material Design dengan sentuhan Honda Red Branding
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
   Jalankan perintah ini untuk mengunduh library yang dibutuhkan (termasuk `file_picker`, `flutter_svg`, dll):
   ```bash
   flutter pub get
   ```
4. **Jalankan Aplikasi**
   Pastikan emulator atau perangkat fisik sudah terhubung:
   ```bash
   flutter run
   ```

## 📂 Struktur Project

```text
lib/
├── auth/          # Splash, Onboarding, Login, & Register screens
├── booking/       # Checkout, Form Data, & Payment flow
├── core/          # Root App (Bottom Nav Wrapper) & Config
├── data/          # Mock database (Motor, Banner, Bank, Garage)
├── home/          # Home dashboard, Catalog, Activity, & Profile
└── kredit/        # Credit Simulation & Document Upload module
```

## 📸 Aset
Aplikasi ini menggunakan berbagai aset gambar dan ikon yang terletak di folder `assets/`. Pastikan folder tersebut tetap ada agar aplikasi dapat merender UI dengan benar.

---
**Hondaku** - *The Power of Dreams.*
Dikembangkan dengan ❤️ untuk kemudahan pecinta Honda di Indonesia.
