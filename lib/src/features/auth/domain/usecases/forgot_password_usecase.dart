import 'package:interns2025b_mobile/src/features/auth/domain/repositories/auth_repository.dart';

class ForgotPasswordUsecase {
  final AuthRepository _repository;

  ForgotPasswordUsecase(this._repository);

  Future<void> call(String email) {
    return _repository.forgotPassword(email);
  }
}
