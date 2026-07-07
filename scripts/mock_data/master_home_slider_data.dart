import 'package:hondaku/domain/models/hero_banner.dart';

// Data Sentral untuk Home Hero Slider (Promo & Berita)
// Semua item, baik itu promosi maupun berita, menggunakan model yang sama (HeroBanner)
// karena fungsinya secara visual di UI adalah sama.
final List<HeroBanner> homeSliderDatabase = [
  // --- BANNERS PROMO ---
  const HeroBanner(
    image: 'assets/images/banners/home_hero1.jpg',
    tag: 'PRODUK TERBARU',
    title1: 'CBR650R',
    title2: 'Kendalikan Jalanan.',
    subtitle: 'Performa 4-silinder presisi untuk pacu adrenalin di lintasan maupun jalanan kota.',
  ),
  const HeroBanner(
    image: 'assets/images/banners/home_hero2.jpg',
    tag: 'PALING LARIS',
    title1: 'PCX160',
    title2: 'Level Tertinggi.',
    subtitle: 'Rasakan kemewahan berkendara di perkotaan dengan kenyamanan tangguh mesin eSP+.',
  ),
  const HeroBanner(
    image: 'assets/images/banners/home_hero3.jpg',
    tag: 'PETUALANG',
    title1: 'CRF250',
    title2: 'Jelajahi Dunia.',
    subtitle: 'Taklukkan segala medan. Suspensi tangguh siap menemani insting petualang Anda.',
  ),

  // --- BERITA TERKINI ---
  const HeroBanner(
    image: 'assets/images/banners/home_hero1.jpg', // Gambar ilustrasi untuk berita
    tag: 'BERITA TERKINI',
    title1: 'Vario 160',
    title2: 'Tampil Lebih Sporty',
    subtitle: 'Varian warna matte terbaru Vario 160 resmi mengaspal makin agresif.',
  ),
  const HeroBanner(
    image: 'assets/images/banners/home_hero2.jpg', 
    tag: 'BERITA TERKINI',
    title1: 'Tips Ahli',
    title2: 'Rawat Mesin Injeksi',
    subtitle: 'Jaga performa optimal mesin injeksi Anda dengan rutin servis berkala di AHASS.',
  ),
  const HeroBanner(
    image: 'assets/images/banners/home_hero3.jpg', 
    tag: 'BERITA TERKINI',
    title1: 'Klub CB150R',
    title2: 'Touring Lintas Pulau',
    subtitle: 'Komunitas CB150R sukses gelar touring meriah lintas pulau Jawa & Bali.',
  ),
];
