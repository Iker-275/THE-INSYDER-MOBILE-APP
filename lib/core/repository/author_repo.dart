import '../api/api_service.dart';
import '../models/user.dart';
import '../../core/utils/constants.dart';
import 'base_repo.dart';

class AuthorRepository extends BaseRepository<UserModel> {
  AuthorRepository(ApiService apiService) : super(apiService);

  @override
  String get endpoint => AppConstants.authorsEndpoint;

  @override
  UserModel fromJson(Map<String, dynamic> json) => UserModel.fromJson(json);

  Future<List<UserModel>> searchAuthors(String query) async {
    try {
      final response = await apiService.get('$endpoint/search?query=$query');
      final List data = response.data['data'] ?? [];
      return data.map((e) => UserModel.fromJson(e)).toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> toggleVisibility(String id, bool visible) async {
    await update(id, {'visible': visible});
  }
}
