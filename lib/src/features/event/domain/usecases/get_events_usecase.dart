import 'package:interns2025b_mobile/src/features/event/domain/repositories/event_repository.dart';
import 'package:interns2025b_mobile/src/shared/domain/models/event_model.dart';

class GetEventsUseCase {
  final EventRepository repository;

  GetEventsUseCase(this.repository);

  Future<List<Event>> call() {
    return repository.getEvents();
  }
}
