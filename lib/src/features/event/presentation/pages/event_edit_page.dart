import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:interns2025b_mobile/l10n/generated/app_localizations.dart';
import 'package:interns2025b_mobile/src/features/event/presentation/providers/event_by_id_provider.dart';
import 'package:interns2025b_mobile/src/features/event/presentation/providers/event_controller_provider.dart';
import 'package:interns2025b_mobile/src/features/event/presentation/widgets/event_creation_form.dart';
import 'package:interns2025b_mobile/src/shared/domain/models/age_category.dart';
import 'package:interns2025b_mobile/src/shared/presentation/widgets/navigation_bar.dart';

class EventEditPage extends ConsumerStatefulWidget {
  const EventEditPage({super.key});

  @override
  ConsumerState<EventEditPage> createState() => _EventEditPageState();
}

class _EventEditPageState extends ConsumerState<EventEditPage> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController title;
  late final TextEditingController description;
  late final TextEditingController startTime;
  late final TextEditingController endTime;
  late final TextEditingController location;
  late final TextEditingController address;
  late final TextEditingController latitude;
  late final TextEditingController longitude;
  late final TextEditingController imageUrl;
  late final TextEditingController status;
  late final TextEditingController ageCategory;

  bool _initialized = false;

  @override
  void initState() {
    super.initState();

    title = TextEditingController();
    description = TextEditingController();
    startTime = TextEditingController();
    endTime = TextEditingController();
    location = TextEditingController();
    address = TextEditingController();
    latitude = TextEditingController();
    longitude = TextEditingController();
    imageUrl = TextEditingController();
    status = TextEditingController();
    ageCategory = TextEditingController();
  }

  @override
  void dispose() {
    title.dispose();
    description.dispose();
    startTime.dispose();
    endTime.dispose();
    location.dispose();
    address.dispose();
    latitude.dispose();
    longitude.dispose();
    imageUrl.dispose();
    status.dispose();
    ageCategory.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final eventId = ModalRoute.of(context)?.settings.arguments as int?;

    if (eventId == null) {
      return Scaffold(
        body: Center(child: Text(localizations.noInformation)),
      );
    }

    final eventAsync = ref.watch(eventByIdProvider(eventId));

    return Scaffold(
      appBar: AppBar(
        title: Text(localizations.edit),
      ),
      body: eventAsync.when(
        data: (event) {
          if (!_initialized) {
            title.text = event.title;
            description.text = event.description ?? '';
            startTime.text = event.start?.toIso8601String() ?? '';
            endTime.text = event.end?.toIso8601String() ?? '';
            location.text = event.location ?? '';
            address.text = event.address ?? '';
            latitude.text = event.latitude?.toString() ?? '';
            longitude.text = event.longitude?.toString() ?? '';
            imageUrl.text = event.imageUrl ?? '';
            status.text = event.status.name;
            ageCategory.text = event.ageCategory!;

            ref.read(eventsControllerProvider).updateFormData(
              start: event.start,
              end: event.end,
              status: event.status,
              ageCategory: AgeCategory.fromString(event.ageCategory!),
              paid: event.isPaid,
            );

            _initialized = true;
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: EventCreationForm(
              formKey: _formKey,
              title: title,
              description: description,
              startTime: startTime,
              endTime: endTime,
              location: location,
              address: address,
              latitude: latitude,
              longitude: longitude,
              imageUrl: imageUrl,
              status: status,
              ageCategory: ageCategory,
              isEdit: true,
              eventId: event.id,
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text('$error')),
      ),
      bottomNavigationBar: const NavigationBarWidget(),
    );
  }
}
