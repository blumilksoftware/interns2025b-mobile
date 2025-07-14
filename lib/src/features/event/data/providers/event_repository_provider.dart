import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:interns2025b_mobile/src/features/event/data/providers/event_data_source_provider.dart';
import 'package:interns2025b_mobile/src/features/event/data/repositories/remote_event_repository.dart';
import 'package:interns2025b_mobile/src/features/event/domain/repositories/event_repository.dart';

final eventRepositoryProvider = Provider<EventRepository>((ref) {
  final dataSource = ref.watch(eventDataSourceProvider);
  return RemoteEventRepository(dataSource);
});
