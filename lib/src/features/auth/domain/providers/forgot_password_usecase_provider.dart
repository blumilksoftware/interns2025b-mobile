import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:interns2025b_mobile/src/features/auth/data/providers/auth_repository_provider.dart';
import 'package:interns2025b_mobile/src/features/auth/domain/usecases/forgot_password_usecase.dart';

final forgotPasswordUseCaseProvider = Provider<ForgotPasswordUseCase>((ref) {
  final repo = ref.watch(authRepositoryProvider);
  return ForgotPasswordUseCase(repo);
});
