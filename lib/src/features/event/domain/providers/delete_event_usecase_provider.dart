import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:interns2025b_mobile/src/features/event/data/providers/event_repository_provider.dart';
import 'package:interns2025b_mobile/src/features/event/domain/usecases/delete_event_usesace.dart';

final deleteEventUseCaseProvider = Provider<DeleteEventUseCase>((ref) {
  final repository = ref.watch(eventRepositoryProvider);
  return DeleteEventUseCase(repository);
});
