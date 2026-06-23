import '../domain/models/hero_banner.dart';
export '../domain/models/hero_banner.dart';



// Simulasi database khusus untuk Hero Banner agar mudah ditambahkan
final List<HeroBanner> heroBannersDatabase = [
  const HeroBanner(
    image: 'assets/images/home-hero1.png',
    tag: 'PRODUK TERBARU',
    title1: 'CBR650R',
    title2: 'Kendalikan Jalanan.',
    subtitle: 'Performa 4-silinder presisi yang dirancang untuk adrenalin murni.',
  ),
  const HeroBanner(
    image: 'assets/images/home-hero2.png',
    tag: 'PALING LARIS',
    title1: 'PCX160',
    title2: 'Level Tertinggi.',
    subtitle: 'Rasakan kemewahan berkendara kota dengan kenyamanan tak tertandingi.',
  ),
  const HeroBanner(
    image: 'assets/images/home-hero3.png',
    tag: 'PETUALANG',
    title1: 'CRF250 Rally',
    title2: 'Jelajahi Dunia.',
    subtitle: 'Taklukkan segala medan dengan percaya diri dan gaya tangguh.',
  ),
];
