import 'package:interns2025b_mobile/src/core/data/network/http_client.dart';
import 'package:interns2025b_mobile/src/shared/domain/models/event_model.dart';

class EventDataSource {
  final HttpClient httpClient;

  EventDataSource(this.httpClient);

  Future<List<Event>> getEvents({int page = 1, int limitPerPage = 10}) async {
    final response = await httpClient.get(
      '/api/events?page=$page&limit=$limitPerPage',
    );
    final List<dynamic> eventsJson = response['data'];
    return eventsJson
        .map((json) => Event.fromJson(json as Map<String, dynamic>))
        .toList();
  }
}
