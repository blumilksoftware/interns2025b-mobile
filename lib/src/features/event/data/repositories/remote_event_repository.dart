import 'package:interns2025b_mobile/src/features/event/data/data_sources/event_data_source.dart';
import 'package:interns2025b_mobile/src/features/event/domain/repositories/event_repository.dart';
import 'package:interns2025b_mobile/src/shared/domain/models/event_model.dart';

class RemoteEventRepository implements EventRepository {
  final EventDataSource dataSource;

  RemoteEventRepository(this.dataSource);

  @override
  Future<List<Event>> getEvents({int page = 1}) {
    return dataSource.getEvents(page: page);
  }

  @override
  Future<Event> getEventById(int id) {
    return dataSource.getEventById(id);
  }

  @override
  Future<void> createEvent(Event event) {
    return dataSource.createEvent(event);
  }

  @override
  Future<Event> toggleParticipation(int id) {
    return dataSource.toggleParticipation(id);
  }

  @override
  Future<Event> updateEvent(Event event) {
    return dataSource.updateEvent(event);
  }
}
