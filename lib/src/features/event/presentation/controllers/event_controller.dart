import 'dart:async';

import 'package:flutter/material.dart';
import 'package:interns2025b_mobile/src/core/exceptions/auth_exception.dart';
import 'package:interns2025b_mobile/src/core/exceptions/http_exception.dart';
import 'package:interns2025b_mobile/src/core/exceptions/no_internet_exception.dart';
import 'package:interns2025b_mobile/src/features/event/domain/usecases/create_event_usecase.dart';
import 'package:interns2025b_mobile/src/features/event/domain/usecases/get_events_usecase.dart';
import 'package:interns2025b_mobile/src/features/event/domain/usecases/toggle_participation_usecase.dart';
import 'package:interns2025b_mobile/src/shared/domain/models/age_category.dart';
import 'package:interns2025b_mobile/src/shared/domain/models/event_model.dart';
import 'package:interns2025b_mobile/src/shared/domain/models/event_status.dart';
import 'package:interns2025b_mobile/src/shared/domain/models/owner_type.dart';

class EventsController extends ChangeNotifier {
  final GetEventsUseCase getEventsUseCase;
  final CreateEventUseCase createEventUseCase;
  final ToggleParticipationUseCase toggleParticipationUseCase;

  EventsController({
    required this.getEventsUseCase,
    required this.createEventUseCase,
    required this.toggleParticipationUseCase,
  });

  final Set<int> _participatingEventIds = {};

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

  bool _isCreating = false;
  bool get isCreating => _isCreating;

  String? _creationError;
  String? get creationError => _creationError;

  bool _hasMore = true;
  bool get hasMore => _hasMore;

  Timer? _debounceTimer;

  String _searchQuery = '';
  String get searchQuery => _searchQuery;

  EventStatus? selectedStatus;
  AgeCategory? selectedAgeCategory;
  DateTime? startDate;
  DateTime? endDate;
  bool isPaid = false;

  void updateFormData({
    DateTime? start,
    DateTime? end,
    bool? paid,
    EventStatus? status,
    AgeCategory? ageCategory,
  }) {
    if (start != null) startDate = start;
    if (end != null) endDate = end;
    if (paid != null) isPaid = paid;
    if (status != null) selectedStatus = status;
    if (ageCategory != null) selectedAgeCategory = ageCategory;

    notifyListeners();
  }

  Event buildEvent({
    required String title,
    required String description,
    required String location,
    required String? address,
    required String? latitude,
    required String? longitude,
    required String imageUrl,
  }) {
    return Event(
      id: 0,
      title: title,
      description: description,
      start: startDate,
      end: endDate,
      location: location,
      address: address,
      latitude: double.tryParse(latitude ?? ''),
      longitude: double.tryParse(longitude ?? ''),
      isPaid: isPaid,
      price: null,
      status: selectedStatus ?? EventStatus.draft,
      imageUrl: imageUrl,
      ageCategory: selectedAgeCategory?.name,
      ownerType: OwnerType.user,
      ownerId: 1,
      participantCount: 0,
    );
  }

  List<Event> get events {
    return _events.map((e) {
      final participating = _participatingEventIds.contains(e.id);
      return e.copyWith(isParticipating: participating);
    }).toList();
  }

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
      _searchQuery = '';
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
    if (event == null) {
      _selectedEvent = null;
    } else {
      final isParticipating = _participatingEventIds.contains(event.id);
      _selectedEvent = event.copyWith(isParticipating: isParticipating);
    }
    notifyListeners();
  }

  void _reset() {
    _events.clear();
    _shownEventIds.clear();
    _currentPage = 1;
    _hasMore = true;
  }

  Future<void> loadAllEvents() async {
    if (_isLoading) return;

    _reset();
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      while (_hasMore) {
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
      }
    } catch (e) {
      _errorMessage = '$e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> createEvent(Event event) async {
    _isCreating = true;
    _creationError = null;
    notifyListeners();

    try {
      await createEventUseCase(event);
    } on NoInternetException catch (e) {
      _creationError = e.message;
    } on HttpException catch (e) {
      _creationError = 'Server error: ${e.message} (code ${e.statusCode})';
    } on AuthException catch (e) {
      _creationError = 'Authorization error: ${e.message}';
    } catch (e) {
      _creationError = 'Unexpected error: $e';
    } finally {
      _isCreating = false;
      await loadEvents(refresh: true);
      notifyListeners();
    }
  }

  void clearFormData() {
    startDate = null;
    endDate = null;
    isPaid = false;
    selectedStatus = null;
    selectedAgeCategory = null;
    notifyListeners();
  }

  void searchWithDebounce(
    String query, {
    Duration delay = const Duration(milliseconds: 400),
  }) {
    if (query.trim().length < 2 && query.isNotEmpty) return;

    _debounceTimer?.cancel();
    _debounceTimer = Timer(delay, () async {
      await _searchAllEvents(query);
    });
  }

  Future<void> _searchAllEvents(String query) async {
    _searchQuery = query;
    await loadAllEvents();
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    super.dispose();
  }

  Future<void> toggleParticipation(int eventId) async {
    try {
      await toggleParticipationUseCase(eventId);

      final index = _events.indexWhere((e) => e.id == eventId);
      if (index == -1) return;

      final currentlyParticipating = _participatingEventIds.contains(eventId);

      if (currentlyParticipating) {
        _participatingEventIds.remove(eventId);
      } else {
        _participatingEventIds.add(eventId);
      }

      final currentEvent = _events[index];

      final updatedEvent = currentEvent.copyWith(
        isParticipating: !currentlyParticipating,
        participantCount: currentlyParticipating
            ? (currentEvent.participantCount > 0
                  ? currentEvent.participantCount - 1
                  : 0)
            : currentEvent.participantCount + 1,
      );

      _events[index] = updatedEvent;

      if (_selectedEvent?.id == eventId) {
        final isNowParticipating = _participatingEventIds.contains(eventId);
        _selectedEvent = _selectedEvent!.copyWith(
          isParticipating: isNowParticipating,
          participantCount: isNowParticipating
              ? (_selectedEvent!.participantCount + 1)
              : (_selectedEvent!.participantCount > 0
              ? _selectedEvent!.participantCount - 1
              : 0),
        );
      }

      notifyListeners();
    } catch (e) {
      _errorMessage = 'Failed to toggle participation: $e';
      notifyListeners();
    }
  }
}
