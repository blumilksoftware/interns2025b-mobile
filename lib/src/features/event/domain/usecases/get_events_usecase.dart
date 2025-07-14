import 'package:interns2025b_mobile/src/features/event/domain/repositories/event_repository.dart';

class GetEventsUseCase {
  final EventRepository repository;

  GetEventsUseCase(this.repository);

  Future<List> call() {
    return repository.getEvents();
  }
}
