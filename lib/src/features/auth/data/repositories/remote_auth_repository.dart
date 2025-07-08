import 'package:interns2025b_mobile/src/features/auth/data/data_sources/auth_data_source.dart';
import 'package:interns2025b_mobile/src/features/auth/domain/repositories/auth_repository.dart';
import 'package:interns2025b_mobile/src/shared/domain/models/user_model.dart';

class RemoteAuthRepository implements AuthRepository {
  final AuthDataSource dataSource;

  RemoteAuthRepository(this.dataSource);

  @override
  Future<User> login(String email, String password) {
    return dataSource.login(email, password);
  }

  @override
  Future<void> register(
    String email,
    String firstName,
    String? lastName,
    String password,
    String confirmPassword,
  ) {
    return dataSource.register(
      email,
      firstName,
      lastName,
      password,
      confirmPassword,
    );
  }

  @override
  Future<void> logout() async {
    await dataSource.logout();
  }

  @override
  Future<void> forgotPassword(String email) {
    return dataSource.forgotPassword(email);
  }
}
