import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:interns2025b_mobile/src/features/event/data/providers/event_repository_provider.dart';
import 'package:interns2025b_mobile/src/features/event/domain/usecases/toggle_participation_usecase.dart';

final toggleParticipationUseCaseProvider = Provider<ToggleParticipationUseCase>(
  (ref) {
    final repository = ref.watch(eventRepositoryProvider);
    return ToggleParticipationUseCase(repository);
  },
);
