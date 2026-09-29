import 'package:egy_akin/exports.dart';
import 'package:egy_akin/features/all_doctors_patients/data/models/patient_sort_models.dart';
import 'package:egy_akin/features/home/presentation/widgets/dashboard/home_dashboard_shared.dart';

/// Bottom sheet: pick a [SortOptionModelResponse] + direction, then apply.
class BuildPatientSortSheet extends StatefulWidget {
  final List<SortOptionModelResponse> options;
  final String? selectedKey;
  final String? selectedDirection;
  final Future<void> Function(({String key, String direction}) selection)
      onApply;

  const BuildPatientSortSheet({
    super.key,
    required this.options,
    required this.selectedKey,
    required this.selectedDirection,
    required this.onApply,
  });

  @override
  State<BuildPatientSortSheet> createState() => _BuildPatientSortSheetState();
}

class _BuildPatientSortSheetState extends State<BuildPatientSortSheet>
    with SingleTickerProviderStateMixin {
  late String? _key;
  late String _direction;
  bool _applying = false;

  late final AnimationController _intro;
  late final Animation<double> _fade;
  late final Animation<Offset> _slide;

  @override
  void initState() {
    super.initState();
    _key = widget.selectedKey ??
        (widget.options.isNotEmpty ? widget.options.first.key : null);
    _direction =
        widget.selectedDirection ?? _defaultDirectionFor(_key) ?? 'desc';

    _intro = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 480),
    );
    _fade = CurvedAnimation(parent: _intro, curve: Curves.easeOut);
    _slide = Tween<Offset>(
      begin: const Offset(0, 0.06),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _intro, curve: Curves.easeOutCubic));
    _intro.forward();
  }

  @override
  void dispose() {
    _intro.dispose();
    super.dispose();
  }

  String? _defaultDirectionFor(String? key) {
    if (key == null) return null;
    for (final o in widget.options) {
      if (o.key == key) return o.defaultDirection;
    }
    return null;
  }

  /// Maps API sort keys to localized labels (falls back to API label / key).
  String _localizedOptionLabel(
    BuildContext context,
    SortOptionModelResponse option,
  ) {
    final key = option.key;
    final mapped = switch (key) {
      'updated_at' => AppStrings.sortByLastUpdated,
      'created_at' => AppStrings.sortByRegistrationDate,
      'name' => AppStrings.sortByPatientName,
      'hospital' => AppStrings.sortByHospital,
      'age' => AppStrings.sortByAge,
      'doctor_name' => AppStrings.sortByDoctorName,
      'marked_at' || 'date_marked' => AppStrings.sortByDateMarked,
      _ => null,
    };
    if (mapped != null) return context.tr(mapped);

    final raw = (option.label ?? option.key ?? '').trim();
    if (raw.isEmpty) return '';
    // If the API already sends an English label we know, translate it.
    final fromLabel = context.tr(raw);
    return fromLabel;
  }

  String? _selectedLocalizedLabel(BuildContext context) {
    for (final o in widget.options) {
      if (o.key == _key) return _localizedOptionLabel(context, o);
    }
    return null;
  }

  IconData _iconFor(String? key) {
    switch (key) {
      case 'updated_at':
        return Icons.update_rounded;
      case 'created_at':
        return Icons.event_available_rounded;
      case 'name':
        return Icons.person_outline_rounded;
      case 'hospital':
        return Icons.local_hospital_outlined;
      case 'age':
        return Icons.cake_outlined;
      case 'doctor_name':
        return Icons.medical_services_outlined;
      case 'marked_at':
      case 'date_marked':
        return Icons.bookmark_border_rounded;
      default:
        return Icons.sort_rounded;
    }
  }

  Future<void> _apply() async {
    final key = _key;
    if (key == null || key.isEmpty || _applying) return;
    setState(() => _applying = true);
    try {
      await widget.onApply((key: key, direction: _direction));
      if (mounted) Navigator.of(context).maybePop();
    } catch (_) {
      if (mounted) setState(() => _applying = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        final isDark = themeState is ThemeLoaded && themeState.isDarkMode;
        final primary = HomeDashboardColors.primary(isDark);
        final title = HomeDashboardColors.title(isDark);
        final subtitle = HomeDashboardColors.subtitle(isDark);
        final surface = isDark
            ? Colors.white.withOpacity(0.045)
            : Colors.black.withOpacity(0.03);
        final hairline = isDark
            ? Colors.white.withOpacity(0.08)
            : Colors.black.withOpacity(0.06);

        return SafeArea(
          top: false,
          child: FadeTransition(
            opacity: _fade,
            child: SlideTransition(
              position: _slide,
              child: Padding(
                padding: EdgeInsets.fromLTRB(18.w, 10.h, 18.w, 12.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Center(
                      child: Container(
                        width: 36.w,
                        height: 4.h,
                        decoration: BoxDecoration(
                          color: subtitle.withOpacity(0.35),
                          borderRadius: BorderRadius.circular(999),
                        ),
                      ),
                    ),
                    SizedBox(height: 14.h),
                    Row(
                      children: [
                        Container(
                          width: 36.w,
                          height: 36.w,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                primary.withOpacity(isDark ? 0.35 : 0.2),
                                primary.withOpacity(isDark ? 0.12 : 0.06),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(11.r),
                            border: Border.all(
                              color: primary.withOpacity(0.28),
                            ),
                          ),
                          child: Icon(
                            Icons.swap_vert_rounded,
                            size: 18.sp,
                            color: primary,
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                context.tr(AppStrings.sort),
                                style: TextStyle(
                                  fontSize: 17.sp,
                                  fontWeight: FontWeight.w800,
                                  color: title,
                                  letterSpacing: -0.2,
                                ),
                              ),
                              SizedBox(height: 2.h),
                              Builder(
                                builder: (context) {
                                  final selected =
                                      _selectedLocalizedLabel(context);
                                  final subtitleText = selected == null
                                      ? context
                                          .tr(AppStrings.chooseSortOption)
                                      : '$selected · ${_direction == 'asc' ? context.tr(AppStrings.ascending) : context.tr(AppStrings.descending)}';
                                  return Text(
                                    subtitleText,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 11.5.sp,
                                      fontWeight: FontWeight.w500,
                                      color: subtitle,
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 14.h),
                    Expanded(
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: surface,
                          borderRadius: BorderRadius.circular(16.r),
                          border: Border.all(color: hairline),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16.r),
                          child: ListView.separated(
                            padding: EdgeInsets.symmetric(vertical: 4.h),
                            itemCount: widget.options.length,
                            separatorBuilder: (_, __) => Divider(
                              height: 1,
                              thickness: 1,
                              indent: 52.w,
                              color: hairline,
                            ),
                            itemBuilder: (context, index) {
                              final option = widget.options[index];
                              final selected = option.key == _key;
                              return _SortOptionTile(
                                label: _localizedOptionLabel(context, option),
                                icon: _iconFor(option.key),
                                selected: selected,
                                enabled: !_applying,
                                primary: primary,
                                title: title,
                                subtitle: subtitle,
                                onTap: () {
                                  if (_applying) return;
                                  setState(() {
                                    _key = option.key;
                                    _direction =
                                        option.defaultDirection ?? _direction;
                                  });
                                },
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 12.h),
                    Text(
                      context.tr(AppStrings.direction),
                      style: TextStyle(
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.4,
                        color: subtitle,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    _DirectionSegment(
                      direction: _direction,
                      enabled: !_applying,
                      primary: primary,
                      title: title,
                      subtitle: subtitle,
                      isDark: isDark,
                      onChanged: (d) => setState(() => _direction = d),
                    ),
                    SizedBox(height: 14.h),
                    SizedBox(
                      height: 40.h,
                      child: AnimatedOpacity(
                        duration: const Duration(milliseconds: 180),
                        opacity: _key == null || _key!.isEmpty ? 0.45 : 1,
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: _applying || _key == null || _key!.isEmpty
                                ? null
                                : _apply,
                            borderRadius: BorderRadius.circular(12.r),
                            child: Ink(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12.r),
                                gradient: LinearGradient(
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                  colors: [
                                    primary,
                                    Color.lerp(primary, Colors.white, 0.12)!,
                                  ],
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: primary.withOpacity(0.28),
                                    blurRadius: 12,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: Center(
                                child: AnimatedSwitcher(
                                  duration: const Duration(milliseconds: 200),
                                  child: _applying
                                      ? Row(
                                          key: const ValueKey('loading'),
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            SizedBox(
                                              width: 15.sp,
                                              height: 15.sp,
                                              child:
                                                  const CircularProgressIndicator(
                                                strokeWidth: 2,
                                                color: Colors.white,
                                              ),
                                            ),
                                            SizedBox(width: 10.w),
                                            Text(
                                              context.tr(AppStrings.sortingPatients),
                                              style: TextStyle(
                                                fontSize: 13.5.sp,
                                                fontWeight: FontWeight.w700,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ],
                                        )
                                      : Text(
                                          key: const ValueKey('idle'),
                                          context.tr(AppStrings.applySort),
                                          style: TextStyle(
                                            fontSize: 13.5.sp,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.white,
                                          ),
                                        ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _SortOptionTile extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool selected;
  final bool enabled;
  final Color primary;
  final Color title;
  final Color subtitle;
  final VoidCallback onTap;

  const _SortOptionTile({
    required this.label,
    required this.icon,
    required this.selected,
    required this.enabled,
    required this.primary,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: selected ? primary.withOpacity(0.12) : Colors.transparent,
      child: InkWell(
        onTap: enabled ? onTap : null,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 11.h),
          child: Row(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: 32.w,
                height: 32.w,
                decoration: BoxDecoration(
                  color: selected
                      ? primary.withOpacity(0.22)
                      : subtitle.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(9.r),
                ),
                child: Icon(
                  icon,
                  size: 16.sp,
                  color: selected ? primary : subtitle,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Text(
                  label,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                    color: title,
                  ),
                ),
              ),
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: 20.w,
                height: 20.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: selected ? primary : Colors.transparent,
                  border: Border.all(
                    color: selected ? primary : subtitle.withOpacity(0.35),
                    width: 1.6,
                  ),
                ),
                child: selected
                    ? Icon(Icons.check_rounded, size: 13.sp, color: Colors.white)
                    : null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DirectionSegment extends StatelessWidget {
  final String direction;
  final bool enabled;
  final Color primary;
  final Color title;
  final Color subtitle;
  final bool isDark;
  final ValueChanged<String> onChanged;

  const _DirectionSegment({
    required this.direction,
    required this.enabled,
    required this.primary,
    required this.title,
    required this.subtitle,
    required this.isDark,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.h,
      padding: EdgeInsets.all(3.w),
      decoration: BoxDecoration(
        color: isDark
            ? Colors.white.withOpacity(0.05)
            : Colors.black.withOpacity(0.04),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: isDark
              ? Colors.white.withOpacity(0.08)
              : Colors.black.withOpacity(0.06),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: _SegmentChip(
              label: context.tr(AppStrings.ascending),
              icon: Icons.arrow_upward_rounded,
              selected: direction == 'asc',
              enabled: enabled,
              primary: primary,
              title: title,
              onTap: () => onChanged('asc'),
            ),
          ),
          Expanded(
            child: _SegmentChip(
              label: context.tr(AppStrings.descending),
              icon: Icons.arrow_downward_rounded,
              selected: direction == 'desc',
              enabled: enabled,
              primary: primary,
              title: title,
              onTap: () => onChanged('desc'),
            ),
          ),
        ],
      ),
    );
  }
}

class _SegmentChip extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool selected;
  final bool enabled;
  final Color primary;
  final Color title;
  final VoidCallback onTap;

  const _SegmentChip({
    required this.label,
    required this.icon,
    required this.selected,
    required this.enabled,
    required this.primary,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeOut,
      decoration: BoxDecoration(
        color: selected ? primary : Colors.transparent,
        borderRadius: BorderRadius.circular(9.r),
        boxShadow: selected
            ? [
                BoxShadow(
                  color: primary.withOpacity(0.28),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ]
            : null,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: enabled ? onTap : null,
          borderRadius: BorderRadius.circular(9.r),
          child: Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  icon,
                  size: 14.sp,
                  color: selected ? Colors.white : title.withOpacity(0.7),
                ),
                SizedBox(width: 6.w),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 12.5.sp,
                    fontWeight: FontWeight.w700,
                    color: selected ? Colors.white : title.withOpacity(0.8),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
