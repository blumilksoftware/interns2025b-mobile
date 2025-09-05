import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:interns2025b_mobile/l10n/generated/app_localizations.dart';
import 'package:interns2025b_mobile/src/core/routes/app_routes.dart';
import 'package:interns2025b_mobile/src/features/event/presentation/providers/event_controller_provider.dart';
import 'package:interns2025b_mobile/src/features/event/presentation/widgets/event_form/age_category_dropdown.dart';
import 'package:interns2025b_mobile/src/features/event/presentation/widgets/event_form/coorinates_map_picker.dart';
import 'package:interns2025b_mobile/src/features/event/presentation/widgets/event_form/date_picker_field.dart';
import 'package:interns2025b_mobile/src/features/event/presentation/widgets/event_form/descritpion_field.dart';
import 'package:interns2025b_mobile/src/features/event/presentation/widgets/event_form/image_url_field.dart';
import 'package:interns2025b_mobile/src/features/event/presentation/widgets/event_form/is_paid_switch.dart';
import 'package:interns2025b_mobile/src/features/event/presentation/widgets/event_form/location_section.dart';
import 'package:interns2025b_mobile/src/features/event/presentation/widgets/event_form/status_dropdown.dart';
import 'package:interns2025b_mobile/src/features/event/presentation/widgets/event_form/submit_button_section.dart';
import 'package:interns2025b_mobile/src/features/event/presentation/widgets/event_form/title_field.dart';

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
  final bool isEdit;
  final int? eventId;

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
    this.isEdit = false,
    this.eventId,
  });

  @override
  ConsumerState<EventCreationForm> createState() => _EventCreationFormState();
}

class _EventCreationFormState extends ConsumerState<EventCreationForm> {
  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final controller = ref.watch(eventsControllerProvider);
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
            onStartPicked: (date) => controller.updateFormData(start: date),
            onEndPicked: (date) => controller.updateFormData(end: date),
            startDate: controller.startDate,
            endDate: controller.endDate,
          ),
          LocationSection(location: widget.location, address: widget.address!),
          CoordinatesMapPicker(
            latitude: widget.latitude!,
            longitude: widget.longitude!,
          ),
          IsPaidSwitch(
            value: controller.isPaid,
            onChanged: (bool? val) =>
                controller.updateFormData(paid: val ?? false),
          ),
          ImageUrlField(controller: widget.imageUrl),
          StatusDropdown(
            selected: controller.selectedStatus,
            onChanged: (status) {
              if (status != null) {
                controller.updateFormData(status: status);
                widget.status.text = status.name;
              }
            },
          ),
          AgeCategoryDropdown(
            selected: controller.selectedAgeCategory,
            onChanged: (category) {
              controller.updateFormData(ageCategory: category);
              widget.ageCategory.text = category?.name ?? '';
            },
          ),
          SubmitButtonSection(
            isLoading: controller.isCreating,
            onPressed: () async {
              if (!widget.formKey.currentState!.validate()) return;

              final event = controller.buildEvent(
                title: widget.title.text,
                description: widget.description.text,
                location: widget.location.text,
                address: widget.address?.text,
                latitude: widget.latitude?.text,
                longitude: widget.longitude?.text,
                imageUrl: widget.imageUrl.text,
                id: widget.isEdit ? widget.eventId : null,
              );

              final messenger = ScaffoldMessenger.of(context);
              final navigator = Navigator.of(context);

              if (widget.isEdit) {
                await controller.updateEvent(event);
              } else {
                await controller.createEvent(event);
              }

              if (!mounted) return;

              if (controller.creationError == null) {
                messenger.showSnackBar(
                  SnackBar(
                    content: Text(
                      widget.isEdit
                          ? localizations.eventUpdatedSuccess
                          : localizations.eventCreatedSuccess,
                    ),
                  ),
                );
                controller.clearFormData();
                widget.status.clear();
                widget.ageCategory.clear();
                navigator.pushReplacementNamed(AppRoutes.events);
              } else {
                messenger.showSnackBar(
                  SnackBar(content: Text(controller.creationError!)),
                );
              }
            },
          ),
          if (widget.isEdit) ...[
            const SizedBox(height: 12),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              onPressed: () async {
                final messenger = ScaffoldMessenger.of(context);
                final navigator = Navigator.of(context);
                final confirm = await showDialog<bool>(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: Text(localizations.delete),
                    content: Text(localizations.deleteEventConfirmation),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(ctx).pop(false),
                        child: Text(localizations.cancel),
                      ),
                      TextButton(
                        onPressed: () => Navigator.of(ctx).pop(true),
                        child: Text(localizations.delete),
                      ),
                    ],
                  ),
                );

                if (confirm == true) {
                  await controller.deleteEvent(widget.eventId!);
                  if (!mounted) return;
                  messenger.showSnackBar(
                    SnackBar(content: Text(localizations.eventDeleteSuccess)),
                  );

                  navigator.pushReplacementNamed(AppRoutes.events);
                }
              },
              child: Text(localizations.delete),
            ),
          ],
        ],
      ),
    );
  }
}
