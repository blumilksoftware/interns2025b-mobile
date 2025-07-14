import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:interns2025b_mobile/src/features/event/data/providers/event_repository_provider.dart';
import 'package:interns2025b_mobile/src/features/event/domain/usecases/get_events_usecase.dart';

final getEventsUseCaseProvider = Provider<GetEventsUseCase>((ref) {
  final repo = ref.watch(eventRepositoryProvider);
  return GetEventsUseCase(repo);
});
