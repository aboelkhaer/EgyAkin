import 'package:egy_akin/exports.dart';
import 'package:egy_akin/features/gfr_calculator/data/models/gfr_calculator_model_response.dart';
import 'package:egy_akin/features/gfr_calculator/presentation/cubit/gfr_calculator_cubit.dart';
import 'package:egy_akin/features/gfr_calculator/presentation/utils/gfr_equation_formulas.dart';
import 'package:egy_akin/features/gfr_calculator/presentation/utils/gfr_history_result_codec.dart';
import 'package:egy_akin/features/gfr_calculator/presentation/widgets/gfr_calculator_theme.dart';
import 'package:egy_akin/features/gfr_calculator/presentation/widgets/gfr_result_dialog.dart';
import 'package:intl/intl.dart';

class GfrHistorySection extends StatefulWidget {
  final List<GFRCalculatorHistoryModelResponse> history;

  const GfrHistorySection({super.key, required this.history});

  @override
  State<GfrHistorySection> createState() => _GfrHistorySectionState();
}

class _GfrHistorySectionState extends State<GfrHistorySection> {
  static const Duration _animDuration = Duration(milliseconds: 300);

  GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  late List<GFRCalculatorHistoryModelResponse> _entries;
  bool _isClearing = false;
  bool _isAnimatingRemoval = false;

  @override
  void initState() {
    super.initState();
    _entries = List<GFRCalculatorHistoryModelResponse>.from(widget.history);
  }

  @override
  void didUpdateWidget(GfrHistorySection oldWidget) {
    super.didUpdateWidget(oldWidget);
    _syncNewEntries(oldWidget.history);
  }

  void _syncNewEntries(List<GFRCalculatorHistoryModelResponse> oldHistory) {
    if (_isAnimatingRemoval || _isClearing) return;
    if (widget.history.length <= _entries.length) return;

    if (oldHistory.isEmpty && widget.history.isNotEmpty) {
      setState(() {
        _entries = List<GFRCalculatorHistoryModelResponse>.from(widget.history);
        _listKey = GlobalKey<AnimatedListState>();
      });
      return;
    }

    final addedCount = widget.history.length - _entries.length;
    final newEntries = widget.history.sublist(_entries.length);
    setState(() => _entries.addAll(newEntries));
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      for (var i = 0; i < addedCount; i++) {
        _listKey.currentState?.insertItem(0, duration: _animDuration);
      }
    });
  }

  int _listIndexForDataIndex(int dataIndex) => _entries.length - 1 - dataIndex;

  Future<void> _removeEntryAnimated(int dataIndex) async {
    if (dataIndex < 0 || dataIndex >= _entries.length) return;

    _isAnimatingRemoval = true;
    final listIndex = _listIndexForDataIndex(dataIndex);
    final removed = _entries.removeAt(dataIndex);

    _listKey.currentState?.removeItem(
      listIndex,
      (context, animation) => _buildAnimatedCard(
        context: context,
        entry: removed,
        dataIndex: dataIndex,
        animation: animation,
        showRemove: false,
      ),
      duration: _animDuration,
    );

    await Future<void>.delayed(_animDuration);
    if (!mounted) {
      _isAnimatingRemoval = false;
      return;
    }

    await GfrCalculatorCubit.get(context).removeHistoryEntry(dataIndex);
    if (mounted) _isAnimatingRemoval = false;
    if (mounted && _entries.isEmpty) {
      setState(() {});
    }
  }

  Future<void> _clearAllAnimated() async {
    if (_entries.isEmpty || _isClearing) return;

    setState(() => _isClearing = true);
    await Future<void>.delayed(_animDuration);
    if (!mounted) return;

    _entries.clear();
    await GfrCalculatorCubit.get(context).clearAllHistory();
    if (!mounted) return;

    setState(() => _isClearing = false);
  }

  ({String text, bool isToday}) _historyDateDisplay(
    BuildContext context,
    String? raw,
  ) {
    if (raw == null || raw.isEmpty) {
      return (text: '—', isToday: false);
    }
    try {
      final dt = DateTime.parse(raw);
      final now = DateTime.now();
      final isToday = dt.year == now.year &&
          dt.month == now.month &&
          dt.day == now.day;

      if (isToday) {
        return (text: DateFormat('HH:mm').format(dt), isToday: true);
      }
      return (
        text: DateFormat('dd MMM yyyy • HH:mm').format(dt),
        isToday: false,
      );
    } catch (_) {
      return (text: raw, isToday: false);
    }
  }

  String _equationDisplayName(BuildContext context, String? type) {
    if (type == null || type.isEmpty) return '—';
    if (type == 'CKD-EPI') return 'CKD-EPI (2021)';
    if (type == 'MDRD') return 'MDRD (2006)';
    if (type == 'NKF eGFR') return context.tr(AppStrings.nkfEgfrCalculator);
    return type;
  }

  Widget _historyTransition(Widget child, Animation<double> animation) {
    final curved = CurvedAnimation(
      parent: animation,
      curve: Curves.easeOutCubic,
      reverseCurve: Curves.easeInCubic,
    );

    return FadeTransition(
      opacity: curved,
      child: SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0, 0.06),
          end: Offset.zero,
        ).animate(curved),
        child: SizeTransition(
          sizeFactor: curved,
          axisAlignment: -1,
          child: child,
        ),
      ),
    );
  }

  Widget _buildAnimatedCard({
    required BuildContext context,
    required GFRCalculatorHistoryModelResponse entry,
    required int dataIndex,
    required Animation<double> animation,
    bool showRemove = true,
  }) {
    final theme = GfrCalculatorTheme.of(context);
    final dateDisplay = _historyDateDisplay(context, entry.date);

    return _historyTransition(
      _HistoryEntryCard(
        entry: entry,
        theme: theme,
        dateText: dateDisplay.text,
        isToday: dateDisplay.isToday,
        equationName: _equationDisplayName(context, entry.equationType),
        onRemove: showRemove ? () => _removeEntryAnimated(dataIndex) : null,
      ),
      animation,
    );
  }

  Widget _buildEmptyState(GfrCalculatorTheme theme) {
    return Container(
      key: const ValueKey('gfr_history_empty'),
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 28.h, horizontal: 16.w),
      decoration: BoxDecoration(
        color: theme.surfaceBg,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: theme.border),
        boxShadow: theme.cardShadow,
      ),
      child: Column(
        children: [
          Icon(
            Icons.calculate_outlined,
            size: 32.sp,
            color: theme.subtitle,
          ),
          SizedBox(height: 10.h),
          Text(
            context.tr(AppStrings.gfrNoHistoryYet),
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12.sp,
              color: theme.subtitle,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cubit = GfrCalculatorCubit.get(context);

    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        final theme = GfrCalculatorTheme(
          themeState is ThemeLoaded && themeState.isDarkMode,
        );
        final hasEntries = _entries.isNotEmpty;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Icon(
                  Icons.history,
                  size: 18.sp,
                  color: AppColors.primary,
                ),
                SizedBox(width: 8.w),
                Text(
                  context.tr(AppStrings.temporaryHistory),
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 15.sp,
                    color: theme.title,
                  ),
                ),
                const Spacer(),
                AnimatedSwitcher(
                  duration: _animDuration,
                  switchInCurve: Curves.easeOutCubic,
                  switchOutCurve: Curves.easeIn,
                  child: hasEntries
                      ? Row(
                          key: ValueKey('gfr_history_actions_${_entries.length}'),
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 8.w,
                                vertical: 3.h,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.primary.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                              child: Text(
                                '${_entries.length}',
                                style: TextStyle(
                                  fontSize: 11.sp,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.primary,
                                ),
                              ),
                            ),
                            SizedBox(width: 8.w),
                            TextButton.icon(
                              onPressed: _isClearing
                                  ? null
                                  : () => cubit.confirmClearAllHistory(
                                        context,
                                        onConfirmed: _clearAllAnimated,
                                      ),
                              icon: Icon(
                                Icons.delete_sweep_outlined,
                                size: 16.sp,
                                color: Colors.red.shade600,
                              ),
                              label: Text(
                                context.tr(AppStrings.gfrClearAllHistory),
                                style: TextStyle(
                                  fontSize: 11.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.red.shade600,
                                ),
                              ),
                              style: TextButton.styleFrom(
                                padding:
                                    EdgeInsets.symmetric(horizontal: 6.w),
                                minimumSize: Size.zero,
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              ),
                            ),
                          ],
                        )
                      : const SizedBox.shrink(
                          key: ValueKey('gfr_history_actions_hidden'),
                        ),
                ),
              ],
            ),
            SizedBox(height: 12.h),
            AnimatedSwitcher(
              duration: _animDuration,
              switchInCurve: Curves.easeOutCubic,
              switchOutCurve: Curves.easeInCubic,
              transitionBuilder: (child, animation) => FadeTransition(
                opacity: animation,
                child: SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(0, 0.04),
                    end: Offset.zero,
                  ).animate(animation),
                  child: child,
                ),
              ),
              child: hasEntries
                  ? AnimatedOpacity(
                      key: const ValueKey('gfr_history_list'),
                      opacity: _isClearing ? 0 : 1,
                      duration: _animDuration,
                      curve: Curves.easeInCubic,
                      child: AnimatedList(
                        key: _listKey,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        reverse: true,
                        initialItemCount: _entries.length,
                        itemBuilder: (context, index, animation) {
                          final dataIndex = _listIndexForDataIndex(index);
                          final entry = _entries[dataIndex];
                          return _buildAnimatedCard(
                            context: context,
                            entry: entry,
                            dataIndex: dataIndex,
                            animation: animation,
                          );
                        },
                      ),
                    )
                  : _buildEmptyState(theme),
            ),
          ],
        );
      },
    );
  }
}

bool _hasBiomarkerValue(String? value) {
  if (value == null || value.isEmpty) return false;
  return value != '—';
}

class _HistoryEntryCard extends StatelessWidget {
  final GFRCalculatorHistoryModelResponse entry;
  final GfrCalculatorTheme theme;
  final String dateText;
  final bool isToday;
  final String equationName;
  final VoidCallback? onRemove;

  const _HistoryEntryCard({
    required this.entry,
    required this.theme,
    required this.dateText,
    required this.isToday,
    required this.equationName,
    this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    final resultText = entry.result ?? '—';
    final isNkfEntry =
        entry.equationType == GfrCalculatorCubit.equationNkfEgfr;
    var nkfLines = isNkfEntry ? parseNkfHistoryResult(resultText) : null;
    if (isNkfEntry && (nkfLines == null || nkfLines.isEmpty)) {
      final legacySingle = double.tryParse(resultText.trim());
      if (legacySingle != null) {
        nkfLines = [
          NkfEgfrResultLine(
            labelKey: AppStrings.ckdEpiCreatinine2021,
            egfr: legacySingle,
          ),
        ];
      }
    }
    final primaryEgfr = nkfLines != null && nkfLines.isNotEmpty
        ? nkfLines.first.egfr
        : double.tryParse(resultText.trim());

    return Container(
      margin: EdgeInsets.only(bottom: 10.h),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: theme.cardBg,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: theme.border),
        boxShadow: theme.cardShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    if (isToday) ...[
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 6.w,
                          vertical: 2.h,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withOpacity(0.12),
                          borderRadius: BorderRadius.circular(6.r),
                          border: Border.all(
                            color: AppColors.primary.withOpacity(0.35),
                          ),
                        ),
                        child: Text(
                          context.tr(AppStrings.today),
                          style: TextStyle(
                            fontSize: 9.sp,
                            fontWeight: FontWeight.w700,
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                      SizedBox(width: 6.w),
                    ],
                    Flexible(
                      child: Text(
                        dateText,
                        style: TextStyle(
                          fontSize: 10.sp,
                          fontWeight:
                              isToday ? FontWeight.w600 : FontWeight.normal,
                          color: isToday ? theme.title : theme.subtitle,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text(
                  equationName,
                  style: TextStyle(
                    fontSize: 9.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primary,
                  ),
                ),
              ),
              if (onRemove != null)
                IconButton(
                  onPressed: onRemove,
                  icon: Icon(
                    Icons.close,
                    size: 18.sp,
                    color: theme.subtitle,
                  ),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(
                    minWidth: 32,
                    minHeight: 32,
                  ),
                  tooltip: context.tr(AppStrings.delete),
                ),
            ],
          ),
          SizedBox(height: 10.h),
          _HistoryMetaChip(
            icon: Icons.person_outline,
            text:
                '${entry.gender ?? '—'} • ${context.tr(AppStrings.age)} ${entry.age ?? '—'}',
            theme: theme,
          ),
          SizedBox(height: 4.h),
          if (_hasBiomarkerValue(entry.creatinine)) ...[
            SizedBox(height: 4.h),
            _HistoryMetaChip(
              icon: Icons.science_outlined,
              text:
                  '${context.tr(AppStrings.creatinineMgDl)}: ${entry.creatinine}',
              theme: theme,
            ),
          ],
          if (_hasBiomarkerValue(entry.cystatin)) ...[
            SizedBox(height: 4.h),
            _HistoryMetaChip(
              icon: Icons.biotech_outlined,
              text:
                  '${context.tr(AppStrings.cystatinCMgL)}: ${entry.cystatin}',
              theme: theme,
            ),
          ],
          if (nkfLines != null && nkfLines.isNotEmpty) ...[
            SizedBox(height: 10.h),
            _HistoryNkfResultsBlock(
              lines: nkfLines,
              theme: theme,
            ),
          ] else ...[
            SizedBox(height: 10.h),
            Align(
              alignment: Alignment.centerRight,
              child: _HistoryResultColumn(
                resultText: resultText,
                primaryEgfr: primaryEgfr,
                theme: theme,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _HistoryNkfResultsBlock extends StatelessWidget {
  final List<NkfEgfrResultLine> lines;
  final GfrCalculatorTheme theme;

  const _HistoryNkfResultsBlock({
    required this.lines,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    final unit = context.tr(AppStrings.egfrUnitIndexed);

    return Column(
      children: [
        for (var i = 0; i < lines.length; i++) ...[
          if (i > 0) SizedBox(height: 6.h),
          _HistoryNkfResultRow(
            label: context.tr(lines[i].labelKey),
            egfr: lines[i].egfr,
            unit: unit,
            theme: theme,
          ),
        ],
      ],
    );
  }
}

class _HistoryNkfResultRow extends StatelessWidget {
  final String label;
  final double egfr;
  final String unit;
  final GfrCalculatorTheme theme;

  const _HistoryNkfResultRow({
    required this.label,
    required this.egfr,
    required this.unit,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    final stage = gfrCkdStageLabel(egfr);
    final stageColor = gfrCkdStageColor(egfr);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: theme.surfaceBg,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: theme.border),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 10.sp,
                fontWeight: FontWeight.w600,
                height: 1.3,
                color: theme.title,
              ),
            ),
          ),
          SizedBox(width: 8.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                egfr.toStringAsFixed(1),
                style: TextStyle(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w800,
                  color: AppColors.primary,
                ),
              ),
              Text(
                unit,
                style: TextStyle(
                  fontSize: 8.sp,
                  color: theme.subtitle,
                ),
              ),
              SizedBox(height: 2.h),
              Text(
                'CKD $stage',
                style: TextStyle(
                  fontSize: 9.sp,
                  fontWeight: FontWeight.w700,
                  color: stageColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _HistoryResultColumn extends StatelessWidget {
  final String resultText;
  final double? primaryEgfr;
  final GfrCalculatorTheme theme;

  const _HistoryResultColumn({
    required this.resultText,
    required this.primaryEgfr,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    final unit = context.tr(AppStrings.egfrUnitIndexed);
    final values = resultText.contains('/')
        ? resultText.split('/').map((s) => s.trim()).toList()
        : [resultText];

    if (values.length > 1) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          for (var i = 0; i < values.length; i++) ...[
            if (i > 0) SizedBox(height: 4.h),
            Text(
              values[i],
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w800,
                color: AppColors.primary,
              ),
            ),
          ],
          SizedBox(height: 2.h),
          Text(
            unit,
            style: TextStyle(
              fontSize: 9.sp,
              color: theme.subtitle,
            ),
          ),
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          resultText,
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.w800,
            color: AppColors.primary,
          ),
        ),
        if (primaryEgfr != null) ...[
          SizedBox(height: 2.h),
          Text(
            'CKD ${gfrCkdStageLabel(primaryEgfr!)}',
            style: TextStyle(
              fontSize: 10.sp,
              fontWeight: FontWeight.w600,
              color: gfrCkdStageColor(primaryEgfr!),
            ),
          ),
        ],
        SizedBox(height: 2.h),
        Text(
          unit,
          style: TextStyle(
            fontSize: 9.sp,
            color: theme.subtitle,
          ),
        ),
      ],
    );
  }
}

class _HistoryMetaChip extends StatelessWidget {
  final IconData icon;
  final String text;
  final GfrCalculatorTheme theme;

  const _HistoryMetaChip({
    required this.icon,
    required this.text,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          size: 12.sp,
          color: theme.subtitle,
        ),
        SizedBox(width: 4.w),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 11.sp,
              color: theme.title,
            ),
          ),
        ),
      ],
    );
  }
}
