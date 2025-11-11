import '../api/api_service.dart';

import '../../core/utils/constants.dart';
import '../models/article.dart';
import 'base_repo.dart';

class ArticleRepository extends BaseRepository<ArticleModel> {
  ArticleRepository(ApiService apiService) : super(apiService);

  @override
  String get endpoint => AppConstants.articlesEndpoint;

  @override
  ArticleModel fromJson(Map<String, dynamic> json) =>
      ArticleModel.fromJson(json);

  Future<List<ArticleModel>> getVisibleArticles({int page = 1}) async {
    try {
      final response =
          await apiService.get('$endpoint?visible=true&page=$page');
      final List data = response.data['data'] ?? [];
      return data.map((e) => ArticleModel.fromJson(e)).toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<List<ArticleModel>> searchArticles(
      {String? query, String? genre}) async {
    final queryParams = <String, String>{};
    if (query != null && query.isNotEmpty) queryParams['query'] = query;
    if (genre != null && genre.isNotEmpty) queryParams['genre'] = genre;

    final queryString =
        queryParams.entries.map((e) => "${e.key}=${e.value}").join('&');

    try {
      final response = await apiService.get('$endpoint/search?$queryString');
      final List data = response.data['data'] ?? [];
      return data.map((e) => ArticleModel.fromJson(e)).toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> toggleVisibility(String id, bool visible) async {
    await update(id, {'visible': visible});
  }
}
