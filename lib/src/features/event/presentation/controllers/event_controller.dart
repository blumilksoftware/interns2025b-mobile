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
  List<Event> get events => _events;

  final Set<int> _shownEventIds = {};

  String _searchQuery = '';
  String get searchQuery => _searchQuery;

  List<Event> get filteredEvents {
    if (_events.isEmpty) return [];

    if (_searchQuery.isEmpty) return _events;

    final lowerQuery = _searchQuery.toLowerCase();

    return _events.where((event) {
      final words = event.title.toLowerCase().split(RegExp(r'\s+'));
      return words.any((word) => word.startsWith(lowerQuery));
    }).toList();
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  bool _hasMore = true;
  bool get hasMore => _hasMore;

  int _currentPage = 1;
  final int _limit = 10;

  Future<void> loadEvents({bool refresh = false}) async {
    if (_isLoading) return;

    if (refresh) {
      _events.clear();
      _shownEventIds.clear();
      _currentPage = 1;
      _hasMore = true;
      notifyListeners();
    }

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final result = await getEventsUseCase.call(
        page: _currentPage,
        limit: _limit,
      );

      final newEvents = result
          .where((e) => !_shownEventIds.contains(e.id))
          .toList();

      _events.addAll(newEvents);
      _shownEventIds.addAll(newEvents.map((e) => e.id));

      if (newEvents.length < _limit) {
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
}
