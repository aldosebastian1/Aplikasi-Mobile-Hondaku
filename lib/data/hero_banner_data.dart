import '../domain/models/hero_banner.dart';
export '../domain/models/hero_banner.dart';



// Simulasi database khusus untuk Hero Banner agar mudah ditambahkan
final List<HeroBanner> heroBannersDatabase = [
  const HeroBanner(
    image: 'assets/images/home-hero1.jpg',
    tag: 'PRODUK TERBARU',
    title1: 'CBR650R',
    title2: 'Kendalikan Jalanan.',
    subtitle: 'Performa 4-silinder presisi untuk pacu adrenalin di lintasan maupun jalanan kota.',
  ),
  const HeroBanner(
    image: 'assets/images/home-hero2.jpg',
    tag: 'PALING LARIS',
    title1: 'PCX160',
    title2: 'Level Tertinggi.',
    subtitle: 'Rasakan kemewahan berkendara di perkotaan dengan kenyamanan tangguh mesin eSP+.',
  ),
  const HeroBanner(
    image: 'assets/images/home-hero3.jpg',
    tag: 'PETUALANG',
    title1: 'CRF250',
    title2: 'Jelajahi Dunia.',
    subtitle: 'Taklukkan segala medan. Suspensi tangguh siap menemani insting petualang Anda.',
  ),
];
