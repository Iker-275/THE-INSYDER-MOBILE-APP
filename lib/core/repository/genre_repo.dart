import '../../core/utils/constants.dart';
import '../api/api_service.dart';
import '../models/genre.dart';
import 'base_repo.dart';

class GenreRepository extends BaseRepository<GenreModel> {
  GenreRepository(ApiService apiService) : super(apiService);

  @override
  String get endpoint => AppConstants.genresEndpoint;

  @override
  GenreModel fromJson(Map<String, dynamic> json) => GenreModel.fromJson(json);

  Future<List<GenreModel>> getVisibleGenres() async {
    try {
      final response = await apiService.get('$endpoint?visible=true');
      final List data = response.data['data'] ?? [];
      return data.map((e) => GenreModel.fromJson(e)).toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> toggleVisibility(String id, bool visible) async {
    await update(id, {'visible': visible});
  }
}
