import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:interns2025b_mobile/src/features/auth/data/providers/auth_data_source_provider.dart';
import 'package:interns2025b_mobile/src/features/auth/data/repositories/remote_auth_repository.dart';
import 'package:interns2025b_mobile/src/features/auth/domain/repositories/auth_repository.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final dataSource = ref.watch(authDataSourceProvider);
  return RemoteAuthRepository(dataSource);
});
