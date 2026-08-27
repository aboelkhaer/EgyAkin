import 'package:egy_akin/features/home/presentation/widgets/dashboard/home_dashboard_shared.dart';
import 'package:egy_akin/features/home/presentation/widgets/patients/home_patient_widgets.dart';
import 'package:egy_akin/features/home/presentation/widgets/patients/home_patients_loading.dart';
import 'package:egy_akin/features/marked_patients/presentation/cubit/marked_patients_cubit.dart';
import 'package:egy_akin/features/marked_patients/presentation/cubit/marked_patients_state.dart';
import 'package:egy_akin/features/profile_patients/presentation/cubit/profile_patients_state.dart';

import '../../../../exports.dart';

class ProfilePatientsScreen extends StatefulWidget {
  final DoctorModel currentDoctorModel;
  final bool accountVerification;
  final String isSyndicateCardRequired;
  final String doctorId;
  final String doctorFirstName;
  final String currentDoctorRole;
  final int currentDoctorPoints;
  final HomeModelResponse homeDataModel;
  final bool initialShowMarked;

  const ProfilePatientsScreen({
    super.key,
    required this.doctorId,
    required this.currentDoctorModel,
    required this.accountVerification,
    required this.isSyndicateCardRequired,
    required this.doctorFirstName,
    required this.currentDoctorRole,
    required this.currentDoctorPoints,
    required this.homeDataModel,
    this.initialShowMarked = false,
  });

  @override
  State<ProfilePatientsScreen> createState() => _ProfilePatientsScreenState();
}

class _ProfilePatientsScreenState extends State<ProfilePatientsScreen> {
  ProfilePatientsCubit? _myCubit;
  MarkedPatientsCubit? _markedCubit;
  late bool _showMyPatients;
  bool _markedLoaded = false;

  bool get _isOwnProfile =>
      widget.doctorId == widget.currentDoctorModel.id?.toString();

  @override
  void initState() {
    super.initState();
    _showMyPatients = !widget.initialShowMarked || !_isOwnProfile;
    context.read<ProfilePatientsCubit>().getProfilePatients(widget.doctorId);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _myCubit = context.read<ProfilePatientsCubit>();
      if (!_myCubit!.isClosed) {
        _myCubit!.scrollController = ScrollController();
        _myCubit!.scrollController!.addListener(_onMyScroll);
      }

      if (_isOwnProfile) {
        _markedCubit = context.read<MarkedPatientsCubit>();
        if (!_markedCubit!.isClosed) {
          _markedCubit!.scrollController = ScrollController();
          _markedCubit!.scrollController!.addListener(_onMarkedScroll);
          if (!_showMyPatients) {
            _loadMarkedIfNeeded();
          }
        }
      }
    });
  }

  @override
  void dispose() {
    if (_myCubit != null && !_myCubit!.isClosed) {
      _myCubit!.scrollController?.dispose();
    }
    if (_markedCubit != null && !_markedCubit!.isClosed) {
      _markedCubit!.scrollController?.dispose();
    }
    super.dispose();
  }

  void _loadMarkedIfNeeded() {
    if (!_isOwnProfile || _markedLoaded) return;
    _markedLoaded = true;
    context.read<MarkedPatientsCubit>().getMarkedPatients();
  }

  void _onMyScroll() {
    final cubit = context.read<ProfilePatientsCubit>();
    if (cubit.isLastPage || cubit.scrollController == null) return;

    final maxScroll = cubit.scrollController!.position.maxScrollExtent;
    final currentScroll = cubit.scrollController!.position.pixels;
    const threshold = 200.0;
    if (!cubit.isLoadingMoreForScroll &&
        maxScroll - currentScroll <= threshold) {
      cubit.isLoadingMoreForScroll = true;
      cubit.loadMorePatients(widget.doctorId);
    }
  }

  void _onMarkedScroll() {
    final cubit = context.read<MarkedPatientsCubit>();
    if (cubit.isLastPage ||
        cubit.isLoadingMoreForScroll ||
        cubit.scrollController == null) {
      return;
    }

    final position = cubit.scrollController!.position;
    const threshold = 200.0;
    if (position.maxScrollExtent - position.pixels <= threshold) {
      cubit.isLoadingMoreForScroll = true;
      cubit.loadMoreMarkedPatients();
    }
  }

  void _onTabChanged(bool showMy) {
    if (_showMyPatients == showMy) return;
    setState(() => _showMyPatients = showMy);
    if (!showMy) _loadMarkedIfNeeded();
  }

  void _openPatient(PatientHomeDataModel patient) {
    navigatorKey.currentState?.pushNamed(
      AppRoutes.patientSections,
      arguments: AppRoutesArgs.patientSectionsRouteArguments(
        patientId: patient.id.toString(),
        currentDoctorModel: widget.currentDoctorModel,
        currentDoctorPoints: widget.currentDoctorPoints,
        currentDoctorRole: widget.currentDoctorRole,
        homeDataModel: widget.homeDataModel,
        isAllDataOpen: false,
      ),
    );
  }

  void _openOutcome(PatientHomeDataModel patient) {
    navigatorKey.currentState?.pushNamed(
      AppRoutes.outcome,
      arguments: AppRoutesArgs.outcomeRouteArgs(
        verified: widget.homeDataModel.verified!,
        outcomeStatus: patient.sections?.outcomeStatus ?? false,
        patientName: patient.name.toString(),
        patientId: patient.id.toString(),
        currentDoctorModel: widget.currentDoctorModel,
        doctorId: patient.doctor?.id.toString() ?? '',
        homeDataModel: widget.homeDataModel,
        isSyndicateCardRequired:
            widget.homeDataModel.isSyndicateCardRequired.toString(),
        currentDoctorRole: widget.currentDoctorRole,
        currentDoctorPoints: widget.currentDoctorPoints,
      ),
    );
  }

  void _openComments(PatientHomeDataModel patient) {
    navigatorKey.currentState?.pushNamed(
      AppRoutes.comments,
      arguments: AppRoutesArgs.patientCommentsRouteArgs(
        patientId: patient.id.toString(),
        currentDoctorModel: widget.currentDoctorModel,
        verified: widget.homeDataModel.verified!,
        homeDataModel: widget.homeDataModel,
        currentDoctorRole: widget.currentDoctorRole,
        patientName: patient.name.toString(),
        isSyndicateCardRequired:
            widget.homeDataModel.isSyndicateCardRequired.toString(),
        currentDoctorPoints: widget.currentDoctorPoints,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final myCubit = ProfilePatientsCubit.get(context);
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        final isDark = themeState is ThemeLoaded && themeState.isDarkMode;
        final primary = HomeDashboardColors.primary(isDark);
        final titleColor = HomeDashboardColors.title(isDark);
        final scaffold = HomeDashboardColors.scaffold(isDark);
        final title = _isOwnProfile
            ? context.tr(AppStrings.patients)
            : 'Dr.${capitalizeFirstText(widget.doctorFirstName)}\'s ${LocalizationService.instance.translate(AppStrings.patients)}';

        final myCount = int.tryParse(
              context.read<HomeCubit>().doctorPatientCount ??
                  widget.currentDoctorModel.patientsCount ??
                  '0',
            ) ??
            0;
        final markedCount = int.tryParse(
              widget.homeDataModel.markedPatientsCount ?? '0',
            ) ??
            0;

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
                _ProfilePatientsHeader(
                  isDark: isDark,
                  scaffold: scaffold,
                  primary: primary,
                  titleColor: titleColor,
                  title: title,
                  onBack: () => Navigator.of(context).maybePop(),
                  onTitleTap: () {
                    final controller = _showMyPatients
                        ? myCubit.scrollController
                        : (_markedCubit?.scrollController);
                    if (controller != null) {
                      animateToTopOfScreen(controller);
                    }
                  },
                ),
                if (_isOwnProfile)
                  Padding(
                    padding: EdgeInsets.fromLTRB(16.w, 4.h, 16.w, 8.h),
                    child: _PatientsTabs(
                      isDark: isDark,
                      showMyPatients: _showMyPatients,
                      myPatientsCount: myCount,
                      markedPatientsCount: markedCount,
                      onChanged: _onTabChanged,
                    ),
                  ),
                Expanded(
                  child: _showMyPatients || !_isOwnProfile
                      ? _MyPatientsTab(
                          isDark: isDark,
                          primary: primary,
                          doctorId: widget.doctorId,
                          onOpenPatient: _openPatient,
                          onOpenOutcome: _openOutcome,
                          onOpenComments: _openComments,
                        )
                      : _MarkedPatientsTab(
                          isDark: isDark,
                          primary: primary,
                          onOpenPatient: _openPatient,
                          onOpenOutcome: _openOutcome,
                          onOpenComments: _openComments,
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

class _PatientsTabs extends StatelessWidget {
  final bool isDark;
  final bool showMyPatients;
  final int myPatientsCount;
  final int markedPatientsCount;
  final ValueChanged<bool> onChanged;

  const _PatientsTabs({
    required this.isDark,
    required this.showMyPatients,
    required this.myPatientsCount,
    required this.markedPatientsCount,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: HomeDashboardColors.surfaceBg(isDark),
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: Row(
        children: [
          Expanded(
            child: _TabChip(
              label: context.tr(AppStrings.myPatients),
              count: myPatientsCount,
              isSelected: showMyPatients,
              isDark: isDark,
              onTap: () => onChanged(true),
            ),
          ),
          Expanded(
            child: _TabChip(
              label: context.tr(AppStrings.markedPatients),
              count: markedPatientsCount,
              isSelected: !showMyPatients,
              isDark: isDark,
              onTap: () => onChanged(false),
            ),
          ),
        ],
      ),
    );
  }
}

class _TabChip extends StatelessWidget {
  final String label;
  final int count;
  final bool isSelected;
  final bool isDark;
  final VoidCallback onTap;

  const _TabChip({
    required this.label,
    required this.count,
    required this.isSelected,
    required this.isDark,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final primary = HomeDashboardColors.primary(isDark);

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: EdgeInsets.symmetric(vertical: 10.h),
        decoration: BoxDecoration(
          color: isSelected
              ? (isDark ? primary : primary.withOpacity(0.15))
              : Colors.transparent,
          borderRadius: BorderRadius.circular(11.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              child: Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w700,
                  color: isSelected
                      ? (isDark ? Colors.white : primary)
                      : HomeDashboardColors.subtitle(isDark),
                ),
              ),
            ),
            SizedBox(width: 6.w),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 7.w, vertical: 2.h),
              decoration: BoxDecoration(
                color: isSelected
                    ? (isDark
                        ? Colors.white.withOpacity(0.2)
                        : primary.withOpacity(0.2))
                    : HomeDashboardColors.border(isDark),
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Text(
                '$count',
                style: TextStyle(
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w700,
                  color: isSelected
                      ? (isDark ? Colors.white : primary)
                      : HomeDashboardColors.subtitle(isDark),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MyPatientsTab extends StatelessWidget {
  final bool isDark;
  final Color primary;
  final String doctorId;
  final ValueChanged<PatientHomeDataModel> onOpenPatient;
  final ValueChanged<PatientHomeDataModel> onOpenOutcome;
  final ValueChanged<PatientHomeDataModel> onOpenComments;

  const _MyPatientsTab({
    required this.isDark,
    required this.primary,
    required this.doctorId,
    required this.onOpenPatient,
    required this.onOpenOutcome,
    required this.onOpenComments,
  });

  @override
  Widget build(BuildContext context) {
    final cubit = ProfilePatientsCubit.get(context);
    return Column(
      children: [
        Expanded(
          child: BlocBuilder<ProfilePatientsCubit, ProfilePatientsState>(
            builder: (context, state) {
              return state.maybeWhen(
                orElse: () {
                  return ListView(
                    padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 24.h),
                    children: [
                      HomePatientsLoadingList(isDark: isDark),
                    ],
                  );
                },
                loaded: (data, isSeeMore) {
                  final patients = data.data?.data ?? [];
                  if (patients.isEmpty) {
                    return RefreshIndicator(
                      onRefresh: () async {
                        await cubit.getProfilePatients(doctorId);
                      },
                      color: primary,
                      child: ListView(
                        physics: const AlwaysScrollableScrollPhysics(
                          parent: BouncingScrollPhysics(),
                        ),
                        children: [
                          SizedBox(
                            height: MediaQuery.sizeOf(context).height * 0.55,
                            child: PatientsListEmptyState(
                              isDark: isDark,
                              subtitle: context.tr(
                                AppStrings.thisDoctorHasNoPatientsListed,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  return RefreshIndicator(
                    onRefresh: () async {
                      await cubit.getProfilePatients(doctorId);
                    },
                    color: primary,
                    child: ListView.builder(
                      physics: const AlwaysScrollableScrollPhysics(
                        parent: BouncingScrollPhysics(),
                      ),
                      controller: cubit.scrollController,
                      padding: EdgeInsets.fromLTRB(16.w, 4.h, 16.w, 50.h),
                      itemCount: patients.length,
                      itemBuilder: (context, index) {
                        final patient = patients[index];
                        return Padding(
                          padding: EdgeInsets.only(bottom: 12.h),
                          child: HomePatientCard(
                            isDark: isDark,
                            patient: patient,
                            onOutcomeTap: () => onOpenOutcome(patient),
                            onAddCommentTap: () => onOpenComments(patient),
                            onTap: () => onOpenPatient(patient),
                          ),
                        );
                      },
                    ),
                  );
                },
              );
            },
          ),
        ),
        BlocBuilder<ProfilePatientsCubit, ProfilePatientsState>(
          builder: (context, state) {
            return state.maybeWhen(
              orElse: () => const SizedBox.shrink(),
              loaded: (data, isSeeMore) {
                if (!isSeeMore) return const SizedBox.shrink();
                return Padding(
                  padding: EdgeInsets.only(bottom: 16.h),
                  child: SizedBox(
                    height: 15,
                    width: 15,
                    child: CircularProgressIndicator(
                      strokeWidth: 3,
                      color: primary,
                    ),
                  ),
                );
              },
            );
          },
        ),
      ],
    );
  }
}

class _MarkedPatientsTab extends StatelessWidget {
  final bool isDark;
  final Color primary;
  final ValueChanged<PatientHomeDataModel> onOpenPatient;
  final ValueChanged<PatientHomeDataModel> onOpenOutcome;
  final ValueChanged<PatientHomeDataModel> onOpenComments;

  const _MarkedPatientsTab({
    required this.isDark,
    required this.primary,
    required this.onOpenPatient,
    required this.onOpenOutcome,
    required this.onOpenComments,
  });

  @override
  Widget build(BuildContext context) {
    final cubit = MarkedPatientsCubit.get(context);
    return BlocConsumer<MarkedPatientsCubit, MarkedPatientsState>(
      listener: (context, state) {
        state.maybeWhen(
          orElse: () {},
          error: (message) {
            customSnackBar(context: context, message: message);
          },
        );
      },
      builder: (context, state) {
        return Column(
          children: [
            Expanded(
              child: state.maybeWhen(
                orElse: () {
                  return ListView(
                    padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 24.h),
                    children: [
                      HomePatientsLoadingList(isDark: isDark),
                    ],
                  );
                },
                loaded: (response, isSeeMore) {
                  final patients = response.data?.data ?? [];
                  if (patients.isEmpty) {
                    return RefreshIndicator(
                      onRefresh: () async {
                        await cubit.getMarkedPatients();
                      },
                      color: primary,
                      child: ListView(
                        physics: const AlwaysScrollableScrollPhysics(
                          parent: BouncingScrollPhysics(),
                        ),
                        children: [
                          SizedBox(
                            height: MediaQuery.sizeOf(context).height * 0.55,
                            child: PatientsListEmptyState(
                              isDark: isDark,
                              title: context.tr(AppStrings.noMarkedPatients),
                              subtitle: context.tr(
                                AppStrings.patientsYouAddWillShowUpHere,
                              ),
                              hint: context.tr(
                                AppStrings.openPatientAndUseMark,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  return RefreshIndicator(
                    onRefresh: () async {
                      await cubit.getMarkedPatients();
                    },
                    color: primary,
                    child: ListView.builder(
                      physics: const AlwaysScrollableScrollPhysics(
                        parent: BouncingScrollPhysics(),
                      ),
                      controller: cubit.scrollController,
                      padding: EdgeInsets.fromLTRB(16.w, 4.h, 16.w, 50.h),
                      itemCount: patients.length,
                      itemBuilder: (context, index) {
                        final patient = patients[index];
                        return Padding(
                          padding: EdgeInsets.only(bottom: 12.h),
                          child: HomePatientCard(
                            isDark: isDark,
                            patient: patient,
                            onOutcomeTap: () => onOpenOutcome(patient),
                            onAddCommentTap: () => onOpenComments(patient),
                            onTap: () => onOpenPatient(patient),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
            state.maybeWhen(
              orElse: () => const SizedBox.shrink(),
              loaded: (response, isSeeMore) {
                if (!isSeeMore) return const SizedBox.shrink();
                return Padding(
                  padding: EdgeInsets.only(bottom: 16.h),
                  child: SizedBox(
                    height: 15,
                    width: 15,
                    child: CircularProgressIndicator(
                      strokeWidth: 3,
                      color: primary,
                    ),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }
}

class _ProfilePatientsHeader extends StatelessWidget {
  final bool isDark;
  final Color scaffold;
  final Color primary;
  final Color titleColor;
  final String title;
  final VoidCallback onBack;
  final VoidCallback onTitleTap;

  const _ProfilePatientsHeader({
    required this.isDark,
    required this.scaffold,
    required this.primary,
    required this.titleColor,
    required this.title,
    required this.onBack,
    required this.onTitleTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: isDark
              ? [
                  const Color(0xFF4A2F7A),
                  const Color(0xFF2B1A52),
                  scaffold,
                ]
              : [
                  primary.withOpacity(0.28),
                  primary.withOpacity(0.14),
                  scaffold,
                ],
          stops: const [0.0, 0.55, 1.0],
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: EdgeInsets.fromLTRB(14.w, 4.h, 14.w, 12.h),
          child: SizedBox(
            height: 36.w,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 44.w),
                  child: GestureDetector(
                    onTap: onTitleTap,
                    child: Directionality(
                      textDirection:
                          context.currentLocale?.languageCode == 'ar'
                              ? TextDirection.ltr
                              : TextDirection.rtl,
                      child: Text(
                        title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w800,
                          color: isDark ? Colors.white : titleColor,
                          letterSpacing: -0.2,
                        ),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Material(
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
                                : const Color(0xFFE6E2F0),
                          ),
                        ),
                        child: Icon(
                          Icons.arrow_back_ios_new_rounded,
                          size: 16.sp,
                          color:
                              isDark ? Colors.white : const Color(0xFF1F2937),
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
  }
}
