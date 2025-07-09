import 'package:interns2025b_mobile/src/features/profile/domain/repositories/profile_repository.dart';

class DeleteUserRequestUseCase {
  final ProfileRepository repository;

  DeleteUserRequestUseCase(this.repository);

  Future<void> call() {
    return repository.deleteUserRequest();
  }
}
