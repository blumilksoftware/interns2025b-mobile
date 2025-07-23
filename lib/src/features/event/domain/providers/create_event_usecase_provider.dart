import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:interns2025b_mobile/src/features/event/domain/usecases/create_event_usecase.dart';
import 'package:interns2025b_mobile/src/features/event/data/providers/event_repository_provider.dart';

final createEventUseCaseProvider = Provider<CreateEventUseCase>((ref) {
  final repository = ref.watch(eventRepositoryProvider);
  return CreateEventUseCase(repository);
});
