class HeroBanner {
  final String image;
  final String tag;
  final String title1;
  final String title2;
  final String subtitle;

  const HeroBanner({
    required this.image,
    required this.tag,
    required this.title1,
    required this.title2,
    required this.subtitle,
  });
}

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
