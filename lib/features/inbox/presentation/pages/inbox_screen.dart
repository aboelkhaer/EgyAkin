import 'package:egy_akin/features/home/presentation/widgets/dashboard/home_dashboard_shared.dart';
import 'package:egy_akin/features/inbox/data/models/inbox_fake_data.dart';

import '../../../../exports.dart';

class InboxScreen extends StatefulWidget {
  final DoctorModel currentDoctorModel;
  final HomeModelResponse homeDataModel;

  const InboxScreen({
    super.key,
    required this.currentDoctorModel,
    required this.homeDataModel,
  });

  @override
  State<InboxScreen> createState() => _InboxScreenState();
}

class _InboxScreenState extends State<InboxScreen> {
  InboxFilter _filter = InboxFilter.all;
  final TextEditingController _searchController = TextEditingController();
  String _query = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<InboxThreadFake> get _filtered {
    final base = InboxFakeData.byFilter(_filter);
    final q = _query.trim().toLowerCase();
    if (q.isEmpty) return base;
    return base
        .where(
          (t) =>
              t.title.toLowerCase().contains(q) ||
              t.subtitle.toLowerCase().contains(q) ||
              t.preview.toLowerCase().contains(q),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        final isDark = themeState is ThemeLoaded && themeState.isDarkMode;
        final primary = HomeDashboardColors.primary(isDark);
        final scaffold = HomeDashboardColors.scaffold(isDark);
        final threads = _filtered;
        final priority = threads.where((t) => t.isPriority).toList();
        final earlier = threads.where((t) => !t.isPriority).toList();

        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness:
                isDark ? Brightness.light : Brightness.dark,
            statusBarBrightness: isDark ? Brightness.dark : Brightness.light,
            systemStatusBarContrastEnforced: false,
          ),
          child: Scaffold(
            backgroundColor: scaffold,
            body: Column(
              children: [
                // Soft purple glow header (title + search + filters)
                Container(
                  width: double.infinity,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: isDark
                          ? [
                              const Color(0xFF7C3AED).withOpacity(0.40),
                              const Color(0xFF6D28D9).withOpacity(0.18),
                              const Color(0xFF6D28D9).withOpacity(0.0),
                            ]
                          : [
                              const Color(0xFFA78BFA).withOpacity(0.36),
                              const Color(0xFFC4B5FD).withOpacity(0.16),
                              const Color(0xFFC4B5FD).withOpacity(0.0),
                            ],
                      stops: const [0.0, 0.45, 1.0],
                    ),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(28.r),
                      bottomRight: Radius.circular(28.r),
                    ),
                  ),
                  child: SafeArea(
                    bottom: false,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 0),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  context.tr(AppStrings.inbox),
                                  style: TextStyle(
                                    fontSize: 22.sp,
                                    fontWeight: FontWeight.w800,
                                    color: HomeDashboardColors.title(isDark),
                                  ),
                                ),
                              ),
                              Material(
                                color: primary,
                                shape: const CircleBorder(),
                                elevation: 2,
                                shadowColor: primary.withOpacity(0.45),
                                child: InkWell(
                                  customBorder: const CircleBorder(),
                                  onTap: () {
                                    customSnackBar(
                                      message: context.tr(
                                        AppStrings.composeComingSoon,
                                      ),
                                      context: context,
                                    );
                                  },
                                  child: SizedBox(
                                    width: 40.r,
                                    height: 40.r,
                                    child: Icon(
                                      Icons.edit_rounded,
                                      color: Colors.white,
                                      size: 18.sp,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 12.h),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          child: _SearchField(
                            isDark: isDark,
                            controller: _searchController,
                            onChanged: (value) =>
                                setState(() => _query = value),
                          ),
                        ),
                        SizedBox(height: 12.h),
                        SizedBox(
                          height: 34.h,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            padding: EdgeInsets.symmetric(horizontal: 16.w),
                            children: [
                              _FilterChip(
                                label: context.tr(AppStrings.all),
                                count: InboxFakeData.countFor(
                                    InboxFilter.all),
                                selected: _filter == InboxFilter.all,
                                isDark: isDark,
                                primary: primary,
                                onTap: () => setState(
                                    () => _filter = InboxFilter.all),
                              ),
                              SizedBox(width: 8.w),
                              _FilterChip(
                                label: context.tr(AppStrings.doctors),
                                count: InboxFakeData.countFor(
                                    InboxFilter.doctors),
                                selected: _filter == InboxFilter.doctors,
                                isDark: isDark,
                                primary: primary,
                                onTap: () => setState(
                                    () => _filter = InboxFilter.doctors),
                              ),
                              SizedBox(width: 8.w),
                              _FilterChip(
                                label: context.tr(AppStrings.patients),
                                count: InboxFakeData.countFor(
                                    InboxFilter.patients),
                                selected: _filter == InboxFilter.patients,
                                isDark: isDark,
                                primary: primary,
                                onTap: () => setState(
                                    () => _filter = InboxFilter.patients),
                              ),
                              SizedBox(width: 8.w),
                              _FilterChip(
                                label: context.tr(AppStrings.consults),
                                count: InboxFakeData.countFor(
                                    InboxFilter.consults),
                                selected: _filter == InboxFilter.consults,
                                isDark: isDark,
                                primary: primary,
                                onTap: () => setState(
                                    () => _filter = InboxFilter.consults),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 14.h),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: threads.isEmpty
                      ? Center(
                          child: Text(
                            context.tr(AppStrings.noMessages),
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: HomeDashboardColors.subtitle(isDark),
                            ),
                          ),
                        )
                      : ListView(
                          padding:
                              EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 100.h),
                          children: [
                            if (priority.isNotEmpty) ...[
                              _SectionLabel(
                                label: context.tr(AppStrings.priorityUpper),
                                count: priority.length,
                                isDark: isDark,
                              ),
                              SizedBox(height: 8.h),
                              ...priority.map(
                                (t) => Padding(
                                  padding: EdgeInsets.only(bottom: 8.h),
                                  child: _ThreadCard(
                                    thread: t,
                                    isDark: isDark,
                                    primary: primary,
                                  ),
                                ),
                              ),
                              SizedBox(height: 8.h),
                            ],
                            if (earlier.isNotEmpty) ...[
                              _SectionLabel(
                                label: context.tr(AppStrings.earlierUpper),
                                count: earlier.length,
                                isDark: isDark,
                              ),
                              SizedBox(height: 8.h),
                              _GroupedThreadsCard(
                                threads: earlier,
                                isDark: isDark,
                                primary: primary,
                              ),
                            ],
                          ],
                        ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _SearchField extends StatelessWidget {
  final bool isDark;
  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  const _SearchField({
    required this.isDark,
    required this.controller,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 42.h,
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1C1C1E) : Colors.white,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(
          color: isDark
              ? HomeDashboardColors.border(true).withOpacity(0.7)
              : const Color(0xFFE5E7EB),
        ),
        boxShadow: isDark
            ? null
            : [
                BoxShadow(
                  color: Colors.black.withOpacity(0.03),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
      ),
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      child: Row(
        children: [
          Icon(
            Icons.search_rounded,
            size: 18.sp,
            color: HomeDashboardColors.subtitle(isDark),
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: TextField(
              controller: controller,
              onChanged: onChanged,
              style: TextStyle(
                fontSize: 12.sp,
                color: HomeDashboardColors.title(isDark),
              ),
              cursorColor: HomeDashboardColors.primary(isDark),
              decoration: InputDecoration(
                isDense: true,
                filled: false,
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                focusedErrorBorder: InputBorder.none,
                contentPadding: EdgeInsets.zero,
                hintText: context.tr(AppStrings.searchMessages),
                hintStyle: TextStyle(
                  fontSize: 12.sp,
                  color: HomeDashboardColors.subtitle(isDark),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final int count;
  final bool selected;
  final bool isDark;
  final Color primary;
  final VoidCallback onTap;

  const _FilterChip({
    required this.label,
    required this.count,
    required this.selected,
    required this.isDark,
    required this.primary,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: selected
          ? primary
          : (isDark ? const Color(0xFF2A2A2E) : const Color(0xFFF3F4F6)),
      borderRadius: BorderRadius.circular(20.r),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20.r),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 7.h),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w700,
                  color: selected
                      ? Colors.white
                      : HomeDashboardColors.title(isDark),
                ),
              ),
              if (count > 0) ...[
                SizedBox(width: 6.w),
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
                  decoration: BoxDecoration(
                    color: selected
                        ? Colors.white.withOpacity(0.22)
                        : primary.withOpacity(isDark ? 0.28 : 0.14),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Text(
                    '$count',
                    style: TextStyle(
                      fontSize: 9.sp,
                      fontWeight: FontWeight.w700,
                      color: selected ? Colors.white : primary,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  final String label;
  final int count;
  final bool isDark;

  const _SectionLabel({
    required this.label,
    required this.count,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    final line = HomeDashboardColors.border(isDark).withOpacity(0.7);
    return Row(
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 10.sp,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.6,
            color: HomeDashboardColors.subtitle(isDark),
          ),
        ),
        SizedBox(width: 8.w),
        Expanded(child: Divider(color: line, thickness: 1, height: 1)),
        SizedBox(width: 8.w),
        Text(
          '$count',
          style: TextStyle(
            fontSize: 10.sp,
            fontWeight: FontWeight.w600,
            color: HomeDashboardColors.subtitle(isDark),
          ),
        ),
      ],
    );
  }
}

class _ThreadCard extends StatelessWidget {
  final InboxThreadFake thread;
  final bool isDark;
  final Color primary;
  final bool grouped;

  const _ThreadCard({
    required this.thread,
    required this.isDark,
    required this.primary,
    this.grouped = false,
  });

  Color get _avatarBg {
    switch (thread.kind) {
      case InboxThreadKind.caseNote:
        return const Color(0xFFF59E0B).withOpacity(0.16);
      case InboxThreadKind.support:
        return const Color(0xFF3B82F6).withOpacity(0.16);
      case InboxThreadKind.consult:
        return primary.withOpacity(0.14);
      case InboxThreadKind.patient:
        return const Color(0xFF22C55E).withOpacity(0.14);
      case InboxThreadKind.admin:
        return const Color(0xFFEF4444).withOpacity(0.14);
      case InboxThreadKind.doctor:
        return isDark ? const Color(0xFF2A2A2E) : const Color(0xFFF3F4F6);
    }
  }

  Color get _avatarFg {
    switch (thread.kind) {
      case InboxThreadKind.caseNote:
        return const Color(0xFFF59E0B);
      case InboxThreadKind.support:
        return const Color(0xFF3B82F6);
      case InboxThreadKind.consult:
        return primary;
      case InboxThreadKind.patient:
        return const Color(0xFF22C55E);
      case InboxThreadKind.admin:
        return const Color(0xFFEF4444);
      case InboxThreadKind.doctor:
        return HomeDashboardColors.subtitle(isDark);
    }
  }

  IconData? get _avatarIcon {
    switch (thread.kind) {
      case InboxThreadKind.caseNote:
        return Icons.post_add_rounded;
      case InboxThreadKind.support:
        return Icons.support_agent_rounded;
      case InboxThreadKind.admin:
        return Icons.campaign_rounded;
      case InboxThreadKind.consult:
        return Icons.medical_services_outlined;
      default:
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final content = Padding(
      padding: EdgeInsets.symmetric(
        horizontal: grouped ? 12.w : 12.w,
        vertical: grouped ? 11.h : 12.h,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              CircleAvatar(
                radius: 20.r,
                backgroundColor: _avatarBg,
                child: _avatarIcon != null
                    ? Icon(_avatarIcon, color: _avatarFg, size: 18.sp)
                    : Text(
                        thread.initials,
                        style: TextStyle(
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w700,
                          color: _avatarFg,
                        ),
                      ),
              ),
              if (thread.isOnline)
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Container(
                    width: 10.r,
                    height: 10.r,
                    decoration: BoxDecoration(
                      color: HomeDashboardColors.online,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: HomeDashboardColors.cardBg(isDark),
                        width: 1.5,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Flexible(
                            child: Text(
                              thread.title,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w700,
                                color: HomeDashboardColors.title(isDark),
                              ),
                            ),
                          ),
                          if (thread.isVerified) ...[
                            SizedBox(width: 4.w),
                            Icon(
                              Icons.verified_rounded,
                              size: 12.sp,
                              color: HomeDashboardColors.success,
                            ),
                          ],
                          if (thread.isUrgent) ...[
                            SizedBox(width: 6.w),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 5.w,
                                vertical: 1.h,
                              ),
                              decoration: BoxDecoration(
                                color:
                                    const Color(0xFFF59E0B).withOpacity(0.18),
                                borderRadius: BorderRadius.circular(6.r),
                              ),
                              child: Text(
                                context.tr(AppStrings.urgentUpper),
                                style: TextStyle(
                                  fontSize: 8.sp,
                                  fontWeight: FontWeight.w800,
                                  color: const Color(0xFFD97706),
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                    SizedBox(width: 6.w),
                    if (thread.isAdminBadge) ...[
                      Icon(
                        Icons.verified_user_rounded,
                        size: 13.sp,
                        color: const Color(0xFFEF4444),
                      ),
                      SizedBox(width: 4.w),
                    ],
                    Text(
                      thread.timeLabel,
                      style: TextStyle(
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w500,
                        color: HomeDashboardColors.subtitle(isDark),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 2.h),
                Text(
                  thread.subtitle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w500,
                    color: HomeDashboardColors.subtitle(isDark),
                  ),
                ),
                SizedBox(height: 3.h),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        thread.preview,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 11.sp,
                          fontWeight: thread.unreadCount > 0
                              ? FontWeight.w600
                              : FontWeight.w500,
                          color: thread.unreadCount > 0
                              ? HomeDashboardColors.title(isDark)
                              : HomeDashboardColors.subtitle(isDark),
                        ),
                      ),
                    ),
                    if (thread.unreadCount > 0) ...[
                      SizedBox(width: 8.w),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 6.w,
                          vertical: 2.h,
                        ),
                        decoration: BoxDecoration(
                          color: primary,
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: Text(
                          '${thread.unreadCount}',
                          style: TextStyle(
                            fontSize: 9.sp,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ] else if (thread.showReadReceipt) ...[
                      SizedBox(width: 8.w),
                      Icon(
                        Icons.done_all_rounded,
                        size: 14.sp,
                        color: HomeDashboardColors.subtitle(isDark),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          customSnackBar(
            message: 'Opening ${thread.title}',
            context: context,
          );
        },
        borderRadius: BorderRadius.circular(grouped ? 0 : 16.r),
        child: grouped
            ? content
            : Ink(
                decoration: HomeDashboardDecor.card(isDark),
                child: content,
              ),
      ),
    );
  }
}

class _GroupedThreadsCard extends StatelessWidget {
  final List<InboxThreadFake> threads;
  final bool isDark;
  final Color primary;

  const _GroupedThreadsCard({
    required this.threads,
    required this.isDark,
    required this.primary,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: HomeDashboardDecor.card(isDark),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          for (int i = 0; i < threads.length; i++) ...[
            _ThreadCard(
              thread: threads[i],
              isDark: isDark,
              primary: primary,
              grouped: true,
            ),
            if (i != threads.length - 1)
              Divider(
                height: 1,
                indent: 54.w,
                color: HomeDashboardColors.border(isDark).withOpacity(0.55),
              ),
          ],
        ],
      ),
    );
  }
}
