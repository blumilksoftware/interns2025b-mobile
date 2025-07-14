import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:interns2025b_mobile/src/core/data/network/http_client_provider.dart';
import 'package:interns2025b_mobile/src/features/event/data/data_sources/event_data_source.dart';

final eventDataSourceProvider = Provider<EventDataSource>((ref) {
  final httpClient = ref.watch(httpClientProvider);
  return EventDataSource(httpClient);
});
