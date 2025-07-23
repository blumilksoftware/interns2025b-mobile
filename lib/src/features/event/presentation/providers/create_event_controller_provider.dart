import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:interns2025b_mobile/src/features/event/domain/providers/create_event_usecase_provider.dart';
import 'package:interns2025b_mobile/src/shared/domain/models/event_model.dart';
import 'package:interns2025b_mobile/src/features/event/domain/usecases/create_event_usecase.dart';

final createEventControllerProvider =
StateNotifierProvider<CreateEventController, AsyncValue<void>>((ref) {
  final useCase = ref.watch(createEventUseCaseProvider);
  return CreateEventController(useCase);
});

class CreateEventController extends StateNotifier<AsyncValue<void>> {
  final CreateEventUseCase createEventUseCase;

  CreateEventController(this.createEventUseCase)
      : super(const AsyncValue.data(null));

  Future<void> create(Event event) async {
    state = const AsyncValue.loading();

    try {
      await createEventUseCase(event);
      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}
