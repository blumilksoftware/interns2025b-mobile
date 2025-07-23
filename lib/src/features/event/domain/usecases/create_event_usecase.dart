import 'package:interns2025b_mobile/src/shared/domain/models/event_model.dart';
import 'package:interns2025b_mobile/src/features/event/domain/repositories/event_repository.dart';

class CreateEventUseCase {
  final EventRepository repository;

  CreateEventUseCase(this.repository);

  Future<void> call(Event event) {
    return repository.createEvent(event);
  }
}
