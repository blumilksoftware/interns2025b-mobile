import 'package:interns2025b_mobile/src/features/event/data/data_sources/event_data_source.dart';
import 'package:interns2025b_mobile/src/features/event/domain/repositories/event_repository.dart';
import 'package:interns2025b_mobile/src/shared/domain/models/event_model.dart';

class RemoteEventRepository implements EventRepository {
  final EventDataSource dataSource;

  RemoteEventRepository(this.dataSource);

  @override
  Future<List<Event>> getEvents({int page = 1, int limitPerPage = 10}) {
    return dataSource.getEvents(page: page, limitPerPage: limitPerPage);
  }
}
