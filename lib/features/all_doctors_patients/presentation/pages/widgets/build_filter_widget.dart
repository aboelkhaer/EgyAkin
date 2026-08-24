import 'dart:developer';
import 'dart:ui';

import 'package:egy_akin/exports.dart';
import 'package:egy_akin/features/all_doctors_patients/data/models/get_filters_options_model_response.dart';
import 'package:egy_akin/features/home/presentation/widgets/dashboard/home_dashboard_shared.dart';

class BuildFilterWidget extends StatefulWidget {
  final List<GetFiltersOptionsDataModelResponse>? filters;
  final dynamic cubit;
  final bool isCurrentDoctor;

  const BuildFilterWidget({
    super.key,
    required this.filters,
    required this.cubit,
    required this.isCurrentDoctor,
  });

  @override
  State<BuildFilterWidget> createState() => _BuildFilterWidgetState();
}

class _BuildFilterWidgetState extends State<BuildFilterWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _introController;
  late final Animation<double> _headerFade;
  late final Animation<Offset> _headerSlide;
  late final Animation<double> _listFade;

  @override
  void initState() {
    super.initState();
    if (widget.cubit != null && widget.filters != null) {
      try {
        widget.cubit.setFiltersForRequest(widget.filters);
        widget.cubit.textFormFieldControllersInit(widget.filters!);
      } catch (e) {
        log('textFormFieldControllersInit not available: $e');
      }
    }

    _introController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
    _headerFade = CurvedAnimation(
      parent: _introController,
      curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
    );
    _headerSlide = Tween<Offset>(
      begin: const Offset(0, -0.12),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _introController,
        curve: const Interval(0.0, 0.55, curve: Curves.easeOutCubic),
      ),
    );
    _listFade = CurvedAnimation(
      parent: _introController,
      curve: const Interval(0.25, 1.0, curve: Curves.easeOut),
    );
    _introController.forward();
  }

  @override
  void dispose() {
    _introController.dispose();
    super.dispose();
  }

  int get _activeFilterCount {
    final data = widget.cubit.formData;
    if (data is! Map) return 0;
    var count = 0;
    for (final entry in data.entries) {
      final key = entry.key.toString();
      if (key.contains('_from') || key.contains('_to')) continue;
      final value = entry.value?.toString().trim() ?? '';
      if (value.isNotEmpty && value != '{}' && value != '{from:}' && value != '{to:}') {
        count++;
      }
    }
    return count;
  }

  String? _extractDateFromString(String? dateString, String key) {
    if (dateString == null || dateString.isEmpty) return null;
    try {
      if (dateString.contains('$key:')) {
        final parts = dateString.split('$key:');
        if (parts.length > 1) {
          return parts[1].split(',')[0].split('}')[0];
        }
      }
    } catch (e) {
      log('Error extracting date: $e');
    }
    return null;
  }

  String? _extractNumberFromString(String? numberString, String key) {
    if (numberString == null || numberString.isEmpty) return null;
    try {
      if (numberString.contains('$key:')) {
        final parts = numberString.split('$key:');
        if (parts.length > 1) {
          return parts[1].split(',')[0].split('}')[0];
        }
      }
    } catch (e) {
      log('Error extracting number: $e');
    }
    return null;
  }

  IconData _iconForType(String? type) {
    switch (type) {
      case 'string':
        return Icons.short_text_rounded;
      case 'select':
        return Icons.arrow_drop_down_circle_outlined;
      case 'checkbox':
        return Icons.radio_button_checked_rounded;
      case 'multiple':
        return Icons.checklist_rounded;
      case 'date_range':
        return Icons.date_range_rounded;
      case 'number_range':
        return Icons.pin_rounded;
      default:
        return Icons.tune_rounded;
    }
  }

  Color _accentForIndex(int index) {
    const accents = [
      Color(0xFF6B47E6),
      Color(0xFF0EA5E9),
      Color(0xFF14B8A6),
      Color(0xFFF59E0B),
      Color(0xFFEF4444),
      Color(0xFF8B5CF6),
    ];
    return accents[index % accents.length];
  }

  Future<DateTime?> _pickDate(BuildContext context, bool isDark) {
    return showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: isDark
                ? const ColorScheme.dark(
                    primary: AppColors.primary,
                    onPrimary: Colors.white,
                    surface: Color(0xFF1E1B2E),
                    onSurface: Colors.white,
                  )
                : const ColorScheme.light(
                    primary: AppColors.primary,
                    onPrimary: Colors.white,
                    surface: Colors.white,
                    onSurface: Color(0xFF111827),
                  ),
          ),
          child: child!,
        );
      },
    );
  }

  String _formatPicked(DateTime picked) {
    return '${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        final isDark = themeState is ThemeLoaded && themeState.isDarkMode;
        final primary = HomeDashboardColors.primary(isDark);
        final scaffold = HomeDashboardColors.scaffold(isDark);
        final filters = widget.filters ?? const <GetFiltersOptionsDataModelResponse>[];
        final activeCount = _activeFilterCount;
        final footerGap = 8.h;

        return ColoredBox(
          color: scaffold,
          child: Stack(
            children: [
              Positioned(
                top: -28.h,
                right: -24.w,
                child: ImageFiltered(
                  imageFilter: ImageFilter.blur(sigmaX: 28, sigmaY: 28),
                  child: Container(
                    width: 110.r,
                    height: 110.r,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: primary.withOpacity(isDark ? 0.14 : 0.08),
                    ),
                  ),
                ),
              ),
              Column(
                children: [
                  FadeTransition(
                    opacity: _headerFade,
                    child: SlideTransition(
                      position: _headerSlide,
                      child: _FilterHeader(
                        isDark: isDark,
                        primary: primary,
                        activeCount: activeCount,
                        totalCount: filters.length,
                        onClose: () => Navigator.of(context).maybePop(),
                      ),
                    ),
                  ),
                  Expanded(
                    child: FadeTransition(
                      opacity: _listFade,
                      child: filters.isEmpty
                          ? Center(
                              child: Text(
                                context.tr(AppStrings.noData),
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  color: HomeDashboardColors.subtitle(isDark),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            )
                          : ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              padding: EdgeInsets.fromLTRB(
                                12.w,
                                4.h,
                                12.w,
                                52.h,
                              ),
                              itemCount: filters.length,
                              itemBuilder: (context, index) {
                                final filter = filters[index];
                                final accent = _accentForIndex(index);
                                return TweenAnimationBuilder<double>(
                                  tween: Tween(begin: 0, end: 1),
                                  duration: Duration(
                                    milliseconds: 280 + (index * 40),
                                  ),
                                  curve: Curves.easeOutCubic,
                                  builder: (context, t, child) {
                                    return Opacity(
                                      opacity: t.clamp(0.0, 1.0),
                                      child: Transform.translate(
                                        offset: Offset(0, (1 - t) * 10),
                                        child: child,
                                      ),
                                    );
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.only(bottom: 8.h),
                                    child: _FilterSectionCard(
                                      isDark: isDark,
                                      accent: accent,
                                      icon: _iconForType(filter.type),
                                      title: filter.condition?.toString() ?? '',
                                      child: _buildFilterControl(
                                        filter: filter,
                                        isDark: isDark,
                                        accent: accent,
                                        primary: primary,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                    ),
                  ),
                ],
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: _FilterFooter(
                  isDark: isDark,
                  primary: primary,
                  bottomInset: footerGap,
                  onReset: () {
                    try {
                      widget.cubit.resetFormData();
                      setState(() {});
                    } catch (e) {
                      log('resetFormData not available: $e');
                    }
                  },
                  onApply: () {
                    Navigator.of(context).pop();
                    try {
                      widget.cubit.applyPatientFilters(
                        widget.isCurrentDoctor ? 'true' : 'false',
                      );
                    } catch (e) {
                      log('applyPatientFilters not available: $e');
                    }
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildFilterControl({
    required GetFiltersOptionsDataModelResponse filter,
    required bool isDark,
    required Color accent,
    required Color primary,
  }) {
    switch (filter.type) {
      case 'string':
        return CustomTextFormField(
          title: filter.condition.toString(),
          textFormFieldController:
              widget.cubit.controllers[filter.id.toString()],
          textInputType: filter.keyboardType == 'number'
              ? TextInputType.phone
              : filter.keyboardType == 'email'
                  ? TextInputType.emailAddress
                  : filter.keyboardType == 'date'
                      ? TextInputType.datetime
                      : TextInputType.text,
          textInputAction: TextInputAction.next,
          inputFormatters: [
            LengthLimitingTextInputFormatter(255),
          ],
          validator: (_) => null,
          onChanged: (value) {
            setState(() {
              widget.cubit.formData[filter.id.toString()] = value.toString();
            });
          },
        );

      case 'select':
        dynamic selectedValue;
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 2.w),
          decoration: BoxDecoration(
            color: HomeDashboardColors.surfaceBg(isDark),
            borderRadius: BorderRadius.circular(10.r),
            border: Border.all(
              color: HomeDashboardColors.border(isDark).withOpacity(0.8),
            ),
          ),
          child: DropdownButtonFormField<dynamic>(
            isDense: true,
            hint: Text(
              selectedValue ?? context.tr(AppStrings.choose),
              style: TextStyle(
                color: HomeDashboardColors.subtitle(isDark),
                fontSize: 11.5.sp,
              ),
            ),
            validator: (_) => null,
            value: widget.cubit.formData[filter.id.toString()] == null ||
                    widget.cubit.formData[filter.id.toString()] == ''
                ? selectedValue
                : widget.cubit.formData[filter.id.toString()],
            items: filter.values!.map((value) {
              return DropdownMenuItem<dynamic>(
                value: value,
                child: Text(
                  value.toString(),
                  style: TextStyle(
                    color: HomeDashboardColors.title(isDark),
                    fontSize: 11.5.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                widget.cubit.formData[filter.id.toString()] = value.toString();
              });
            },
            isExpanded: true,
            menuMaxHeight: 200,
            icon: Icon(
              Icons.keyboard_arrow_down_rounded,
              color: primary,
              size: 18.sp,
            ),
            decoration: const InputDecoration(
              border: OutlineInputBorder(borderSide: BorderSide.none),
              isDense: true,
              contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            ),
          ),
        );

      case 'checkbox':
        return Wrap(
          spacing: 6.w,
          runSpacing: 6.h,
          children: filter.values!.map((answer) {
            final answerStr = answer.toString();
            final groupValue =
                widget.cubit.formData[filter.id.toString()]?.toString();
            final selected = groupValue == answerStr;
            return _ChoicePill(
              label: answerStr,
              selected: selected,
              accent: accent,
              isDark: isDark,
              onTap: () {
                setState(() {
                  widget.cubit.formData[filter.id.toString()] = answerStr;
                });
              },
            );
          }).toList(),
        );

      case 'multiple':
        {
          final stored = widget.cubit.formData[filter.id.toString()];
          final List<String> selectedList =
              stored != null && stored.toString().trim().isNotEmpty
                  ? stored
                      .toString()
                      .split(',')
                      .map((e) => e.trim())
                      .where((e) => e.isNotEmpty)
                      .toList()
                  : [];
          return Wrap(
            spacing: 6.w,
            runSpacing: 6.h,
            children: filter.values!.map((value) {
              final valueStr = value.toString();
              final isSelected = selectedList.contains(valueStr);
              return _ChoicePill(
                label: valueStr,
                selected: isSelected,
                accent: accent,
                isDark: isDark,
                multi: true,
                onTap: () {
                  setState(() {
                    final updated = List<String>.from(selectedList);
                    if (isSelected) {
                      updated.remove(valueStr);
                    } else if (!updated.contains(valueStr)) {
                      updated.add(valueStr);
                    }
                    widget.cubit.formData[filter.id.toString()] =
                        updated.join(',');
                  });
                },
              );
            }).toList(),
          );
        }

      case 'date_range':
        return Row(
          children: [
            Expanded(
              child: _DateTile(
                isDark: isDark,
                accent: accent,
                label: context.tr(AppStrings.from),
                value: _extractDateFromString(
                      widget.cubit.formData['${filter.id}'],
                      'from',
                    ) ??
                    context.tr(AppStrings.selectDate),
                onTap: () async {
                  final picked = await _pickDate(context, isDark);
                  if (picked == null) return;
                  setState(() {
                    final existingTo = _extractDateFromString(
                      widget.cubit.formData['${filter.id}'],
                      'to',
                    );
                    final fromDate = _formatPicked(picked);
                    var newValue = '{from:$fromDate';
                    if (existingTo != null) newValue += ',to:$existingTo';
                    newValue += '}';
                    widget.cubit.formData['${filter.id}'] = newValue;
                  });
                },
              ),
            ),
            SizedBox(width: 8.w),
            Expanded(
              child: _DateTile(
                isDark: isDark,
                accent: accent,
                label: context.tr(AppStrings.to),
                value: _extractDateFromString(
                      widget.cubit.formData['${filter.id}'],
                      'to',
                    ) ??
                    context.tr(AppStrings.selectDate),
                onTap: () async {
                  final picked = await _pickDate(context, isDark);
                  if (picked == null) return;
                  setState(() {
                    final existingFrom = _extractDateFromString(
                      widget.cubit.formData['${filter.id}'],
                      'from',
                    );
                    final toDate = _formatPicked(picked);
                    final newValue = existingFrom != null
                        ? '{from:$existingFrom,to:$toDate}'
                        : '{to:$toDate}';
                    widget.cubit.formData['${filter.id}'] = newValue;
                  });
                },
              ),
            ),
          ],
        );

      case 'number_range':
        return Row(
          children: [
            Expanded(
              child: Builder(
                builder: (context) {
                  final fromKey = '${filter.id}_from';
                  final existingFromText = _extractNumberFromString(
                        widget.cubit.formData['${filter.id}'],
                        'from',
                      ) ??
                      '';
                  final fromController = widget.cubit.controllers[fromKey] ??
                      TextEditingController(text: existingFromText);
                  widget.cubit.controllers[fromKey] = fromController;

                  return CustomTextFormField(
                    title: context.tr(AppStrings.from),
                    textFormFieldController: fromController,
                    textInputType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(10),
                    ],
                    validator: (_) => null,
                    onChanged: (value) {
                      setState(() {
                        final existingTo = _extractNumberFromString(
                          widget.cubit.formData['${filter.id}'],
                          'to',
                        );
                        var newValue = '{from:$value';
                        if (existingTo != null) newValue += ',to:$existingTo';
                        newValue += '}';
                        widget.cubit.formData['${filter.id}'] = newValue;
                      });
                    },
                  );
                },
              ),
            ),
            SizedBox(width: 8.w),
            Expanded(
              child: Builder(
                builder: (context) {
                  final toKey = '${filter.id}_to';
                  final existingToText = _extractNumberFromString(
                        widget.cubit.formData['${filter.id}'],
                        'to',
                      ) ??
                      '';
                  final toController = widget.cubit.controllers[toKey] ??
                      TextEditingController(text: existingToText);
                  widget.cubit.controllers[toKey] = toController;

                  return CustomTextFormField(
                    title: context.tr(AppStrings.to),
                    textFormFieldController: toController,
                    textInputType: TextInputType.number,
                    textInputAction: TextInputAction.done,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(10),
                    ],
                    validator: (_) => null,
                    onChanged: (value) {
                      setState(() {
                        final existingFrom = _extractNumberFromString(
                          widget.cubit.formData['${filter.id}'],
                          'from',
                        );
                        final newValue = existingFrom != null
                            ? '{from:$existingFrom,to:$value}'
                            : '{to:$value}';
                        widget.cubit.formData['${filter.id}'] = newValue;
                      });
                    },
                  );
                },
              ),
            ),
          ],
        );

      default:
        return const SizedBox.shrink();
    }
  }
}

// ── Header ───────────────────────────────────────────────────────────────────

class _FilterHeader extends StatelessWidget {
  final bool isDark;
  final Color primary;
  final int activeCount;
  final int totalCount;
  final VoidCallback onClose;

  const _FilterHeader({
    required this.isDark,
    required this.primary,
    required this.activeCount,
    required this.totalCount,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(12.w, 6.h, 10.w, 8.h),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isDark
              ? const [Color(0xFF0F172A), Color(0xFF1A1035)]
              : [primary.withOpacity(0.1), HomeDashboardColors.scaffold(isDark)],
        ),
      ),
      child: Column(
        children: [
          Container(
            width: 32.w,
            height: 3.h,
            decoration: BoxDecoration(
              color: (isDark ? Colors.white : Colors.black)
                  .withOpacity(isDark ? 0.28 : 0.18),
              borderRadius: BorderRadius.circular(99),
            ),
          ),
          SizedBox(height: 8.h),
          Row(
            children: [
              Container(
                width: 30.r,
                height: 30.r,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(9.r),
                  gradient: LinearGradient(
                    colors: [primary, primary.withOpacity(0.75)],
                  ),
                ),
                child: Icon(
                  Icons.tune_rounded,
                  color: Colors.white,
                  size: 15.sp,
                ),
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      context.tr(AppStrings.createFilter),
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w800,
                        letterSpacing: -0.2,
                        color: isDark
                            ? Colors.white
                            : HomeDashboardColors.title(false),
                      ),
                    ),
                    Text(
                      activeCount > 0
                          ? '$activeCount active · $totalCount fields'
                          : '$totalCount filter fields',
                      style: TextStyle(
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w600,
                        color: isDark
                            ? Colors.white60
                            : HomeDashboardColors.subtitle(false),
                      ),
                    ),
                  ],
                ),
              ),
              if (activeCount > 0)
                Container(
                  margin: EdgeInsets.only(right: 4.w),
                  padding:
                      EdgeInsets.symmetric(horizontal: 7.w, vertical: 3.h),
                  decoration: BoxDecoration(
                    color: primary.withOpacity(isDark ? 0.28 : 0.14),
                    borderRadius: BorderRadius.circular(99),
                  ),
                  child: Text(
                    '$activeCount',
                    style: TextStyle(
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w800,
                      color: isDark ? Colors.white : primary,
                    ),
                  ),
                ),
              Material(
                color: (isDark ? Colors.white : Colors.black).withOpacity(0.08),
                shape: const CircleBorder(),
                clipBehavior: Clip.antiAlias,
                child: InkWell(
                  onTap: onClose,
                  child: SizedBox(
                    width: 28.r,
                    height: 28.r,
                    child: Icon(
                      Icons.close_rounded,
                      size: 15.sp,
                      color: isDark
                          ? Colors.white
                          : HomeDashboardColors.title(false),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ── Section card ─────────────────────────────────────────────────────────────

class _FilterSectionCard extends StatelessWidget {
  final bool isDark;
  final Color accent;
  final IconData icon;
  final String title;
  final Widget child;

  const _FilterSectionCard({
    required this.isDark,
    required this.accent,
    required this.icon,
    required this.title,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(10.w, 9.h, 10.w, 10.h),
      decoration: HomeDashboardDecor.card(isDark).copyWith(
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: accent.withOpacity(isDark ? 0.24 : 0.14)),
        boxShadow: isDark
            ? null
            : [
                BoxShadow(
                  color: Colors.black.withOpacity(0.025),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 24.r,
                height: 24.r,
                decoration: BoxDecoration(
                  color: accent.withOpacity(isDark ? 0.22 : 0.12),
                  borderRadius: BorderRadius.circular(7.r),
                ),
                child: Icon(icon, size: 13.sp, color: accent),
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w800,
                    color: HomeDashboardColors.title(isDark),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          child,
        ],
      ),
    );
  }
}

// ── Choice pills ─────────────────────────────────────────────────────────────

class _ChoicePill extends StatelessWidget {
  final String label;
  final bool selected;
  final Color accent;
  final bool isDark;
  final bool multi;
  final VoidCallback onTap;

  const _ChoicePill({
    required this.label,
    required this.selected,
    required this.accent,
    required this.isDark,
    required this.onTap,
    this.multi = false,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8.r),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 160),
          curve: Curves.easeOut,
          constraints: BoxConstraints(
            maxWidth: MediaQuery.sizeOf(context).width * 0.4,
          ),
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.r),
            gradient: selected
                ? LinearGradient(
                    colors: [accent, accent.withOpacity(0.78)],
                  )
                : null,
            color: selected ? null : HomeDashboardColors.surfaceBg(isDark),
            border: Border.all(
              color: selected
                  ? accent.withOpacity(0.1)
                  : HomeDashboardColors.border(isDark).withOpacity(0.9),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (multi) ...[
                Icon(
                  selected
                      ? Icons.check_box_rounded
                      : Icons.check_box_outline_blank_rounded,
                  size: 13.sp,
                  color: selected
                      ? Colors.white
                      : HomeDashboardColors.subtitle(isDark),
                ),
                SizedBox(width: 4.w),
              ] else if (selected) ...[
                Icon(Icons.check_rounded, size: 12.sp, color: Colors.white),
                SizedBox(width: 3.w),
              ],
              Flexible(
                child: Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 10.5.sp,
                    fontWeight: FontWeight.w700,
                    color: selected
                        ? Colors.white
                        : HomeDashboardColors.title(isDark),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Date tile ────────────────────────────────────────────────────────────────

class _DateTile extends StatelessWidget {
  final bool isDark;
  final Color accent;
  final String label;
  final String value;
  final VoidCallback onTap;

  const _DateTile({
    required this.isDark,
    required this.accent,
    required this.label,
    required this.value,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label.replaceAll(':', ''),
          style: TextStyle(
            fontSize: 9.5.sp,
            fontWeight: FontWeight.w700,
            color: HomeDashboardColors.subtitle(isDark),
          ),
        ),
        SizedBox(height: 4.h),
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(9.r),
            child: Ink(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 9.h),
              decoration: BoxDecoration(
                color: HomeDashboardColors.surfaceBg(isDark),
                borderRadius: BorderRadius.circular(9.r),
                border: Border.all(
                  color: HomeDashboardColors.border(isDark).withOpacity(0.9),
                ),
              ),
              child: Row(
                children: [
                  Icon(Icons.calendar_month_rounded, size: 13.sp, color: accent),
                  SizedBox(width: 5.w),
                  Expanded(
                    child: Text(
                      value,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 10.5.sp,
                        fontWeight: FontWeight.w700,
                        color: HomeDashboardColors.title(isDark),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// ── Footer actions ───────────────────────────────────────────────────────────

class _FilterFooter extends StatelessWidget {
  final bool isDark;
  final Color primary;
  final double bottomInset;
  final VoidCallback onReset;
  final VoidCallback onApply;

  const _FilterFooter({
    required this.isDark,
    required this.primary,
    required this.bottomInset,
    required this.onReset,
    required this.onApply,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: Container(
          padding: EdgeInsets.fromLTRB(12.w, 8.h, 12.w, bottomInset),
          decoration: BoxDecoration(
            color: (isDark ? const Color(0xFF12101A) : Colors.white)
                .withOpacity(0.94),
            border: Border(
              top: BorderSide(
                color: HomeDashboardColors.border(isDark).withOpacity(0.8),
              ),
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: onReset,
                  style: OutlinedButton.styleFrom(
                    foregroundColor: HomeDashboardColors.title(isDark),
                    side: BorderSide(
                      color: HomeDashboardColors.border(isDark),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 10.h),
                    minimumSize: Size(0, 36.h),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                  ),
                  child: Text(
                    context.tr(AppStrings.reset),
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 8.w),
              Expanded(
                flex: 2,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    gradient: LinearGradient(
                      colors: [primary, primary.withOpacity(0.82)],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: primary.withOpacity(0.22),
                        blurRadius: 8,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: ElevatedButton(
                    onPressed: onApply,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 10.h),
                      minimumSize: Size(0, 36.h),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.check_rounded, size: 15.sp),
                        SizedBox(width: 4.w),
                        Text(
                          context.tr(AppStrings.apply),
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
