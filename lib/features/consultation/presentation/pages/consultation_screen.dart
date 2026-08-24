import 'package:egy_akin/features/home/presentation/widgets/dashboard/home_dashboard_shared.dart';

import '../../../../exports.dart';

class ConsultationScreen extends StatefulWidget {
  final HomeModelResponse homeDataModel;
  final DoctorModel currentDoctorModel;
  final int initialTab;

  const ConsultationScreen({
    super.key,
    required this.homeDataModel,
    required this.currentDoctorModel,
    required this.initialTab,
  });

  @override
  State<ConsultationScreen> createState() => _ConsultationScreenState();
}

class _ConsultationScreenState extends State<ConsultationScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 2,
      vsync: this,
      initialIndex: widget.initialTab.clamp(0, 1),
    )..addListener(() {
        if (mounted) setState(() {});
      });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        final isDark = themeState is ThemeLoaded && themeState.isDarkMode;
        final scaffold = HomeDashboardColors.scaffold(isDark);
        final primary = HomeDashboardColors.primary(isDark);
        final muted = HomeDashboardColors.subtitle(isDark);

        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: isDark
              ? SystemUiOverlayStyle.light
                  .copyWith(statusBarColor: Colors.transparent)
              : SystemUiOverlayStyle.dark
                  .copyWith(statusBarColor: Colors.transparent),
          child: Scaffold(
            backgroundColor: scaffold,
            body: Column(
              children: [
                _ConsultationHeader(
                  isDark: isDark,
                  scaffold: scaffold,
                  primary: primary,
                  muted: muted,
                  selectedIndex: _tabController.index,
                  myLabel: context.tr(AppStrings.myConsultations),
                  receivedLabel: context.tr(AppStrings.received),
                  onBack: () => Navigator.of(context).maybePop(),
                  onTabChanged: (index) => _tabController.animateTo(index),
                ),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      MyConsultationsTab(
                        currentDoctorModel: widget.currentDoctorModel,
                        homeDataModel: widget.homeDataModel,
                      ),
                      ReceivedTab(
                        currentDoctorModel: widget.currentDoctorModel,
                        homeDataModel: widget.homeDataModel,
                      ),
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

class _ConsultationHeader extends StatelessWidget {
  final bool isDark;
  final Color scaffold;
  final Color primary;
  final Color muted;
  final int selectedIndex;
  final String myLabel;
  final String receivedLabel;
  final VoidCallback onBack;
  final ValueChanged<int> onTabChanged;

  const _ConsultationHeader({
    required this.isDark,
    required this.scaffold,
    required this.primary,
    required this.muted,
    required this.selectedIndex,
    required this.myLabel,
    required this.receivedLabel,
    required this.onBack,
    required this.onTabChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            HomeDashboardColors.header(isDark),
            scaffold,
          ],
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: EdgeInsets.fromLTRB(14.w, 4.h, 14.w, 12.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Material(
                    color: isDark ? const Color(0xFF2A2733) : Colors.white,
                    shape: const CircleBorder(),
                    child: InkWell(
                      customBorder: const CircleBorder(),
                      onTap: onBack,
                      child: Container(
                        width: 36.w,
                        height: 36.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: isDark
                                ? const Color(0xFF3A3645)
                                : HomeDashboardColors.border(isDark),
                          ),
                        ),
                        child: Icon(
                          Icons.arrow_back_ios_new_rounded,
                          size: 16.sp,
                          color: HomeDashboardColors.title(isDark),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: Text(
                      context.tr(AppStrings.consultation),
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w800,
                        color: HomeDashboardColors.title(isDark),
                        letterSpacing: -0.2,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8.h),
              Text(
                context.tr(AppStrings.reviewConsultationsSubtitle),
                style: TextStyle(
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w500,
                  color: muted,
                ),
              ),
              SizedBox(height: 12.h),
              Container(
                padding: EdgeInsets.all(4.w),
                decoration: BoxDecoration(
                  color: HomeDashboardColors.cardBg(isDark),
                  borderRadius: BorderRadius.circular(14.r),
                  border: Border.all(
                    color: HomeDashboardColors.border(isDark),
                  ),
                  boxShadow: isDark
                      ? null
                      : [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.04),
                            blurRadius: 10,
                            offset: const Offset(0, 2),
                          ),
                        ],
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: _TabChip(
                        isDark: isDark,
                        primary: primary,
                        label: myLabel,
                        icon: Icons.outbox_outlined,
                        selected: selectedIndex == 0,
                        onTap: () => onTabChanged(0),
                      ),
                    ),
                    SizedBox(width: 6.w),
                    Expanded(
                      child: _TabChip(
                        isDark: isDark,
                        primary: primary,
                        label: receivedLabel,
                        icon: Icons.inbox_outlined,
                        selected: selectedIndex == 1,
                        onTap: () => onTabChanged(1),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TabChip extends StatelessWidget {
  final bool isDark;
  final Color primary;
  final String label;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  const _TabChip({
    required this.isDark,
    required this.primary,
    required this.label,
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(11.r),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 8.w),
          decoration: BoxDecoration(
            color: selected
                ? primary.withOpacity(isDark ? 0.22 : 0.12)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(11.r),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 15.sp,
                color: selected
                    ? primary
                    : HomeDashboardColors.subtitle(isDark),
              ),
              SizedBox(width: 5.w),
              Flexible(
                child: Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 11.5.sp,
                    fontWeight: FontWeight.w700,
                    color: selected
                        ? (isDark ? Colors.white : primary)
                        : HomeDashboardColors.subtitle(isDark),
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
