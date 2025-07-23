import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:interns2025b_mobile/src/features/event/presentation/widgets/event_form/age_category_dropdown.dart';
import 'package:interns2025b_mobile/src/features/event/presentation/widgets/event_form/coordinates_section.dart';
import 'package:interns2025b_mobile/src/features/event/presentation/widgets/event_form/date_picker_field.dart';
import 'package:interns2025b_mobile/src/features/event/presentation/widgets/event_form/descritpion_field.dart';
import 'package:interns2025b_mobile/src/features/event/presentation/widgets/event_form/image_url_field.dart';
import 'package:interns2025b_mobile/src/features/event/presentation/widgets/event_form/location_section.dart';
import 'package:interns2025b_mobile/src/features/event/presentation/widgets/event_form/status_dropdown.dart';
import 'package:interns2025b_mobile/src/features/event/presentation/widgets/event_form/submit_button_section.dart';
import 'package:interns2025b_mobile/src/features/event/presentation/widgets/event_form/title_field.dart';
import 'package:interns2025b_mobile/src/shared/domain/models/age_category.dart';
import 'package:interns2025b_mobile/src/shared/domain/models/event_status.dart';

class EventCreationForm extends ConsumerStatefulWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController title;
  final TextEditingController description;
  final TextEditingController startTime;
  final TextEditingController endTime;
  final TextEditingController location;
  final TextEditingController? address;
  final TextEditingController? latitude;
  final TextEditingController? longitude;
  final TextEditingController imageUrl;
  final TextEditingController status;
  final TextEditingController ageCategory;

  const EventCreationForm({
    super.key,
    required this.formKey,
    required this.title,
    required this.description,
    required this.startTime,
    required this.endTime,
    required this.location,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.imageUrl,
    required this.status,
    required this.ageCategory,
  });

  @override
  ConsumerState<EventCreationForm> createState() => _EventCreationFormState();
}

class _EventCreationFormState extends ConsumerState<EventCreationForm> {
  EventStatus? _selectedStatus;
  AgeCategory? _selectedAgeCategory;
  DateTime? _startDate;
  DateTime? _endDate;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TitleField(controller: widget.title),
          DescriptionField(controller: widget.description),
          DatePickerField(
            startController: widget.startTime,
            endController: widget.endTime,
            onStartPicked: (date) => setState(() => _startDate = date),
            onEndPicked: (date) => setState(() => _endDate = date),
            startDate: _startDate,
            endDate: _endDate,
          ),
          LocationSection(location: widget.location, address: widget.address!),
          CoordinatesSection(
            latitude: widget.latitude!,
            longitude: widget.longitude!,
          ),
          ImageUrlField(controller: widget.imageUrl),
          StatusDropdown(
            selected: _selectedStatus,
            onChanged: (status) {
              setState(() => _selectedStatus = status);
              if (status != null) {
                widget.status.text = status.name;
              }
            },
          ),
          AgeCategoryDropdown(
            selected: _selectedAgeCategory,
            onChanged: (category) {
              setState(() => _selectedAgeCategory = category);
              widget.ageCategory.text = category?.name ?? '';
            },
          ),
          SubmitButtonSection(
            onPressed: () {
              if (widget.formKey.currentState!.validate()) {
                // handle submit
              }
            },
          ),
        ],
      ),
    );
  }
}
