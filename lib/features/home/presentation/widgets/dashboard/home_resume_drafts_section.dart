import '../../../../../exports.dart';
import 'home_dashboard_shared.dart';

class HomeResumeDraftsSection extends StatelessWidget {
  final bool isDark;
  final List<PatientHomeDataModel> drafts;
  final int draftCount;
  final ValueChanged<PatientHomeDataModel>? onResume;
  final VoidCallback? onViewAll;

  const HomeResumeDraftsSection({
    super.key,
    required this.isDark,
    required this.drafts,
    this.draftCount = 0,
    this.onResume,
    this.onViewAll,
  });

  @override
  Widget build(BuildContext context) {
    if (drafts.isEmpty && draftCount <= 0) {
      return const SizedBox.shrink();
    }

    final countLabel = draftCount > 0 ? draftCount : drafts.length;
    final primaryDraft = drafts.isNotEmpty ? drafts.first : null;
    final secondary = drafts.length > 1 ? drafts.sublist(1) : const <PatientHomeDataModel>[];

    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: HomeDashboardDecor.card(
        isDark,
        color: HomeDashboardColors.primary(isDark)
            .withOpacity(isDark ? 0.12 : 0.06),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          HomeSectionHeader(
            title: context.tr(AppStrings.resumeDrafts),
            isDark: isDark,
            leadingIcon: Icons.assignment_outlined,
            badgeText:
                '$countLabel ${context.tr(AppStrings.inProgress)}',
            actionLabel: context.tr(AppStrings.viewAll),
            onAction: onViewAll,
          ),
          if (primaryDraft != null) ...[
            SizedBox(height: 10.h),
            _PrimaryDraftCard(
              isDark: isDark,
              draft: primaryDraft,
              onResume: onResume,
            ),
            ...secondary.map(
              (draft) => Padding(
                padding: EdgeInsets.only(top: 8.h),
                child: _SecondaryDraftRow(
                  isDark: isDark,
                  draft: draft,
                  onResume: onResume,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _PrimaryDraftCard extends StatelessWidget {
  final bool isDark;
  final PatientHomeDataModel draft;
  final ValueChanged<PatientHomeDataModel>? onResume;

  const _PrimaryDraftCard({
    required this.isDark,
    required this.draft,
    this.onResume,
  });

  @override
  Widget build(BuildContext context) {
    final completed = draft.sectionsCompleted ?? 0;
    final total = (draft.sectionsTotal ?? 0) <= 0 ? 1 : draft.sectionsTotal!;
    final progress = (completed / total).clamp(0.0, 1.0);
    final primary = HomeDashboardColors.primary(isDark);
    final name = _patientName(draft);
    final nextStep = draft.nextSection?.name?.trim().isNotEmpty == true
        ? draft.nextSection!.name!.trim()
        : context.tr(AppStrings.continueText);
    final lastSaved = _relativeLabel(context, draft.sectionsLastUpdatedAt) ??
        _relativeLabel(context, draft.updatedAt) ??
        '$completed ${context.tr(AppStrings.ofSections)} $total ${context.tr(AppStrings.sectionsLabel)}';

    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: HomeDashboardDecor.card(isDark),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              SizedBox(
                width: 44.r,
                height: 44.r,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    CircularProgressIndicator(
                      value: progress,
                      strokeWidth: 4,
                      backgroundColor: primary.withOpacity(0.15),
                      valueColor: AlwaysStoppedAnimation(primary),
                    ),
                    Text(
                      '$completed/$total',
                      style: TextStyle(
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w800,
                        color: HomeDashboardColors.title(isDark),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w700,
                        color: HomeDashboardColors.title(isDark),
                      ),
                    ),
                    SizedBox(height: 5.h),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.w,
                        vertical: 3.h,
                      ),
                      decoration: BoxDecoration(
                        color: primary.withOpacity(isDark ? 0.2 : 0.1),
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.checklist_rounded,
                              size: 12.sp, color: primary),
                          SizedBox(width: 3.w),
                          Flexible(
                            child: Text(
                              '${context.tr(AppStrings.nextPrefix)} $nextStep',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 10.sp,
                                fontWeight: FontWeight.w600,
                                color: primary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      lastSaved,
                      style: TextStyle(
                        fontSize: 10.sp,
                        color: HomeDashboardColors.subtitle(isDark),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 10.h),
          SizedBox(
            height: 34.h,
            child: ElevatedButton(
              onPressed: onResume == null ? null : () => onResume!(draft),
              style: ElevatedButton.styleFrom(
                backgroundColor: primary,
                foregroundColor: Colors.white,
                elevation: 0,
                padding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.r),
                ),
              ),
              child: Text(
                context.tr(AppStrings.resumeThisCase),
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SecondaryDraftRow extends StatelessWidget {
  final bool isDark;
  final PatientHomeDataModel draft;
  final ValueChanged<PatientHomeDataModel>? onResume;

  const _SecondaryDraftRow({
    required this.isDark,
    required this.draft,
    this.onResume,
  });

  @override
  Widget build(BuildContext context) {
    final primary = HomeDashboardColors.primary(isDark);
    final completed = draft.sectionsCompleted ?? 0;
    final total = draft.sectionsTotal ?? 0;
    final name = _patientName(draft);
    final nextStep = draft.nextSection?.name?.trim().isNotEmpty == true
        ? draft.nextSection!.name!.trim()
        : '$completed ${context.tr(AppStrings.ofSections)} $total ${context.tr(AppStrings.sectionsLabel)}';

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onResume == null ? null : () => onResume!(draft),
        borderRadius: BorderRadius.circular(16.r),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
          decoration: HomeDashboardDecor.card(isDark),
          child: Row(
            children: [
              HomeInitialsAvatar(
                initials: _initialsFromName(name),
                radius: 15,
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w700,
                        color: HomeDashboardColors.title(isDark),
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      nextStep,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 10.sp,
                        color: HomeDashboardColors.subtitle(isDark),
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.chevron_right_rounded,
                size: 18.sp,
                color: primary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

String _patientName(PatientHomeDataModel patient) {
  final name = patient.name?.trim();
  if (name != null && name.isNotEmpty) return name;
  return 'Patient #${patient.id ?? ''}';
}

String _initialsFromName(String name) {
  final parts =
      name.split(RegExp(r'\s+')).where((p) => p.isNotEmpty).toList();
  if (parts.isEmpty) return 'P';
  if (parts.length == 1) {
    return parts.first.substring(0, 1).toUpperCase();
  }
  return ('${parts.first[0]}${parts.last[0]}').toUpperCase();
}

String? _relativeLabel(BuildContext context, String? raw) {
  if (raw == null || raw.isEmpty) return null;
  final dt = DateTime.tryParse(raw)?.toLocal();
  if (dt == null) return null;
  final diff = DateTime.now().difference(dt);
  if (diff.inMinutes < 1) return context.tr(AppStrings.lastSavedJustNow);
  if (diff.inMinutes < 60) return 'Last saved ${diff.inMinutes}m ago';
  if (diff.inHours < 24) return 'Last saved ${diff.inHours}h ago';
  if (diff.inDays < 7) return 'Last saved ${diff.inDays}d ago';
  return 'Last saved ${dt.day}/${dt.month}/${dt.year}';
}
