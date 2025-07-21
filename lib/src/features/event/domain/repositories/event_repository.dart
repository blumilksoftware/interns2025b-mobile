import 'package:interns2025b_mobile/src/shared/domain/models/event_model.dart';

abstract class EventRepository {
  Future<List<Event>> getEvents({int page = 1});
  Future<Event> getEventById(int id);
}
