import 'package:interns2025b_mobile/src/core/data/network/http_client.dart';
import 'package:interns2025b_mobile/src/shared/domain/models/event_model.dart';

class EventDataSource {
  final HttpClient httpClient;

  EventDataSource(this.httpClient);

  Future<List<Event>> getEvents({int page = 1}) async {
    final response = await httpClient.get('/api/events?page=$page');
    final List<dynamic> eventsJson = response['data'];
    return eventsJson
        .map((json) => Event.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  Future<Event> getEventById(int id) async {
    final response = await httpClient.get('/api/events/$id');
    return Event.fromJson(response['data'] as Map<String, dynamic>);
  }

  Future<void> createEvent(Event event) async {
    final body = event.toJson();
    await httpClient.post('/api/events', body: body);
  }

  Future<Event> toggleParticipation(int id) async {
    final response = await httpClient.post('/api/events/$id/participate');
    return Event.fromJson(response['data'] as Map<String, dynamic>);
  }
}
