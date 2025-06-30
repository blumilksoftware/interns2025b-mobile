import 'package:interns2025b_mobile/src/features/auth/domain/repositories/auth_repository.dart';

class RegisterUseCase {
  final AuthRepository _repository;

  RegisterUseCase(this._repository);

  Future<void> call(
    String email,
    String firstName,
    String? lastName,
    String password,
    String confirmPassword,
  ) {
    return _repository.register(
      email,
      firstName,
      lastName,
      password,
      confirmPassword,
    );
  }
}
