# 🚀 Workflow Lengkap Hondaku: Dari Lokal hingga Live (Hosting)

Dokumen ini adalah peta jalan (*roadmap*) langkah demi langkah untuk membangun, mengintegrasikan, dan mempublikasikan API NestJS beserta Aplikasi Flutter Hondaku Anda. Anda bisa menjadikan ini sebagai *checklist*.

---

## 🟢 FASE 1: Pengembangan API Lokal (Saat Ini)
**Tujuan:** Memastikan struktur *database* dan logika API berjalan sempurna di laptop sebelum naik ke internet.
**Teknologi:** NestJS, Prisma ORM, SQLite.

- [x] **Setup Proyek API**: Inisialisasi NestJS dan Prisma.
- [x] **Rancang Database**: Membuat model `Motorcycle` di `schema.prisma`.
- [x] **Buat Endpoint Dasar**: Membuat API `GET /v1/motorcycles` (lengkap dengan Pagination).
- [x] **Lengkapi Endpoint**: Membuat API detail `GET /v1/motorcycles/:id` (Selesai).
- [x] **Migrasi Mock Data**: Membuat *Script Seeder* untuk memindahkan data riil dari `master_motorcycle_data.dart` (Flutter) ke dalam *database* SQLite (`dev.db`).
- [x] **Testing Lokal**: Mengetes semua *endpoint* menggunakan Postman atau langsung dari Browser di `http://localhost:3000`.

---

## 🟡 FASE 2: Integrasi Frontend (Flutter) dengan API Lokal
**Tujuan:** Memastikan aplikasi Flutter bisa berkomunikasi dengan API lokal di laptop Anda.
**Teknologi:** Flutter, Dio.

- [x] **Setup HTTP Client**: Mengonfigurasi `Dio` dan `Interceptor` di Flutter.
- [x] **Sinkronisasi Model Data**: Memastikan `ApiResponse` dan konversi JSON *snake_case* sudah sama antara Flutter dan NestJS.
- [x] **Ubah URL .env Flutter**: Mengubah `API_BASE_URL` di `.env` Flutter ke URL lokal:
  - Jika pakai Android Emulator: `http://10.0.2.2:3000/v1`
  - Jika pakai Web/iOS Simulator: `http://localhost:3000/v1`
- [x] **Testing UI**: Buka aplikasi Flutter dan pastikan daftar motor muncul dari API, bukan dari file mock lokal lagi.

---

## 🟠 FASE 3: Migrasi Database ke Cloud (Supabase)
**Tujuan:** Memindahkan *database* dari file lokal (`dev.db`) ke *server database online* (PostgreSQL) agar bisa diakses darimana saja.
**Teknologi:** Supabase (Paket Gratis).

- [ ] **Buat Akun Supabase**: Daftar di supabase.com dan buat proyek baru.
- [ ] **Dapatkan URL Database**: Ambil `Connection String` PostgreSQL dari dashboard Supabase.
- [ ] **Update Prisma**: 
  - Ubah `provider = "sqlite"` menjadi `provider = "postgresql"` di `schema.prisma`.
  - Ubah `DATABASE_URL` di file `.env` NestJS menggunakan URL dari Supabase.
- [ ] **Push Skema Database**: Jalankan `npx prisma db push` di terminal. (Tabel akan otomatis terbuat di Supabase).
- [ ] **Jalankan Seeder Kembali**: Jalankan kembali *Script Seeder* agar Supabase terisi dengan data riil motor. (Sekarang database Anda sudah *online!*).

---

## 🔵 FASE 4: Hosting API NestJS (Render.com)
**Tujuan:** Meng-*online*-kan logika kode API NestJS Anda sehingga tidak perlu menjalankan laptop Anda 24 jam.
**Teknologi:** GitHub, Render.com (Atau Railway/Vercel).

- [ ] **Upload ke GitHub**: Push *source code* `hondaku-api` Anda ke repositori GitHub.
- [ ] **Buat Web Service**: Login ke Render.com (gratis), buat *New Web Service*, dan hubungkan ke repo GitHub `hondaku-api` Anda.
- [ ] **Konfigurasi Environment**: Masukkan `DATABASE_URL` (URL Supabase tadi) ke menu *Environment Variables* di Render.
- [ ] **Deploy**: Render akan mem-*build* API Anda. Setelah selesai, Anda akan mendapatkan URL publik (misal: `https://hondaku-api.onrender.com`).

---

## 🟣 FASE 5: Finalisasi & Rilis Aplikasi (Go Live!)
**Tujuan:** Menghubungkan aplikasi Flutter ke API yang sudah *online*, lalu mem-*build* file aplikasi (APK/AAB).
**Teknologi:** Flutter.

- [ ] **Update URL Production**: Buka file `.env` di aplikasi Flutter, ubah `API_BASE_URL` menjadi URL dari Render:
  ```env
  API_BASE_URL=https://hondaku-api.onrender.com/v1
  ```
- [ ] **Testing Akhir**: Jalankan aplikasi di HP/Emulator. Pastikan semuanya berjalan lancar.
- [ ] **Build Aplikasi**: Jalankan perintah `flutter build apk` (untuk Android) atau *build* untuk iOS.
- [ ] 🎉 **SELESAI!** Aplikasi Hondaku Anda sekarang 100% menggunakan arsitektur nyata dengan Backend API dan Database Cloud!
