import 'package:interns2025b_mobile/src/core/data/network/http_client.dart';
import 'package:interns2025b_mobile/src/shared/domain/models/user_model.dart';

class ProfileDataSource {
  final HttpClient httpClient;

  ProfileDataSource(this.httpClient);

  Future<User> getProfile() async {
    final response = await httpClient.get('/api/profile');
    return User.fromJson(response['data']);
  }

  Future<void> deleteUserRequest() async {
    await httpClient.post('/api/profile/delete-request');
  }
}
