# Catatan Keamanan Firebase (Untuk Portofolio Public)

File ini adalah pengingat terkait keamanan `firebase_options.dart` jika kode proyek Hondaku ini diunggah ke GitHub secara *Public* (Terbuka).

## Mengapa Diperlukan?
Agar orang lain (rekruter, teman) bisa langsung menjalankan kode ini di laptop mereka tanpa *error*, file `firebase_options.dart` sengaja **TIDAK** disembunyikan.

Namun, untuk mencegah penyalahgunaan kuota Firebase oleh pihak tidak bertanggung jawab, Anda **harus** memberikan batasan (Restriction) pada API Key Anda.

## Langkah-langkah Membatasi API Key (API Restriction):
Pengaturan ini **tidak ada di menu Firebase Console**, melainkan di **Google Cloud Console**. Ikuti langkah berikut saat Anda sudah siap:

1. Buka browser dan pergi ke **[Google Cloud Console](https://console.cloud.google.com/)**.
2. Pastikan Anda masuk (login) menggunakan email yang sama dengan email Firebase Anda.
3. Di sudut kiri atas, pastikan Anda telah **memilih proyek Hondaku** (sama dengan nama proyek di Firebase).
4. Buka menu navigasi utama (garis tiga di kiri atas) -> Pilih **"APIs & Services"** -> Klik **"Credentials"**.
5. Di bagian "API Keys", Anda akan melihat kunci-kunci yang dihasilkan oleh Firebase (biasanya bernama *Android key (auto created by Firebase)*, *iOS key*, dll).
6. Klik pada nama kunci Android tersebut untuk mengeditnya.
7. Di bagian **"Application restrictions"**, pilih **"Android apps"**.
8. Klik **"Add an item"**.
9. Masukkan **Package name** dari aplikasi Anda (contoh: `com.example.hondaku`).
10. Masukkan **SHA-1 certificate fingerprint** dari kunci aplikasi Anda.
11. Klik **"Save"**.
12. Lakukan hal yang sama untuk kunci iOS (jika ada), dengan memilih "iOS apps" dan memasukkan *Bundle ID*.

**Kesimpulan:**
Dengan langkah di atas, meskipun kunci API Anda tersebar di GitHub, kunci tersebut **hanya akan berfungsi** jika permintaan dikirim dari aplikasi resmi Anda. Jika *hacker* mencoba menaruh kunci itu di website mereka, Google akan langsung menolaknya.
