import 'package:interns2025b_mobile/src/features/profile/domain/repositories/profile_repository.dart';
import 'package:interns2025b_mobile/src/shared/domain/models/user_model.dart';

class GetProfileUseCase {
  final ProfileRepository repository;

  GetProfileUseCase(this.repository);

  Future<User> call() {
    return repository.getProfile();
  }
}
