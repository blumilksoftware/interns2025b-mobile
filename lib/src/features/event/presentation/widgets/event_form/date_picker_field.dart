import 'package:flutter/material.dart';
import 'package:interns2025b_mobile/l10n/generated/app_localizations.dart';
import 'package:interns2025b_mobile/src/shared/presentation/widgets/custom_text_field.dart';
import 'package:interns2025b_mobile/src/shared/presentation/widgets/labeled_text.dart';

class DatePickerField extends StatefulWidget {
  final TextEditingController startController;
  final TextEditingController endController;
  final DateTime? startDate;
  final DateTime? endDate;
  final ValueChanged<DateTime> onStartPicked;
  final ValueChanged<DateTime> onEndPicked;

  const DatePickerField({
    super.key,
    required this.startController,
    required this.endController,
    required this.startDate,
    required this.endDate,
    required this.onStartPicked,
    required this.onEndPicked,
  });

  @override
  State<DatePickerField> createState() => _DatePickerFieldState();
}

class _DatePickerFieldState extends State<DatePickerField> {
  Future<void> _pickDateTime({
    required DateTime initialDate,
    required DateTime firstDate,
    required void Function(DateTime) onPicked,
    required TextEditingController controller,
  }) async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: DateTime(2100),
      builder: (BuildContext dialogContext, Widget? child) {
        return Theme(data: Theme.of(dialogContext), child: child!);
      },
    );

    if (!mounted) return;
    if (pickedDate == null) return;

    final pickedTime = await showDialog<TimeOfDay>(
      context: context,
      builder: (BuildContext dialogContext) {
        final mediaQuery = MediaQuery.of(
          dialogContext,
        ).copyWith(alwaysUse24HourFormat: true);

        return MediaQuery(
          data: mediaQuery,
          child: Theme(
            data: Theme.of(dialogContext),
            child: Builder(
              builder: (innerContext) {
                return TimePickerDialog(
                  initialTime: TimeOfDay.fromDateTime(initialDate),
                  initialEntryMode: TimePickerEntryMode.inputOnly,
                );
              },
            ),
          ),
        );
      },
    );

    if (!mounted) return;
    if (pickedTime == null) return;

    final fullDateTime = DateTime(
      pickedDate.year,
      pickedDate.month,
      pickedDate.day,
      pickedTime.hour,
      pickedTime.minute,
    );

    controller.text = _formatDateTime(fullDateTime);
    onPicked(fullDateTime);
  }

  String _formatDateTime(DateTime dateTime) {
    final date =
        "${dateTime.year.toString().padLeft(4, '0')}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}";
    final time =
        "${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}";
    return "$date $time";
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LabeledText(localizations.startDateLabel),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: () => _pickDateTime(
            initialDate: widget.startDate ?? DateTime.now(),
            firstDate: DateTime.now(),
            onPicked: widget.onStartPicked,
            controller: widget.startController,
          ),
          child: AbsorbPointer(
            child: CustomTextField(
              controller: widget.startController,
              hintText: localizations.startDateHint,
              readOnly: true,
              validator: (_) {
                if (widget.startDate == null) {
                  return 'Wybierz datę rozpoczęcia';
                }
                return null;
              },
            ),
          ),
        ),
        const SizedBox(height: 20),
        LabeledText(localizations.endDateLabel),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: () => _pickDateTime(
            initialDate: widget.endDate ?? widget.startDate ?? DateTime.now(),
            firstDate: widget.startDate ?? DateTime.now(),
            onPicked: widget.onEndPicked,
            controller: widget.endController,
          ),
          child: AbsorbPointer(
            child: CustomTextField(
              controller: widget.endController,
              hintText: localizations.endDateHint,
              readOnly: true,
              validator: (_) {
                if (widget.endDate == null) {
                  return 'Wybierz datę zakończenia';
                }
                if (widget.startDate != null &&
                    widget.endDate!.isBefore(widget.startDate!)) {
                  return 'Data zakończenia nie może być przed rozpoczęciem';
                }
                return null;
              },
            ),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
