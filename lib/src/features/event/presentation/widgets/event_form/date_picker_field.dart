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
  DateTime? _startDate;
  DateTime? _endDate;

  @override
  void initState() {
    super.initState();
    _startDate = widget.startDate;
    _endDate = widget.endDate;
  }

  Future<void> _pickDateTime({
    required DateTime initialDate,
    required DateTime firstDate,
    required void Function(DateTime) onPicked,
    required TextEditingController controller,
    required bool isStart,
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

    if (!mounted || pickedDate == null) return;

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
            child: TimePickerDialog(
              initialTime: TimeOfDay.fromDateTime(initialDate),
              initialEntryMode: TimePickerEntryMode.inputOnly,
            ),
          ),
        );
      },
    );

    if (!mounted || pickedTime == null) return;

    final fullDateTime = DateTime(
      pickedDate.year,
      pickedDate.month,
      pickedDate.day,
      pickedTime.hour,
      pickedTime.minute,
    );

    controller.text = _formatDateTime(fullDateTime);
    onPicked(fullDateTime);

    setState(() {
      if (isStart) {
        _startDate = fullDateTime;
        if (_endDate != null && _endDate!.isBefore(_startDate!)) {
          _endDate = null;
          widget.endController.clear();
        }
      } else {
        _endDate = fullDateTime;
      }
    });
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
            initialDate: _startDate ?? DateTime.now(),
            firstDate: DateTime.now(),
            onPicked: widget.onStartPicked,
            controller: widget.startController,
            isStart: true,
          ),
          child: AbsorbPointer(
            child: CustomTextField(
              controller: widget.startController,
              readOnly: true,
              validator: (_) {
                if (_startDate == null) {
                  return localizations.startDateHint;
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
            initialDate: _endDate ?? _startDate ?? DateTime.now(),
            firstDate: _startDate ?? DateTime.now(),
            onPicked: widget.onEndPicked,
            controller: widget.endController,
            isStart: false,
          ),
          child: AbsorbPointer(
            child: CustomTextField(
              controller: widget.endController,
              readOnly: true,
              validator: (_) {
                if (_endDate == null) {
                  return localizations.endDateHint;
                }
                if (_startDate != null && _endDate!.isBefore(_startDate!)) {
                  return localizations.endDateError;
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
