import '../models/news_article.dart';

abstract class NewsRepository {
  Future<List<NewsArticle>> fetchLatestNews();
}
