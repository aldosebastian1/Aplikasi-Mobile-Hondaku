class AssetPaths {
  // Base paths
  static const String _imagePath = 'assets/images';
  static const String _iconPath = 'assets/icons';
  static const String _paymentPath = 'assets/payments';

  // --- IMAGES ---
  static const String profile = '$_imagePath/profile.png';
  
  // Products (Matic)
  static const String productBeat = '$_imagePath/products/matic/beat.webp';

  // Banners
  static const String bannerHero1 = '$_imagePath/banners/home_hero1.jpg';
  static const String bannerHero2 = '$_imagePath/banners/home_hero2.jpg';
  static const String bannerHero3 = '$_imagePath/banners/home_hero3.jpg';

  // Onboarding
  static const String onboarding1 = '$_imagePath/onboarding/onboarding1.jpg';
  static const String onboarding2 = '$_imagePath/onboarding/onboarding2.jpg';
  static const String onboarding3 = '$_imagePath/onboarding/onboarding3.jpg';

  // --- ICONS ---
  static const String icApple = '$_iconPath/apple_logo.svg';
  static const String icFacebook = '$_iconPath/facebook_logo.svg';
  static const String icGoogle = '$_iconPath/google_logo.svg';

  // --- PAYMENTS ---
  static const String payBca = '$_paymentPath/bca.png';
  static const String payBsi = '$_paymentPath/bsi.png';
  static const String payMandiri = '$_paymentPath/mandiri.png';

  // Prevent instantiation
  AssetPaths._();
}
