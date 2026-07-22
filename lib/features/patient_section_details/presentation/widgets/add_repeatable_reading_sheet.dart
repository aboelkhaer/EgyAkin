import 'package:egy_akin/exports.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:egy_akin/features/patient_section_details/presentation/models/repeatable_reading_entry.dart';
import 'package:intl/intl.dart';

enum _ReadingField { date, time, value }

/// Cupertino wheel needs ~216px; chips row sits above in the same panel.
const double _chipsHeight = 38;
const double _toolHeight = 216;
const double _bottomPanelWithChips = _chipsHeight + _toolHeight;

class AddRepeatableReadingSheet extends StatefulWidget {
  final RepeatableReadingEntry? initialEntry;
  final String keyboardType;

  const AddRepeatableReadingSheet({
    super.key,
    this.initialEntry,
    this.keyboardType = 'text',
  });

  @override
  State<AddRepeatableReadingSheet> createState() =>
      _AddRepeatableReadingSheetState();
}

class _AddRepeatableReadingSheetState extends State<AddRepeatableReadingSheet> {
  late DateTime _selectedDate;
  TimeOfDay? _selectedTime;
  late final TextEditingController _valueController;
  final FocusNode _valueFocus = FocusNode();

  _ReadingField _activeField = _ReadingField.date;
  bool _attemptedSave = false;

  /// 0=Today/Now, 1=Yesterday/1h ago, 2=2 days ago/2h ago, null=custom picker.
  int? _dateChipIndex;
  int? _timeChipIndex;

  bool get _isEdit => widget.initialEntry != null;

  @override
  void initState() {
    super.initState();
    final initial = widget.initialEntry;
    final now = DateTime.now();
    if (initial != null) {
      _selectedDate = DateTime(
        initial.dateTime.year,
        initial.dateTime.month,
        initial.dateTime.day,
      );
      if (initial.dateTime.hour != 0 || initial.dateTime.minute != 0) {
        _selectedTime = TimeOfDay.fromDateTime(initial.dateTime);
      }
      _valueController = TextEditingController(text: initial.value);
      _dateChipIndex = _chipIndexForDate(_selectedDate);
      _timeChipIndex = _selectedTime != null
          ? _chipIndexForDateTime(_combinedDateTimeFromParts())
          : null;
    } else {
      _selectedDate = DateTime(now.year, now.month, now.day);
      _selectedTime = null;
      _valueController = TextEditingController();
      _dateChipIndex = 0;
      _timeChipIndex = null;
    }
  }

  DateTime _combinedDateTimeFromParts() {
    final time = _selectedTime ?? const TimeOfDay(hour: 0, minute: 0);
    return DateTime(
      _selectedDate.year,
      _selectedDate.month,
      _selectedDate.day,
      time.hour,
      time.minute,
    );
  }

  @override
  void dispose() {
    _valueController.dispose();
    _valueFocus.dispose();
    super.dispose();
  }

  DateTime get _combinedDateTime => _combinedDateTimeFromParts();

  bool get _isDateValid => true;

  bool get _isValueValid => _valueController.text.trim().isNotEmpty;

  bool get _canSave => _isDateValid && _isValueValid;

  bool get _useEmbeddedNumpad {
    final kt = widget.keyboardType.toLowerCase();
    return kt == 'number' || kt == 'numeric' || kt == 'decimal';
  }

  static DateTime _dateOnly(DateTime d) => DateTime(d.year, d.month, d.day);

  void _appendValueChar(String char) {
    final text = _valueController.text;
    final sel = _valueController.selection;
    final start = sel.start >= 0 ? sel.start : text.length;
    final end = sel.end >= 0 ? sel.end : text.length;
    final updated = text.replaceRange(start, end, char);
    _valueController.value = TextEditingValue(
      text: updated,
      selection: TextSelection.collapsed(offset: start + char.length),
    );
    setState(() {});
  }

  void _backspaceValue() {
    final text = _valueController.text;
    if (text.isEmpty) return;
    final sel = _valueController.selection;
    if (sel.start != sel.end) {
      final updated = text.replaceRange(sel.start, sel.end, '');
      _valueController.value = TextEditingValue(
        text: updated,
        selection: TextSelection.collapsed(offset: sel.start),
      );
      setState(() {});
      return;
    }
    final index = sel.start > 0 ? sel.start : text.length;
    if (index <= 0) return;
    final updated = text.replaceRange(index - 1, index, '');
    _valueController.value = TextEditingValue(
      text: updated,
      selection: TextSelection.collapsed(offset: index - 1),
    );
    setState(() {});
  }

  int? _chipIndexForDate(DateTime date) {
    final target = _dateOnly(date);
    final today = _dateOnly(DateTime.now());
    for (var i = 0; i < 3; i++) {
      if (target == today.subtract(Duration(days: i))) return i;
    }
    return null;
  }

  int? _chipIndexForDateTime(DateTime dt) {
    final now = DateTime.now();
    final targets = [
      now,
      now.subtract(const Duration(hours: 1)),
      now.subtract(const Duration(hours: 2)),
    ];
    for (var i = 0; i < targets.length; i++) {
      final t = targets[i];
      if (dt.year == t.year &&
          dt.month == t.month &&
          dt.day == t.day &&
          dt.hour == t.hour &&
          (dt.minute - t.minute).abs() <= 1) {
        return i;
      }
    }
    return null;
  }

  TextInputType get _valueInputType {
    final kt = widget.keyboardType.toLowerCase();
    if (kt == 'number' || kt == 'numeric' || kt == 'decimal') {
      return const TextInputType.numberWithOptions(decimal: true);
    }
    return TextInputType.text;
  }

  List<TextInputFormatter>? get _valueFormatters {
    final kt = widget.keyboardType.toLowerCase();
    if (kt == 'number' || kt == 'numeric' || kt == 'decimal') {
      return [FilteringTextInputFormatter.allow(RegExp(r'[\d.]'))];
    }
    return null;
  }

  void _dismissKeyboard() {
    _valueFocus.unfocus();
    if (mounted) {
      FocusScope.of(context).unfocus();
    }
    FocusManager.instance.primaryFocus?.unfocus();
    SystemChannels.textInput.invokeMethod('TextInput.hide');
  }

  void _closeSheet([RepeatableReadingEntry? result]) {
    _dismissKeyboard();
    if (!mounted) return;
    Navigator.pop(context, result);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      SystemChannels.textInput.invokeMethod('TextInput.hide');
    });
  }

  void _onSave() {
    setState(() => _attemptedSave = true);
    if (!_canSave) return;

    final entry = RepeatableReadingEntry(
      dateTime: _combinedDateTime,
      value: _valueController.text.trim(),
    );

    if (_isEdit &&
        widget.initialEntry != null &&
        widget.initialEntry!.hasSameDataAs(entry)) {
      _closeSheet();
      return;
    }

    _closeSheet(entry);
  }

  void _applyDateShortcut(int daysAgo) {
    final base = DateTime.now().subtract(Duration(days: daysAgo));
    setState(() {
      _selectedDate = _dateOnly(base);
      _dateChipIndex = daysAgo;
      _activeField = _ReadingField.date;
    });
  }

  void _applyTimeShortcut(Duration offset) {
    final dt = DateTime.now().add(offset);
    setState(() {
      _selectedDate = _dateOnly(dt);
      _selectedTime = TimeOfDay(hour: dt.hour, minute: dt.minute);
      _timeChipIndex = offset == Duration.zero
          ? 0
          : offset == const Duration(hours: -1)
              ? 1
              : 2;
      _activeField = _ReadingField.time;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        final isDarkMode = themeState is ThemeLoaded && themeState.isDarkMode;
        final isValueField = _activeField == _ReadingField.value;
        final showDateTimePanel = !isValueField;
        final showValueNumpad = isValueField && _useEmbeddedNumpad;

        Widget? bottomPanel;
        if (showDateTimePanel) {
          bottomPanel = _BottomToolPanel(
            showChips: true,
            chips: _QuickChips(
              selectedIndex: _activeField == _ReadingField.time
                  ? _timeChipIndex
                  : _dateChipIndex,
              labels: _activeField == _ReadingField.time
                  ? [
                      context.tr(AppStrings.now),
                      context.tr(AppStrings.oneHourAgo),
                      context.tr(AppStrings.twoHoursAgo),
                    ]
                  : [
                      context.tr(AppStrings.today),
                      context.tr(AppStrings.yesterday),
                      context.tr(AppStrings.twoDaysAgo),
                    ],
              onSelected: (index) {
                if (_activeField == _ReadingField.time) {
                  if (index == 0) {
                    _applyTimeShortcut(Duration.zero);
                  } else if (index == 1) {
                    _applyTimeShortcut(const Duration(hours: -1));
                  } else {
                    _applyTimeShortcut(const Duration(hours: -2));
                  }
                } else {
                  _applyDateShortcut(index);
                }
              },
            ),
            tool: CupertinoTheme(
              data: CupertinoThemeData(
                brightness: isDarkMode ? Brightness.dark : Brightness.light,
              ),
              child: _activeField == _ReadingField.date
                  ? CupertinoDatePicker(
                      key: ValueKey(
                        'date-${_selectedDate.year}-${_selectedDate.month}-${_selectedDate.day}',
                      ),
                      mode: CupertinoDatePickerMode.date,
                      initialDateTime: _selectedDate,
                      minimumDate: DateTime(1900),
                      maximumDate: DateTime(2100),
                      onDateTimeChanged: (val) {
                        setState(() {
                          _selectedDate = _dateOnly(val);
                          _dateChipIndex = _chipIndexForDate(_selectedDate);
                        });
                      },
                    )
                  : CupertinoDatePicker(
                      key: ValueKey(
                        'time-${_selectedTime?.hour}-${_selectedTime?.minute}',
                      ),
                      mode: CupertinoDatePickerMode.time,
                      initialDateTime: DateTime(
                        _selectedDate.year,
                        _selectedDate.month,
                        _selectedDate.day,
                        _selectedTime?.hour ?? 0,
                        _selectedTime?.minute ?? 0,
                      ),
                      use24hFormat: true,
                      onDateTimeChanged: (val) {
                        setState(() {
                          _selectedTime =
                              TimeOfDay(hour: val.hour, minute: val.minute);
                          _timeChipIndex = _chipIndexForDateTime(
                            _combinedDateTimeFromParts(),
                          );
                        });
                      },
                    ),
            ),
          );
        } else if (showValueNumpad) {
          bottomPanel = _BottomToolPanel(
            showChips: false,
            chips: const SizedBox.shrink(),
            tool: _EmbeddedNumpad(
              isDarkMode: isDarkMode,
              onKey: _appendValueChar,
              onBackspace: _backspaceValue,
            ),
          );
        }

        final fields = Padding(
          padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 8.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _ReadingFieldTile(
                label: context.tr(AppStrings.fieldDate),
                icon: Icons.calendar_today_outlined,
                value: DateFormat('d MMM yyyy').format(_selectedDate),
                isActive: _activeField == _ReadingField.date,
                isValid: _isDateValid,
                showError: _attemptedSave && !_isDateValid,
                onTap: () {
                  _valueFocus.unfocus();
                  setState(() => _activeField = _ReadingField.date);
                },
              ),
              SizedBox(height: 8.h),
              _ReadingFieldTile(
                label: context.tr(AppStrings.fieldTimeOptional),
                icon: Icons.access_time_rounded,
                value: _selectedTime == null
                    ? '—'
                    : _selectedTime!.format(context),
                isActive: _activeField == _ReadingField.time,
                isValid: true,
                showError: false,
                onTap: () {
                  _valueFocus.unfocus();
                  setState(() => _activeField = _ReadingField.time);
                },
              ),
              SizedBox(height: 8.h),
              _ReadingFieldTile(
                label: context.tr(AppStrings.fieldValue),
                letterLeading: true,
                showRequiredAsterisk: true,
                value: _valueController.text.isEmpty
                    ? null
                    : _valueController.text,
                isActive: isValueField,
                isValid: _isValueValid,
                showError: _attemptedSave && !_isValueValid,
                onTap: () {
                  setState(() => _activeField = _ReadingField.value);
                  _valueFocus.requestFocus();
                },
                valueLineHeight: 15.sp * 1.2,
                child: isValueField
                    ? TextField(
                        controller: _valueController,
                        focusNode: _valueFocus,
                        maxLines: 1,
                        minLines: 1,
                        keyboardType: _useEmbeddedNumpad
                            ? TextInputType.none
                            : _valueInputType,
                        readOnly: _useEmbeddedNumpad,
                        showCursor: true,
                        inputFormatters:
                            _useEmbeddedNumpad ? null : _valueFormatters,
                        cursorWidth: 1.2,
                        cursorHeight: 14,
                        textAlignVertical: TextAlignVertical.center,
                        style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w600,
                          height: 1.2,
                          color: isDarkMode
                              ? AppColors.darkTitle
                              : Colors.black87,
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 10.w,
                          ),
                        ),
                        onChanged: (_) => setState(() {}),
                      )
                    : null,
              ),
            ],
          ),
        );

        return SafeArea(
          top: false,
          minimum: const EdgeInsets.only(bottom: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 8, bottom: 4),
                width: 36,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey.shade400,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              _SheetHeader(
                title: _isEdit
                    ? context.tr(AppStrings.editReading)
                    : context.tr(AppStrings.addReadingTitle),
                canSave: _canSave,
                onCancel: _closeSheet,
                onSave: _onSave,
              ),
              fields,
              if (bottomPanel != null) bottomPanel,
            ],
          ),
        );
      },
    );
  }
}

class _SheetHeader extends StatelessWidget {
  final String title;
  final bool canSave;
  final VoidCallback onCancel;
  final VoidCallback onSave;

  const _SheetHeader({
    required this.title,
    required this.canSave,
    required this.onCancel,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
      child: Row(
        children: [
          TextButton(
            onPressed: onCancel,
            child: Text(
              context.tr(AppStrings.cancel),
              style: TextStyle(
                color: AppColors.primary,
                fontWeight: FontWeight.w600,
                fontSize: 13.sp,
              ),
            ),
          ),
          Expanded(
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 15.sp,
              ),
            ),
          ),
          TextButton(
            onPressed: onSave,
            child: Text(
              context.tr(AppStrings.save),
              style: TextStyle(
                color: canSave
                    ? AppColors.primary
                    : AppColors.primary.withOpacity(0.35),
                fontWeight: FontWeight.w700,
                fontSize: 13.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BottomToolPanel extends StatelessWidget {
  final Widget chips;
  final Widget tool;
  final bool showChips;

  const _BottomToolPanel({
    required this.chips,
    required this.tool,
    this.showChips = true,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: _bottomPanelWithChips,
      child: Column(
        children: [
          if (showChips)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: SizedBox(height: _chipsHeight, child: chips),
            ),
          Expanded(
            child: ClipRect(
              child: Align(
                alignment: Alignment.topCenter,
                child: tool,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ReadingFieldTile extends StatelessWidget {
  final String label;
  final IconData? icon;
  final bool letterLeading;
  final String? value;
  final bool isActive;
  final bool isValid;
  final bool showError;
  final double? valueLineHeight;
  final bool showRequiredAsterisk;
  final VoidCallback onTap;
  final Widget? child;

  const _ReadingFieldTile({
    required this.label,
    this.icon,
    this.letterLeading = false,
    this.showRequiredAsterisk = false,
    required this.value,
    required this.isActive,
    required this.isValid,
    required this.showError,
    required this.onTap,
    this.valueLineHeight,
    this.child,
  }) : assert(icon != null || letterLeading);

  Widget _buildLeading() {
    if (letterLeading) {
      return SizedBox(
        width: 18.sp,
        child: Text(
          'A',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 17.sp,
            fontWeight: FontWeight.w700,
            height: 1,
            color: showError ? Colors.red.shade600 : AppColors.primary,
          ),
        ),
      );
    }
    return Icon(icon, color: AppColors.primary, size: 18.sp);
  }

  Color _valueTextColor(bool isDarkMode, String? value) {
    final isPlaceholder = value == null || value.isEmpty || value == '—';
    if (isPlaceholder) {
      return isDarkMode ? AppColors.darkDescription : Colors.grey.shade500;
    }
    return isDarkMode ? AppColors.darkTitle : Colors.black87;
  }

  Widget _buildValueRow({
    required bool isDarkMode,
    required double? valueLineHeight,
    required Widget? child,
    required String? value,
  }) {
    final valueColor = _valueTextColor(isDarkMode, value);

    if (valueLineHeight == null) {
      return Align(
        alignment: Alignment.centerLeft,
        child: Text(
          value ?? '',
          style: TextStyle(
            fontSize: 15.sp,
            fontWeight: FontWeight.w600,
            color: valueColor,
          ),
        ),
      );
    }

    // Fixed slot — TextField expands to fill it; outer tile height unchanged.
    if (child != null) {
      return SizedBox(
        height: valueLineHeight,
        width: double.infinity,
        child: child,
      );
    }

    return SizedBox(
      height: valueLineHeight,
      width: double.infinity,
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          value ?? '',
          style: TextStyle(
            fontSize: 15.sp,
            fontWeight: FontWeight.w600,
            color: valueColor,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        final isDarkMode = themeState is ThemeLoaded && themeState.isDarkMode;

        final hasValue = value != null && value!.isNotEmpty && value != '—';

        Color borderColor;
        Color fillColor;
        if (showError) {
          borderColor = Colors.red.shade400;
          fillColor =
              isDarkMode ? const Color(0xFF3A2222) : const Color(0xFFFFEBEE);
        } else if (isValid && !isActive && hasValue) {
          borderColor =
              isDarkMode ? Colors.green.shade600 : Colors.green.shade400;
          fillColor =
              isDarkMode ? const Color(0xFF1E3326) : const Color(0xFFE8F5E9);
        } else if (isActive) {
          borderColor = AppColors.primary;
          fillColor = isDarkMode ? AppColors.darkSurface : Colors.white;
        } else {
          borderColor =
              isDarkMode ? AppColors.darkBorder : Colors.grey.shade300;
          fillColor = isDarkMode ? AppColors.darkSurface : AppColors.subBG;
        }

        Widget? trailing;
        if (isValid && value != null && value!.isNotEmpty && !isActive) {
          trailing = Container(
            width: 20.w,
            height: 20.w,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.green.shade500,
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.check, color: Colors.white, size: 11.sp),
          );
        }

        return Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(10.r),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: fillColor,
                borderRadius: BorderRadius.circular(10.r),
                border:
                    Border.all(color: borderColor, width: isActive ? 1.5 : 1),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _buildLeading(),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          children: [
                            Text(
                              label,
                              style: TextStyle(
                                fontSize: 9.sp,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.5,
                                color: isActive
                                    ? AppColors.primary
                                    : (isDarkMode
                                        ? AppColors.darkDescription
                                        : Colors.grey.shade600),
                              ),
                            ),
                            if (showRequiredAsterisk)
                              Text(
                                ' *',
                                style: TextStyle(
                                  fontSize: 9.sp,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.red.shade600,
                                ),
                              ),
                          ],
                        ),
                        SizedBox(height: 2.h),
                        _buildValueRow(
                          isDarkMode: isDarkMode,
                          valueLineHeight: valueLineHeight,
                          child: child,
                          value: value,
                        ),
                      ],
                    ),
                  ),
                  if (trailing != null)
                    Padding(
                      padding: EdgeInsets.only(left: 6.w),
                      child: trailing,
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _EmbeddedNumpad extends StatelessWidget {
  final bool isDarkMode;
  final ValueChanged<String> onKey;
  final VoidCallback onBackspace;

  const _EmbeddedNumpad({
    required this.isDarkMode,
    required this.onKey,
    required this.onBackspace,
  });

  @override
  Widget build(BuildContext context) {
    const keys = [
      ['1', '2', '3'],
      ['4', '5', '6'],
      ['7', '8', '9'],
      ['.', '0', '⌫'],
    ];

    final backgroundColor = isDarkMode ? AppColors.darkCardBG : Colors.white;
    final dividerColor =
        isDarkMode ? AppColors.darkBorder : Colors.grey.shade300;
    final keyTextColor =
        isDarkMode ? AppColors.darkTitle : Colors.grey.shade900;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: backgroundColor,
        border: Border(
          top: BorderSide(color: dividerColor, width: 0.5),
        ),
      ),
      child: Column(
        children: [
          for (var rowIndex = 0; rowIndex < keys.length; rowIndex++)
            Expanded(
              child: Row(
                children: [
                  for (var colIndex = 0;
                      colIndex < keys[rowIndex].length;
                      colIndex++)
                    Expanded(
                      child: _NumpadKey(
                        label: keys[rowIndex][colIndex],
                        dividerColor: dividerColor,
                        textColor: keyTextColor,
                        showTopDivider: rowIndex > 0,
                        showLeftDivider: colIndex > 0,
                        onTap: () {
                          final key = keys[rowIndex][colIndex];
                          if (key == '⌫') {
                            onBackspace();
                          } else {
                            onKey(key);
                          }
                        },
                      ),
                    ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class _NumpadKey extends StatelessWidget {
  final String label;
  final Color dividerColor;
  final Color textColor;
  final bool showTopDivider;
  final bool showLeftDivider;
  final VoidCallback onTap;

  const _NumpadKey({
    required this.label,
    required this.dividerColor,
    required this.textColor,
    required this.showTopDivider,
    required this.showLeftDivider,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border(
              top: showTopDivider
                  ? BorderSide(color: dividerColor, width: 0.5)
                  : BorderSide.none,
              left: showLeftDivider
                  ? BorderSide(color: dividerColor, width: 0.5)
                  : BorderSide.none,
            ),
          ),
          child: label == '⌫'
              ? Icon(Icons.backspace_outlined, size: 20.sp, color: textColor)
              : Text(
                  label,
                  style: TextStyle(
                    fontSize: 22.sp,
                    fontWeight: FontWeight.w400,
                    color: textColor,
                  ),
                ),
        ),
      ),
    );
  }
}

class _QuickChips extends StatelessWidget {
  final List<String> labels;
  final int? selectedIndex;
  final ValueChanged<int> onSelected;

  const _QuickChips({
    required this.labels,
    required this.selectedIndex,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        final isDarkMode = themeState is ThemeLoaded && themeState.isDarkMode;

        return Row(
          children: List.generate(labels.length, (index) {
            final isSelected = selectedIndex == index;
            return Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: index == 0 ? 0 : 6.w),
                child: GestureDetector(
                  onTap: () => onSelected(index),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 7.h),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppColors.primary
                          : (isDarkMode
                              ? AppColors.darkSurface
                              : AppColors.primary.withOpacity(0.08)),
                      borderRadius: BorderRadius.circular(18.r),
                      border: Border.all(
                        color: isSelected
                            ? AppColors.primary
                            : (isDarkMode
                                ? AppColors.darkBorder
                                : AppColors.primary.withOpacity(0.35)),
                        width: 1,
                      ),
                    ),
                    child: Text(
                      labels[index],
                      style: TextStyle(
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w600,
                        color: isSelected
                            ? Colors.white
                            : (isDarkMode
                                ? AppColors.darkTitle
                                : AppColors.primary),
                      ),
                    ),
                  ),
                ),
              ),
            );
          }),
        );
      },
    );
  }
}

Future<RepeatableReadingEntry?> showAddRepeatableReadingSheet({
  required BuildContext context,
  RepeatableReadingEntry? initialEntry,
  String keyboardType = 'text',
}) {
  return showModalBottomSheet<RepeatableReadingEntry>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (ctx) => BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        final isDarkMode = themeState is ThemeLoaded && themeState.isDarkMode;
        final media = MediaQuery.of(context);
        final keyboardInset = media.viewInsets.bottom;
        final availableHeight =
            media.size.height - keyboardInset - media.padding.top;
        final maxSheetHeight = keyboardInset > 0
            ? availableHeight
            : media.size.height * 0.75;

        return Padding(
          padding: EdgeInsets.only(bottom: keyboardInset),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: ConstrainedBox(
              constraints: BoxConstraints(maxHeight: maxSheetHeight),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: isDarkMode ? AppColors.darkCardBG : Colors.white,
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(20)),
                ),
                clipBehavior: Clip.antiAlias,
                child: AddRepeatableReadingSheet(
                  initialEntry: initialEntry,
                  keyboardType: keyboardType,
                ),
              ),
            ),
          ),
        );
      },
    ),
  ).whenComplete(() {
    FocusManager.instance.primaryFocus?.unfocus();
    SystemChannels.textInput.invokeMethod('TextInput.hide');
  });
}
