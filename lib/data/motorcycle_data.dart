class Motorcycle {
  final String id;
  final String name;
  final String categoryBadge;
  final String subtitle;
  final String description;
  final String price;
  final String imageAsset;
  final bool isNew;
  final bool isRecommended;

  const Motorcycle({
    required this.id,
    required this.name,
    required this.categoryBadge,
    required this.subtitle,
    required this.description,
    required this.price,
    required this.imageAsset,
    this.isNew = false,
    this.isRecommended = false,
  });
}

// Pusat Data Base List Mockup
final List<Motorcycle> motorcycleDatabase = [
  const Motorcycle(
    id: '1',
    name: "BeAT",
    categoryBadge: "MATIC",
    subtitle: "Matic • 250cc",
    description: "Compact and agile, perfect for your daily urban commute.",
    price: "Rp 19.155.000",
    imageAsset: "assets/images/Beat 1.png",
    isRecommended: true,
  ),
  const Motorcycle(
    id: '2',
    name: "BeAT Street",
    categoryBadge: "MATIC",
    subtitle: "Matic • 125cc",
    description: "Urban street style with naked handlebar design.",
    price: "Rp 20.026.000",
    imageAsset: "assets/images/Beat 1.png",
  ),
  const Motorcycle(
    id: '3',
    name: "Vario 125",
    categoryBadge: "MATIC",
    subtitle: "Matic • 125cc",
    description: "Sporty design with advanced features for everyday riding.",
    price: "Rp 24.560.000",
    imageAsset: "assets/images/Beat 1.png",
  ),
  const Motorcycle(
    id: '4',
    name: "Vario 125 Street",
    categoryBadge: "ADVENTURE",
    subtitle: "Adventure • 150cc",
    description: "Versatile performance tailored for spirited adventurers.",
    price: "Rp 37.850.000",
    imageAsset: "assets/images/Beat 1.png",
    isNew: true,
  ),
  const Motorcycle(
    id: '5',
    name: "Ninja 250SL",
    categoryBadge: "SPORT",
    subtitle: "Sport • 250cc",
    description: "Lightweight supersport with sharp handling and power.",
    price: "Rp 64.500.000",
    imageAsset: "assets/images/Beat 1.png",
  ),
  const Motorcycle(
    id: '6',
    name: "Honda CB500X",
    categoryBadge: "CRUISER",
    subtitle: "Adventure • 500cc",
    description: "Adventure without boundaries. Precision\nperformance.",
    price: "Rp 194.500.000",
    imageAsset: "assets/images/Beat 1.png",
  ),
];
