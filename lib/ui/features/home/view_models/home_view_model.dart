import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../data/providers.dart';
import '../../../../domain/models/hero_banner.dart';
import '../../../../data/repositories/news_repository_impl.dart';
import '../../../../domain/models/news_article.dart';

final homeMotorcyclesProvider = motorcyclesProvider;

final homeBannersProvider = FutureProvider.autoDispose<List<HeroBanner>>((ref) async {
  // Fetch both static banners and dynamic news concurrently
  final staticBannersFuture = ref.watch(heroBannerRepositoryProvider).getHeroBanners();
  final newsFuture = ref.watch(newsRepositoryProvider).fetchLatestNews();

  final results = await Future.wait([
    staticBannersFuture,
    newsFuture,
  ]);

  final staticBanners = (results[0] as List<HeroBanner>).take(2).toList();
  final news = results[1] as List<NewsArticle>;

  // Convert news to HeroBanner format
  final newsBanners = news.take(3).map((article) {
    final titleParts = article.title.split('|');
    final t1 = titleParts.isNotEmpty ? titleParts[0].trim() : '';
    final t2 = titleParts.length > 1 ? titleParts[1].trim() : '';

    return HeroBanner(
      image: 'assets/images/home-hero1.jpg', // Use a generic background for news if they don't have images
      tag: 'BERITA TERKINI',
      title1: t1,
      title2: t2,
      subtitle: article.body,
    );
  }).toList();

  // Return combined list, maybe alternating or static first
  return [...staticBanners, ...newsBanners];
});
