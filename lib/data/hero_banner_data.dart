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
    image: 'assets/images/home-hero.png',
    tag: 'NEW ARRIVAL',
    title1: 'CBR650R',
    title2: 'The Kinetic Spirit.',
    subtitle: 'Precision 4-cylinder performance and\nracing aesthetics.',
  ),
  const HeroBanner(
    image: 'assets/images/home-hero.png',
    tag: 'BEST SELLER',
    title1: 'PCX160',
    title2: 'Urban Excellence.',
    subtitle: 'Elevate your daily commute with\nunmatched comfort.',
  ),
  const HeroBanner(
    image: 'assets/images/home-hero.png',
    tag: 'ADVENTURE',
    title1: 'CRF250 Rally',
    title2: 'Escape Ordinary.',
    subtitle: 'Conquer any terrain with confidence\nand style.',
  ),
];
