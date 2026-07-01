import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../domain/models/news_article.dart';
import '../../../../data/repositories/news_repository_impl.dart';

// FutureProvider is perfect for fetching data once and caching it
final newsListProvider = FutureProvider.autoDispose<List<NewsArticle>>((ref) async {
  final repository = ref.watch(newsRepositoryProvider);
  return await repository.fetchLatestNews();
});
