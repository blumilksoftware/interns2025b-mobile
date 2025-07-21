import 'package:flutter/material.dart';
import 'package:interns2025b_mobile/src/core/exceptions/auth_exception.dart';
import 'package:interns2025b_mobile/src/core/exceptions/http_exception.dart';
import 'package:interns2025b_mobile/src/core/exceptions/no_internet_exception.dart';
import 'package:interns2025b_mobile/src/features/event/domain/usecases/get_events_usecase.dart';
import 'package:interns2025b_mobile/src/shared/domain/models/event_model.dart';

class EventsController extends ChangeNotifier {
  final GetEventsUseCase getEventsUseCase;

  EventsController({required this.getEventsUseCase});

  final List<Event> _events = [];
  final Set<int> _shownEventIds = {};

  int _currentPage = 1;
  final int _limit = 10;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Event? _selectedEvent;
  Event? get selectedEvent => _selectedEvent;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  bool _hasMore = true;
  bool get hasMore => _hasMore;

  String _searchQuery = '';
  String get searchQuery => _searchQuery;

  List<Event> get events => _events;

  List<Event> get filteredEvents {
    if (_events.isEmpty) return [];

    const allowedStatuses = {EventStatus.published, EventStatus.ongoing};

    final byStatus = _events.where((e) => allowedStatuses.contains(e.status));

    if (_searchQuery.isEmpty) {
      return byStatus.toList();
    }

    final lowerQuery = _searchQuery.toLowerCase();

    return byStatus.where((e) {
      final words = e.title.toLowerCase().split(RegExp(r'\s+'));
      return words.any((word) => word.startsWith(lowerQuery));
    }).toList();
  }

  Future<void> loadEvents({bool refresh = false}) async {
    if (_isLoading) return;

    if (refresh) {
      _reset();
      notifyListeners();
    }

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final result = await getEventsUseCase.call(page: _currentPage);

      final newEvents = result
          .where((e) => !_shownEventIds.contains(e.id))
          .toList();

      _events.addAll(newEvents);
      _shownEventIds.addAll(newEvents.map((e) => e.id));

      if (result.length < _limit) {
        _hasMore = false;
      } else {
        _currentPage++;
      }
    } on NoInternetException catch (e) {
      _errorMessage = e.message;
    } on HttpException catch (e) {
      _errorMessage = 'Server error: ${e.message} (code ${e.statusCode})';
    } on AuthException catch (e) {
      _errorMessage = 'Authorization error: ${e.message}';
    } catch (e) {
      _errorMessage = 'Unexpected error: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void updateSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  void selectEvent(Event? event) {
    _selectedEvent = event;
    notifyListeners();
  }

  void _reset() {
    _events.clear();
    _shownEventIds.clear();
    _currentPage = 1;
    _hasMore = true;
  }
}
