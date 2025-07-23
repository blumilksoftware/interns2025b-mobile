import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:interns2025b_mobile/src/features/event/domain/providers/create_event_usecase_provider.dart';
import 'package:interns2025b_mobile/src/features/event/domain/providers/get_events_usecase_provider.dart';
import 'package:interns2025b_mobile/src/features/event/presentation/controllers/event_controller.dart';

final eventsControllerProvider = ChangeNotifierProvider<EventsController>((ref) {
  final getEventsUseCase = ref.watch(getEventsUseCaseProvider);
  final createEventUseCase = ref.watch(createEventUseCaseProvider);

  return EventsController(
    getEventsUseCase: getEventsUseCase,
    createEventUseCase: createEventUseCase,
  )..loadEvents();
});
