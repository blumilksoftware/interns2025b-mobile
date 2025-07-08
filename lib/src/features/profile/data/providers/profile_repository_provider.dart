import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:interns2025b_mobile/src/core/data/network/http_client_provider.dart';
import 'package:interns2025b_mobile/src/features/profile/data/repositories/remote_profile_repository.dart';
import 'package:interns2025b_mobile/src/features/profile/domain/repositories/profile_repository.dart';

final profileRepositoryProvider = Provider<ProfileRepository>((ref) {
  final httpClient = ref.watch(httpClientProvider);
  return RemoteProfileRepository(httpClient);
});
