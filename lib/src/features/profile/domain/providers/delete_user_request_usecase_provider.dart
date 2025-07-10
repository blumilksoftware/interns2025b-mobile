import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:interns2025b_mobile/src/features/profile/data/providers/profile_repository_provider.dart';
import 'package:interns2025b_mobile/src/features/profile/domain/usecases/delete_user_request_usecase.dart';

final deleteUserRequestUseCaseProvider = Provider<DeleteUserRequestUseCase>((
  ref,
) {
  final repository = ref.watch(profileRepositoryProvider);
  return DeleteUserRequestUseCase(repository);
});
