import 'package:interns2025b_mobile/src/features/event/domain/repositories/event_repository.dart';
import 'package:interns2025b_mobile/src/shared/domain/models/event_model.dart';

class UpdateEventUseCase {
  final EventRepository repository;
  
  UpdateEventUseCase(this.repository);

  Future<Event> call(Event event) {
    return repository.updateEvent(event);
  }
}
