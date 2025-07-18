import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:interns2025b_mobile/src/core/data/network/http_client_provider.dart';
import 'package:interns2025b_mobile/src/features/profile/data/data_sources/profile_data_source.dart';

final profileDataSourceProvider = Provider<ProfileDataSource>((ref) {
  final httpClient = ref.watch(httpClientProvider);
  return ProfileDataSource(httpClient);
});
