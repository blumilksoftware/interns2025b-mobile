import 'package:interns2025b_mobile/src/shared/domain/models/user_model.dart';

abstract class AuthRepository {
  Future<User> login(String email, String password);
  Future<void> register(
    String email,
    String firstName,
    String? lastName,
    String password,
    String confirmPassword,
  );
  Future<void> logout();
  Future<void> forgotPassword(String email);
}
