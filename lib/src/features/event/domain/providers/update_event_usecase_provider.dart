import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:interns2025b_mobile/src/features/event/data/providers/event_repository_provider.dart';
import 'package:interns2025b_mobile/src/features/event/domain/usecases/update_event_usecase.dart';

final updateEventUseCaseProvider = Provider<UpdateEventUseCase>((ref) {
  final repository = ref.watch(eventRepositoryProvider);
  return UpdateEventUseCase(repository);
});
