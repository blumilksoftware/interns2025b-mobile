import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:interns2025b_mobile/src/features/event/data/providers/event_repository_provider.dart';
import 'package:interns2025b_mobile/src/features/event/domain/usecases/get_event_by_id_usecase.dart';

final getEventByIdUseCaseProvider = Provider<GetEventByIdUseCase>((ref) {
  final repo = ref.watch(eventRepositoryProvider);
  return GetEventByIdUseCase(repo);
});
