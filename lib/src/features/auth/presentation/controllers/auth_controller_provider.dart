import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:interns2025b_mobile/src/core/data/network/http_client.dart';
import 'package:interns2025b_mobile/src/features/auth/data/data_sources/auth_data_source.dart';
import 'package:interns2025b_mobile/src/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:interns2025b_mobile/src/features/auth/domain/repositories/auth_repository.dart';
import 'package:interns2025b_mobile/src/features/auth/domain/usecases/login_usecase.dart';
import 'package:interns2025b_mobile/src/features/auth/domain/usecases/logout_usecase.dart';
import 'package:interns2025b_mobile/src/features/auth/domain/usecases/register_usecase.dart';
import 'package:interns2025b_mobile/src/features/auth/presentation/controllers/auth_controller.dart';
import 'package:interns2025b_mobile/src/shared/domain/models/user_model.dart';

final authDataSourceProvider = Provider<AuthDataSource>((ref) {
  final httpClient = ref.watch(httpClientProvider);
  return AuthDataSource(httpClient);
});

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final dataSource = ref.watch(authDataSourceProvider);
  return AuthRepositoryImpl(dataSource);
});

final registerUseCaseProvider = Provider<RegisterUseCase>((ref) {
  final repo = ref.watch(authRepositoryProvider);
  return RegisterUseCase(repo);
});

final loginUseCaseProvider = Provider<LoginUseCase>((ref) {
  final repo = ref.watch(authRepositoryProvider);
  return LoginUseCase(repo);
});

final logoutUseCaseProvider = Provider<LogoutUseCase>((ref) {
  final repo = ref.watch(authRepositoryProvider);
  return LogoutUseCase(repo);
});

final authControllerProvider = AsyncNotifierProvider<AuthController, User?>(
  AuthController.new,
);
