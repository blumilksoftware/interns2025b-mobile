import 'package:interns2025b_mobile/src/features/auth/domain/repositories/auth_repository.dart';
import 'package:interns2025b_mobile/src/shared/domain/models/user_model.dart';

class LoginUseCase {
  final AuthRepository _repository;

  LoginUseCase(this.repository);

  Future<User> call(String email, String password) {
    return repository.login(email, password);
  }

  AuthRepository get getRepository => repository;
}
