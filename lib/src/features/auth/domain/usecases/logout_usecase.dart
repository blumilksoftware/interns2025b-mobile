import 'package:interns2025b_mobile/src/features/auth/domain/repositories/auth_repository.dart';

class LogoutUseCase {
  final AuthRepository _repository;

  LogoutUseCase(this._repository);

  Future<void> call() async {
    await _repository.logout();
  }
}
