import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:interns2025b_mobile/l10n/generated/app_localizations.dart';
import 'package:interns2025b_mobile/src/shared/presentation/widgets/navigation_bar.dart';
import 'package:interns2025b_mobile/src/features/event/presentation/widgets/event_creation_form.dart';

class EventCreationPage extends ConsumerStatefulWidget {
  const EventCreationPage({super.key});

  @override
  ConsumerState<EventCreationPage> createState() => _EventCreationPageState();
}

class _EventCreationPageState extends ConsumerState<EventCreationPage> {
  final _formKey = GlobalKey<FormState>();

  final title = TextEditingController();
  final description = TextEditingController();
  final startTime = TextEditingController();
  final endTime = TextEditingController();
  final location = TextEditingController();
  final address = TextEditingController();
  final latitude = TextEditingController();
  final longitude = TextEditingController();
  final imageUrl = TextEditingController();
  final status = TextEditingController();
  final ageCategory = TextEditingController();

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
    return Scaffold(
      appBar: AppBar(
        title:  Text(localizations.createEventButton),
      ),
      body: SingleChildScrollView(
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
        ),
      ),
      bottomNavigationBar: const NavigationBarWidget(),
    );
  }
}
