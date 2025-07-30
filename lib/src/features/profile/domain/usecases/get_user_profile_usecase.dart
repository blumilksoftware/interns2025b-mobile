import 'package:interns2025b_mobile/src/features/profile/domain/repositories/profile_repository.dart';
import 'package:interns2025b_mobile/src/shared/domain/models/user_model.dart';

class GetUserProfileUseCase {
  final ProfileRepository repository;

  GetUserProfileUseCase(this.repository);

  Future<User> call(int id) {
    return repository.getUserProfile(id);
  }
}
