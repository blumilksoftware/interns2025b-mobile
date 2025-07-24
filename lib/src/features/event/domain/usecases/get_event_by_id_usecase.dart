import 'package:interns2025b_mobile/src/features/event/domain/repositories/event_repository.dart';
import 'package:interns2025b_mobile/src/shared/domain/models/event_model.dart';

class GetEventByIdUseCase {
  final EventRepository repository;

  GetEventByIdUseCase(this.repository);

  Future<Event> call(int id) {
    return repository.getEventById(id);
  }
}
