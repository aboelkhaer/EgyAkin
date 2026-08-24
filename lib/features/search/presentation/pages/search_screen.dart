import 'package:egy_akin/app/shared/functions/permissions_helper.dart';
import 'package:egy_akin/features/home/presentation/widgets/dashboard/home_dashboard_shared.dart';
import 'package:egy_akin/features/home/presentation/widgets/patients/home_patient_widgets.dart';

import '../../../../exports.dart';

class SearchScreen extends StatefulWidget {
  final DoctorModel currentDoctorModel;
  final bool accountVerification;
  final String isSyndicateCardRequired;
  final int currentDoctorPoints;
  final String currentDoctorRole;
  final HomeModelResponse homeDataModel;
  final bool patientsOnly;

  const SearchScreen({
    super.key,
    required this.currentDoctorModel,
    required this.accountVerification,
    required this.isSyndicateCardRequired,
    required this.currentDoctorRole,
    required this.currentDoctorPoints,
    required this.homeDataModel,
    this.patientsOnly = false,
  });

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen>
    with TickerProviderStateMixin {
  SearchCubit? cubit;
  late final AnimationController _introController;
  late final AnimationController _pulseController;

  late final Animation<double> _headerFade;
  late final Animation<Offset> _headerSlide;
  late final Animation<double> _fieldFade;
  late final Animation<Offset> _fieldSlide;
  late final Animation<double> _filtersFade;
  late final Animation<Offset> _filtersSlide;
  late final Animation<double> _bodyFade;

  @override
  void initState() {
    super.initState();
    _introController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1600),
    )..repeat(reverse: true);

    _headerFade = CurvedAnimation(
      parent: _introController,
      curve: const Interval(0.0, 0.4, curve: Curves.easeOut),
    );
    _headerSlide = Tween<Offset>(
      begin: const Offset(0, -0.12),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _introController,
        curve: const Interval(0.0, 0.45, curve: Curves.easeOutCubic),
      ),
    );
    _fieldFade = CurvedAnimation(
      parent: _introController,
      curve: const Interval(0.15, 0.55, curve: Curves.easeOut),
    );
    _fieldSlide = Tween<Offset>(
      begin: const Offset(0, 0.1),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _introController,
        curve: const Interval(0.15, 0.58, curve: Curves.easeOutCubic),
      ),
    );
    _filtersFade = CurvedAnimation(
      parent: _introController,
      curve: const Interval(0.3, 0.7, curve: Curves.easeOut),
    );
    _filtersSlide = Tween<Offset>(
      begin: const Offset(0, 0.12),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _introController,
        curve: const Interval(0.3, 0.72, curve: Curves.easeOutCubic),
      ),
    );
    _bodyFade = CurvedAnimation(
      parent: _introController,
      curve: const Interval(0.45, 1.0, curve: Curves.easeOut),
    );

    _introController.forward();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    cubit = context.read<SearchCubit>();
    if (!cubit!.isClosed) {
      cubit!.searchScrollController ??= ScrollController();
      if (widget.patientsOnly) {
        cubit!.configurePatientsOnlyMode();
      }
    }
  }

  @override
  void dispose() {
    _introController.dispose();
    _pulseController.dispose();
    if (cubit != null && !cubit!.isClosed) {
      cubit!.searchScrollController?.dispose();
      cubit!.searchScrollController = null;
    }
    super.dispose();
  }

  bool get _canSearchPatients =>
      PermissionHelper.canPermission(
          AppPermissions.viewPatientOptionInHomeSearch) &&
      isVerifiedUser(widget.isSyndicateCardRequired);

  Future<void> _runSearch(SearchCubit cubit) async {
    if (!widget.patientsOnly &&
        cubit.dose &&
        cubit.searchController.text.trim().isNotEmpty) {
      final hasPermission = await PermissionHelper.hasPermission(
        AppPermissions.searchDoses,
      );
      if (!mounted) return;
      if (!hasPermission) {
        showCustomDialog(
          context: context,
          title: context.tr(AppStrings.attention),
          description:
              context.tr(AppStrings.youDontHavePermissionToSearchDoses),
          coloredButtonText: context.tr(AppStrings.ok),
          coloredButtonOnTap: () => Navigator.of(context).pop(),
          isNoColorShow: false,
        );
        return;
      }
    }

    cubit.getSearchHome(isVerifiedUser(widget.isSyndicateCardRequired));
  }

  @override
  Widget build(BuildContext context) {
    final cubit = SearchCubit.get(context);
    final topInset = MediaQuery.paddingOf(context).top;

    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        final isDark = themeState is ThemeLoaded && themeState.isDarkMode;
        final primary = HomeDashboardColors.primary(isDark);

        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness:
                isDark ? Brightness.light : Brightness.dark,
            statusBarBrightness: isDark ? Brightness.dark : Brightness.light,
          ),
          child: Scaffold(
            backgroundColor: HomeDashboardColors.scaffold(isDark),
            body: Column(
              children: [
                FadeTransition(
                  opacity: _headerFade,
                  child: SlideTransition(
                    position: _headerSlide,
                    child: _SearchHeader(
                      isDark: isDark,
                      primary: primary,
                      topInset: topInset,
                      patientsOnly: widget.patientsOnly,
                      onBack: () => Navigator.of(context).pop(),
                    ),
                  ),
                ),
                FadeTransition(
                  opacity: _fieldFade,
                  child: SlideTransition(
                    position: _fieldSlide,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(16.w, 4.h, 16.w, 0),
                      child: _SearchField(
                        isDark: isDark,
                        primary: primary,
                        controller: cubit.searchController,
                        hintText: widget.patientsOnly
                            ? context.tr(AppStrings.searchPatientsEllipsis)
                            : '${isVerifiedUser(widget.isSyndicateCardRequired) ? context.tr(AppStrings.search) : context.tr(AppStrings.searchForDoses)}...',
                        onClear: () {
                          cubit.clearSearchResults();
                          setState(() {});
                        },
                        onSubmit: () => _runSearch(cubit),
                        onSearchTap: () => _runSearch(cubit),
                        pulse: _pulseController,
                      ),
                    ),
                  ),
                ),
                if (_canSearchPatients && !widget.patientsOnly)
                  FadeTransition(
                    opacity: _filtersFade,
                    child: SlideTransition(
                      position: _filtersSlide,
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(16.w, 14.h, 16.w, 0),
                        child: _SearchFilters(
                          isDark: isDark,
                          primary: primary,
                          patientSelected: cubit.patientOrDoctorOrHospital,
                          doseSelected: cubit.dose,
                          onPatientChanged: (value) {
                            setState(() {
                              cubit.patientOrDoctorOrHospital = value;
                            });
                          },
                          onDoseChanged: (value) {
                            setState(() {
                              cubit.dose = value;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                SizedBox(height: 12.h),
                Expanded(
                  child: FadeTransition(
                    opacity: _bodyFade,
                    child: BlocBuilder<SearchCubit, SearchState>(
                      builder: (context, state) {
                        return AnimatedSwitcher(
                          duration: const Duration(milliseconds: 320),
                          switchInCurve: Curves.easeOutCubic,
                          switchOutCurve: Curves.easeInCubic,
                          transitionBuilder: (child, animation) {
                            return FadeTransition(
                              opacity: animation,
                              child: SlideTransition(
                                position: Tween<Offset>(
                                  begin: const Offset(0, 0.04),
                                  end: Offset.zero,
                                ).animate(animation),
                                child: child,
                              ),
                            );
                          },
                          child: state.maybeWhen(
                            orElse: () => _SearchIdleState(
                              key: const ValueKey('idle'),
                              isDark: isDark,
                              primary: primary,
                              patientsOnly: widget.patientsOnly,
                            ),
                            loading: () => _SearchLoadingState(
                              key: const ValueKey('loading'),
                              isDark: isDark,
                              primary: primary,
                            ),
                            loaded: (patients, doses) {
                              final patientList = patients ?? [];
                              final doseList = doses ?? [];
                              if (patientList.isEmpty && doseList.isEmpty) {
                                return _SearchEmptyState(
                                  key: const ValueKey('empty'),
                                  isDark: isDark,
                                  primary: primary,
                                );
                              }
                              return _SearchResults(
                                key: const ValueKey('results'),
                                isDark: isDark,
                                primary: primary,
                                patients: patientList,
                                doses: widget.patientsOnly
                                    ? const []
                                    : doseList,
                                patientsOnly: widget.patientsOnly,
                                scrollController: cubit.searchScrollController,
                                accountVerification: widget.accountVerification,
                                isSyndicateCardRequired:
                                    widget.isSyndicateCardRequired,
                                currentDoctorPoints: widget.currentDoctorPoints,
                                currentDoctorRole: widget.currentDoctorRole,
                                currentDoctorModel: widget.currentDoctorModel,
                                homeDataModel: widget.homeDataModel,
                              );
                            },
                            error: (message) => _SearchEmptyState(
                              key: const ValueKey('error'),
                              isDark: isDark,
                              primary: primary,
                              title: message,
                              subtitle: context.tr(
                                AppStrings.tryDifferentSearchTerms,
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
          ),
        );
      },
    );
  }
}

class _SearchHeader extends StatelessWidget {
  final bool isDark;
  final Color primary;
  final double topInset;
  final VoidCallback onBack;
  final bool patientsOnly;

  const _SearchHeader({
    required this.isDark,
    required this.primary,
    required this.topInset,
    required this.onBack,
    this.patientsOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(12.w, topInset + 8.h, 16.w, 12.h),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            HomeDashboardColors.header(isDark),
            HomeDashboardColors.scaffold(isDark),
          ],
        ),
      ),
      child: Row(
        children: [
          _RoundIconButton(
            icon: Icons.arrow_back_ios_new_rounded,
            isDark: isDark,
            onTap: onBack,
          ),
          SizedBox(width: 12.w),
          Container(
            width: 36.r,
            height: 36.r,
            decoration: BoxDecoration(
              color: primary.withOpacity(isDark ? 0.2 : 0.12),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(Icons.search_rounded, color: primary, size: 18.sp),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  context.tr(AppStrings.search),
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.3,
                    color: HomeDashboardColors.title(isDark),
                  ),
                ),
                Text(
                  patientsOnly
                      ? context.tr(AppStrings.findPatients)
                      : context.tr(AppStrings.findPatientsAndDoses),
                  style: TextStyle(
                    fontSize: 11.5.sp,
                    fontWeight: FontWeight.w500,
                    color: HomeDashboardColors.subtitle(isDark),
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

class _RoundIconButton extends StatelessWidget {
  final IconData icon;
  final bool isDark;
  final VoidCallback onTap;

  const _RoundIconButton({
    required this.icon,
    required this.isDark,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12.r),
        child: Container(
          width: 40.r,
          height: 40.r,
          decoration: BoxDecoration(
            color: HomeDashboardColors.cardBg(isDark),
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              color: HomeDashboardColors.border(isDark).withOpacity(0.8),
            ),
          ),
          child: Icon(
            icon,
            size: 16.sp,
            color: HomeDashboardColors.title(isDark),
          ),
        ),
      ),
    );
  }
}

class _SearchField extends StatefulWidget {
  final bool isDark;
  final Color primary;
  final TextEditingController controller;
  final String hintText;
  final VoidCallback onClear;
  final VoidCallback onSubmit;
  final VoidCallback onSearchTap;
  final Animation<double> pulse;

  const _SearchField({
    required this.isDark,
    required this.primary,
    required this.controller,
    required this.hintText,
    required this.onClear,
    required this.onSubmit,
    required this.onSearchTap,
    required this.pulse,
  });

  @override
  State<_SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<_SearchField> {
  late final FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode()..addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([widget.controller, widget.pulse]),
      builder: (context, _) {
        final hasText = widget.controller.text.trim().isNotEmpty;
        final isFocused = _focusNode.hasFocus;
        final highlighted = hasText || isFocused;
        final glow = 0.12 + (widget.pulse.value * 0.1);

        return AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          height: 54,
          decoration: BoxDecoration(
            color: HomeDashboardColors.cardBg(widget.isDark),
            borderRadius: BorderRadius.circular(18.r),
            border: Border.all(
              color: highlighted
                  ? widget.primary.withOpacity(0.55)
                  : HomeDashboardColors.border(widget.isDark).withOpacity(0.8),
              width: highlighted ? 1.5 : 1,
            ),
            boxShadow: [
              BoxShadow(
                color: widget.primary.withOpacity(highlighted ? glow : 0.04),
                blurRadius: highlighted ? 16 : 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              SizedBox(width: 14.w),
              Icon(
                Icons.search_rounded,
                size: 20.sp,
                color: highlighted
                    ? widget.primary
                    : HomeDashboardColors.subtitle(widget.isDark),
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: Theme(
                  data: Theme.of(context).copyWith(
                    inputDecorationTheme: const InputDecorationTheme(
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      focusedErrorBorder: InputBorder.none,
                      filled: false,
                    ),
                  ),
                  child: TextField(
                    controller: widget.controller,
                    focusNode: _focusNode,
                    autofocus: true,
                    cursorColor: widget.primary,
                    textInputAction: TextInputAction.search,
                    onTapOutside: (_) =>
                        FocusManager.instance.primaryFocus?.unfocus(),
                    onSubmitted: (_) => widget.onSubmit(),
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: HomeDashboardColors.title(widget.isDark),
                    ),
                    decoration: InputDecoration(
                      isDense: true,
                      isCollapsed: true,
                      filled: false,
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      focusedErrorBorder: InputBorder.none,
                      contentPadding: EdgeInsets.zero,
                      hintText: widget.hintText,
                      hintStyle: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w500,
                        color: HomeDashboardColors.subtitle(widget.isDark),
                      ),
                    ),
                  ),
                ),
              ),
              if (hasText)
                IconButton(
                  onPressed: widget.onClear,
                  visualDensity: VisualDensity.compact,
                  icon: Icon(
                    Icons.close_rounded,
                    size: 18.sp,
                    color: HomeDashboardColors.subtitle(widget.isDark),
                  ),
                ),
              Padding(
                padding: EdgeInsetsDirectional.only(end: 6.w),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: widget.onSearchTap,
                    borderRadius: BorderRadius.circular(14.r),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 180),
                      width: 42,
                      height: 42,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14.r),
                        gradient: LinearGradient(
                          colors: [
                            widget.primary,
                            widget.primary.withOpacity(0.82),
                          ],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: widget.primary.withOpacity(0.28),
                            blurRadius: 10,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Icon(
                        Icons.arrow_forward_rounded,
                        color: Colors.white,
                        size: 18.sp,
                        textDirection: Directionality.of(context),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _SearchFilters extends StatelessWidget {
  final bool isDark;
  final Color primary;
  final bool patientSelected;
  final bool doseSelected;
  final ValueChanged<bool> onPatientChanged;
  final ValueChanged<bool> onDoseChanged;

  const _SearchFilters({
    required this.isDark,
    required this.primary,
    required this.patientSelected,
    required this.doseSelected,
    required this.onPatientChanged,
    required this.onDoseChanged,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchCubit, SearchState>(
      builder: (context, state) {
        final patientCount = state.maybeWhen(
          loaded: (patients, doses) => patients?.length ?? 0,
          orElse: () => 0,
        );
        final doseCount = state.maybeWhen(
          loaded: (patients, doses) => doses?.length ?? 0,
          orElse: () => 0,
        );

        return Row(
          children: [
            Expanded(
              child: _FilterChipCard(
                isDark: isDark,
                primary: primary,
                selected: patientSelected,
                icon: Icons.person_outline_rounded,
                label: context.tr(AppStrings.patient),
                count: patientCount,
                onTap: () => onPatientChanged(!patientSelected),
              ),
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: _FilterChipCard(
                isDark: isDark,
                primary: primary,
                selected: doseSelected,
                icon: Icons.medication_outlined,
                label: context.tr(AppStrings.dose),
                count: doseCount,
                onTap: () => onDoseChanged(!doseSelected),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _FilterChipCard extends StatelessWidget {
  final bool isDark;
  final Color primary;
  final bool selected;
  final IconData icon;
  final String label;
  final int count;
  final VoidCallback onTap;

  const _FilterChipCard({
    required this.isDark,
    required this.primary,
    required this.selected,
    required this.icon,
    required this.label,
    required this.count,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14.r),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOutCubic,
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
          decoration: BoxDecoration(
            color: selected
                ? primary.withOpacity(isDark ? 0.2 : 0.1)
                : HomeDashboardColors.cardBg(isDark),
            borderRadius: BorderRadius.circular(14.r),
            border: Border.all(
              color: selected
                  ? primary.withOpacity(0.45)
                  : HomeDashboardColors.border(isDark).withOpacity(0.75),
              width: selected ? 1.4 : 1,
            ),
          ),
          child: Row(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: 32.r,
                height: 32.r,
                decoration: BoxDecoration(
                  color: selected
                      ? primary.withOpacity(isDark ? 0.28 : 0.16)
                      : HomeDashboardColors.surfaceBg(isDark),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Icon(
                  icon,
                  size: 16.sp,
                  color:
                      selected ? primary : HomeDashboardColors.subtitle(isDark),
                ),
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 12.5.sp,
                    fontWeight: FontWeight.w700,
                    color:
                        selected ? primary : HomeDashboardColors.title(isDark),
                  ),
                ),
              ),
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: EdgeInsets.symmetric(horizontal: 7.w, vertical: 3),
                decoration: BoxDecoration(
                  color: count > 0
                      ? HomeDashboardColors.success.withOpacity(0.15)
                      : HomeDashboardColors.surfaceBg(isDark),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Text(
                  '$count',
                  style: TextStyle(
                    fontSize: 10.5.sp,
                    fontWeight: FontWeight.w800,
                    color: count > 0
                        ? HomeDashboardColors.success
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

class _SearchIdleState extends StatelessWidget {
  final bool isDark;
  final Color primary;
  final bool patientsOnly;

  const _SearchIdleState({
    super.key,
    required this.isDark,
    required this.primary,
    this.patientsOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    return _StatusPanel(
      isDark: isDark,
      primary: primary,
      icon: Icons.manage_search_rounded,
      title: context.tr(AppStrings.typeAtLeastOneCharacterToSearch),
      subtitle: patientsOnly
          ? context.tr(AppStrings.searchPatientsByNameOrId)
          : context.tr(AppStrings.searchAcrossPatientsAndMedicationDoses),
    );
  }
}

class _SearchEmptyState extends StatelessWidget {
  final bool isDark;
  final Color primary;
  final String? title;
  final String? subtitle;

  const _SearchEmptyState({
    super.key,
    required this.isDark,
    required this.primary,
    this.title,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return _StatusPanel(
      isDark: isDark,
      primary: primary,
      icon: Icons.search_off_rounded,
      title: title ?? context.tr(AppStrings.noResultsFound),
      subtitle: subtitle ?? context.tr(AppStrings.tryDifferentSearchTerms),
    );
  }
}

class _SearchLoadingState extends StatelessWidget {
  final bool isDark;
  final Color primary;

  const _SearchLoadingState({
    super.key,
    required this.isDark,
    required this.primary,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 28.r,
            height: 28.r,
            child: CircularProgressIndicator(
              strokeWidth: 2.4,
              color: primary,
            ),
          ),
          SizedBox(height: 14.h),
          Text(
            context.tr(AppStrings.searching),
            style: TextStyle(
              fontSize: 13.sp,
              fontWeight: FontWeight.w600,
              color: HomeDashboardColors.subtitle(isDark),
            ),
          ),
        ],
      ),
    );
  }
}

class _StatusPanel extends StatelessWidget {
  final bool isDark;
  final Color primary;
  final IconData icon;
  final String title;
  final String subtitle;

  const _StatusPanel({
    required this.isDark,
    required this.primary,
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 28.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 78.r,
              height: 78.r,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    primary.withOpacity(isDark ? 0.28 : 0.16),
                    primary.withOpacity(isDark ? 0.1 : 0.05),
                  ],
                ),
              ),
              child: Icon(icon, size: 34.sp, color: primary),
            ),
            SizedBox(height: 16.h),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w700,
                color: HomeDashboardColors.title(isDark),
              ),
            ),
            SizedBox(height: 6.h),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
                height: 1.4,
                color: HomeDashboardColors.subtitle(isDark),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SearchResults extends StatelessWidget {
  final bool isDark;
  final Color primary;
  final List<PatientHomeDataModel> patients;
  final List<SearchDataForDosesModelResponse> doses;
  final bool patientsOnly;
  final ScrollController? scrollController;
  final bool accountVerification;
  final String isSyndicateCardRequired;
  final int currentDoctorPoints;
  final String currentDoctorRole;
  final DoctorModel currentDoctorModel;
  final HomeModelResponse homeDataModel;

  const _SearchResults({
    super.key,
    required this.isDark,
    required this.primary,
    required this.patients,
    required this.doses,
    this.patientsOnly = false,
    required this.scrollController,
    required this.accountVerification,
    required this.isSyndicateCardRequired,
    required this.currentDoctorPoints,
    required this.currentDoctorRole,
    required this.currentDoctorModel,
    required this.homeDataModel,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      controller: scrollController,
      physics: const BouncingScrollPhysics(
        parent: AlwaysScrollableScrollPhysics(),
      ),
      padding: EdgeInsets.fromLTRB(16.w, 4.h, 16.w, 28.h),
      children: [
        if (patients.isNotEmpty) ...[
          _SectionLabel(
            isDark: isDark,
            primary: primary,
            icon: Icons.people_alt_outlined,
            label: context.tr(AppStrings.patients),
            count: patients.length,
          ),
          SizedBox(height: 10.h),
          ...List.generate(patients.length, (index) {
            final patient = patients[index];
            return _StaggeredItem(
              index: index,
              child: Padding(
                padding: EdgeInsets.only(bottom: 12.h),
                child: HomePatientCard(
                  isDark: isDark,
                  patient: patient,
                  onOutcomeTap: () {
                    navigatorKey.currentState?.pushNamed(
                      AppRoutes.outcome,
                      arguments: AppRoutesArgs.outcomeRouteArgs(
                        verified: accountVerification,
                        outcomeStatus: patient.sections?.outcomeStatus ?? false,
                        patientName: patient.name.toString(),
                        patientId: patient.id.toString(),
                        currentDoctorModel: currentDoctorModel,
                        doctorId: patient.doctor?.id.toString() ?? '',
                        isSyndicateCardRequired: isSyndicateCardRequired,
                        currentDoctorRole: currentDoctorRole,
                        currentDoctorPoints: currentDoctorPoints,
                        homeDataModel: homeDataModel,
                      ),
                    );
                  },
                  onAddCommentTap: () {
                    navigatorKey.currentState?.pushNamed(
                      AppRoutes.comments,
                      arguments: AppRoutesArgs.patientCommentsRouteArgs(
                        patientId: patient.id.toString(),
                        currentDoctorModel: currentDoctorModel,
                        currentDoctorRole: currentDoctorRole,
                        homeDataModel: homeDataModel,
                        verified: accountVerification,
                        patientName: patient.name.toString(),
                        currentDoctorPoints: currentDoctorPoints,
                        isSyndicateCardRequired: isSyndicateCardRequired,
                      ),
                    );
                  },
                  onTap: () {
                    navigatorKey.currentState?.pushNamed(
                      AppRoutes.patientSections,
                      arguments: AppRoutesArgs.patientSectionsRouteArguments(
                        patientId: patient.id.toString(),
                        currentDoctorModel: currentDoctorModel,
                        currentDoctorPoints: currentDoctorPoints,
                        currentDoctorRole: homeDataModel.role.toString(),
                        homeDataModel: homeDataModel,
                        isAllDataOpen: false,
                      ),
                    );
                  },
                ),
              ),
            );
          }),
        ],
        if (!patientsOnly &&
            patients.isNotEmpty &&
            doses.isNotEmpty) SizedBox(height: 8.h),
        if (!patientsOnly && doses.isNotEmpty) ...[
          _SectionLabel(
            isDark: isDark,
            primary: primary,
            icon: Icons.medication_liquid_outlined,
            label: context.tr(AppStrings.dose),
            count: doses.length,
          ),
          SizedBox(height: 10.h),
          ...List.generate(doses.length, (index) {
            return _StaggeredItem(
              index: patients.length + index,
              child: Padding(
                padding: EdgeInsets.only(bottom: 10.h),
                child: _DoseResultCard(
                  isDark: isDark,
                  primary: primary,
                  dose: doses[index],
                ),
              ),
            );
          }),
        ],
      ],
    );
  }
}

class _SectionLabel extends StatelessWidget {
  final bool isDark;
  final Color primary;
  final IconData icon;
  final String label;
  final int count;

  const _SectionLabel({
    required this.isDark,
    required this.primary,
    required this.icon,
    required this.label,
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 16.sp, color: primary),
        SizedBox(width: 6.w),
        Text(
          label,
          style: TextStyle(
            fontSize: 13.sp,
            fontWeight: FontWeight.w800,
            color: HomeDashboardColors.title(isDark),
          ),
        ),
        SizedBox(width: 8.w),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 7.w, vertical: 2),
          decoration: BoxDecoration(
            color: primary.withOpacity(isDark ? 0.2 : 0.12),
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Text(
            '$count',
            style: TextStyle(
              fontSize: 10.5.sp,
              fontWeight: FontWeight.w800,
              color: primary,
            ),
          ),
        ),
      ],
    );
  }
}

class _DoseResultCard extends StatelessWidget {
  final bool isDark;
  final Color primary;
  final SearchDataForDosesModelResponse dose;

  const _DoseResultCard({
    required this.isDark,
    required this.primary,
    required this.dose,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: HomeDashboardDecor.card(isDark).copyWith(
        borderRadius: BorderRadius.circular(16.r),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  primary,
                  primary.withOpacity(0.82),
                ],
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 30.r,
                  height: 30.r,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.18),
                    borderRadius: BorderRadius.circular(9.r),
                  ),
                  child: Icon(
                    Icons.medication_outlined,
                    size: 16.sp,
                    color: Colors.white,
                  ),
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: Text(
                    dose.title.toString(),
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 13.5.sp,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(14.w, 12.h, 14.w, 14.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (dose.description != null) ...[
                  Text(
                    context.tr(AppStrings.description),
                    style: TextStyle(
                      fontSize: 10.5.sp,
                      fontWeight: FontWeight.w700,
                      color: HomeDashboardColors.subtitle(isDark),
                    ),
                  ),
                  SizedBox(height: 4.h),
                  HtmlWidget(
                    dose.description.toString(),
                    textStyle: TextStyle(
                      color: HomeDashboardColors.title(isDark),
                      fontWeight: FontWeight.w500,
                      fontSize: 12.5.sp,
                      height: 1.4,
                    ),
                  ),
                  SizedBox(height: 12.h),
                ],
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(12.w),
                  decoration: BoxDecoration(
                    color: primary.withOpacity(isDark ? 0.14 : 0.08),
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(color: primary.withOpacity(0.2)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.science_outlined,
                            size: 14.sp,
                            color: primary,
                          ),
                          SizedBox(width: 6.w),
                          Text(
                            context.tr(AppStrings.dose),
                            style: TextStyle(
                              fontSize: 11.sp,
                              fontWeight: FontWeight.w800,
                              color: primary,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 6.h),
                      HtmlWidget(
                        dose.dose.toString(),
                        textStyle: TextStyle(
                          color: HomeDashboardColors.title(isDark),
                          fontWeight: FontWeight.w600,
                          fontSize: 12.5.sp,
                          height: 1.4,
                        ),
                      ),
                    ],
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

class _StaggeredItem extends StatefulWidget {
  final int index;
  final Widget child;

  const _StaggeredItem({
    required this.index,
    required this.child,
  });

  @override
  State<_StaggeredItem> createState() => _StaggeredItemState();
}

class _StaggeredItemState extends State<_StaggeredItem>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fade;
  late final Animation<Offset> _slide;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 420),
    );
    _fade = CurvedAnimation(parent: _controller, curve: Curves.easeOut);
    _slide = Tween<Offset>(
      begin: const Offset(0, 0.08),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
    );

    final delay = (widget.index.clamp(0, 8) * 45);
    Future.delayed(Duration(milliseconds: delay), () {
      if (mounted) _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fade,
      child: SlideTransition(
        position: _slide,
        child: widget.child,
      ),
    );
  }
}
