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
    // Determine where to split title for title1 and title2
    final titleWords = article.title.split(' ');
    final mid = (titleWords.length / 2).ceil();
    final t1 = titleWords.take(mid).join(' ');
    final t2 = titleWords.skip(mid).join(' ');

    return HeroBanner(
      image: 'assets/images/home-hero1.jpg', // Use a generic background for news if they don't have images
      tag: 'BERITA TERKINI',
      title1: t1,
      title2: t2,
      subtitle: article.body.length > 50 ? '${article.body.substring(0, 50)}...' : article.body,
    );
  }).toList();

  // Return combined list, maybe alternating or static first
  return [...staticBanners, ...newsBanners];
});
