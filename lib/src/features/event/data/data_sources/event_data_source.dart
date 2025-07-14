import 'package:interns2025b_mobile/src/core/data/network/http_client.dart';
import 'package:interns2025b_mobile/src/shared/domain/models/event_model.dart';

class EventDataSource {
  final HttpClient httpClient;

  EventDataSource(this.httpClient);

  Future<List<Event>> getEvents() async {
    final response = await httpClient.get('/api/events');
    final List<dynamic> eventsJson = response['data'];
    return eventsJson.map((json) => Event.fromJson(json)).toList();
  }
}
