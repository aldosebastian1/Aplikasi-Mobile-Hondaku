import 'package:freezed_annotation/freezed_annotation.dart';

part 'news_article.freezed.dart';
part 'news_article.g.dart';

@freezed
abstract class NewsArticle with _$NewsArticle {
  const factory NewsArticle({
    required int id,
    required String title,
    required String body,
    @Default([]) List<String> tags,
    @Default(0) @JsonKey(readValue: _readReactions) int reactions,
  }) = _NewsArticle;

  factory NewsArticle.fromJson(Map<String, dynamic> json) =>
      _$NewsArticleFromJson(json);
}

int _readReactions(Map<dynamic, dynamic> json, String key) {
  final reactions = json[key];
  if (reactions is int) return reactions;
  if (reactions is Map) {
    return (reactions['likes'] as int? ?? 0) + (reactions['dislikes'] as int? ?? 0);
  }
  return 0;
}
