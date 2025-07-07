import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:interns2025b_mobile/src/core/data/network/http_client_provider.dart';
import 'package:interns2025b_mobile/src/features/auth/data/data_sources/auth_data_source.dart';

final authDataSourceProvider = Provider<AuthDataSource>((ref) {
  final httpClient = ref.watch(httpClientProvider);
  return AuthDataSource(httpClient);
});
