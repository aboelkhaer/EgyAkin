import 'package:egy_akin/features/home/presentation/widgets/dashboard/home_dashboard_shared.dart';
import 'package:egy_akin/features/home/presentation/widgets/patients/home_patient_widgets.dart';
import 'package:egy_akin/features/home/presentation/widgets/patients/home_patients_loading.dart';
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
  });

  @override
  State<ProfilePatientsScreen> createState() => _ProfilePatientsScreenState();
}

class _ProfilePatientsScreenState extends State<ProfilePatientsScreen> {
  ProfilePatientsCubit? _cubit;

  @override
  void initState() {
    super.initState();
    context.read<ProfilePatientsCubit>().getProfilePatients(widget.doctorId);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _cubit = context.read<ProfilePatientsCubit>();
      if (!_cubit!.isClosed) {
        _cubit!.scrollController = ScrollController();
        _cubit!.scrollController!.addListener(_onScroll);
      }
    });
  }

  @override
  void dispose() {
    if (_cubit != null && !_cubit!.isClosed) {
      _cubit!.scrollController!.dispose();
    }
    super.dispose();
  }

  void _onScroll() {
    if (context.read<ProfilePatientsCubit>().isLastPage) {
      return;
    } else {
      final maxScroll = context
          .read<ProfilePatientsCubit>()
          .scrollController!
          .position
          .maxScrollExtent;
      final currentScroll = context
          .read<ProfilePatientsCubit>()
          .scrollController!
          .position
          .pixels;
      const threshold = 200.0;
      if (context.read<ProfilePatientsCubit>().isLoadingMoreForScroll ==
              false &&
          maxScroll - currentScroll <= threshold) {
        context.read<ProfilePatientsCubit>().isLoadingMoreForScroll = true;

        context.read<ProfilePatientsCubit>().loadMorePatients(widget.doctorId);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    ProfilePatientsCubit cubit = ProfilePatientsCubit.get(context);
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        final isDark = themeState is ThemeLoaded && themeState.isDarkMode;
        final primary = HomeDashboardColors.primary(isDark);
        final titleColor = HomeDashboardColors.title(isDark);
        final scaffold = HomeDashboardColors.scaffold(isDark);
        final title =
            'Dr.${capitalizeFirstText(widget.doctorFirstName)}\'s ${LocalizationService.instance.translate(AppStrings.patients)}';

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
                    if (cubit.scrollController != null) {
                      animateToTopOfScreen(cubit.scrollController!);
                    }
                  },
                ),
                Expanded(
                  child: Column(
                    children: [
                      Expanded(
                        child: BlocBuilder<ProfilePatientsCubit,
                            ProfilePatientsState>(
                          builder: (context, state) {
                            return state.maybeWhen(
                              orElse: () {
                                return ListView(
                                  padding: EdgeInsets.fromLTRB(
                                    16.w,
                                    12.h,
                                    16.w,
                                    24.h,
                                  ),
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
                                      await cubit
                                          .getProfilePatients(widget.doctorId);
                                    },
                                    color: primary,
                                    child: ListView(
                                      physics:
                                          const AlwaysScrollableScrollPhysics(
                                        parent: BouncingScrollPhysics(),
                                      ),
                                      children: [
                                        SizedBox(
                                          height:
                                              MediaQuery.sizeOf(context).height *
                                                  0.62,
                                          child: PatientsListEmptyState(
                                            isDark: isDark,
                                            subtitle: context.tr(
                                              AppStrings
                                                  .thisDoctorHasNoPatientsListed,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }

                                return RefreshIndicator(
                                  onRefresh: () async {
                                    await cubit
                                        .getProfilePatients(widget.doctorId);
                                  },
                                  color: primary,
                                  child: ListView.builder(
                                    physics:
                                        const AlwaysScrollableScrollPhysics(
                                      parent: BouncingScrollPhysics(),
                                    ),
                                    controller: cubit.scrollController,
                                    padding: EdgeInsets.fromLTRB(
                                      16.w,
                                      12.h,
                                      16.w,
                                      50.h,
                                    ),
                                    itemCount: patients.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      final patient = patients[index];
                                      return Padding(
                                        padding: EdgeInsets.only(bottom: 12.h),
                                        child: HomePatientCard(
                                          isDark: isDark,
                                          patient: patient,
                                          onOutcomeTap: () {
                                            navigatorKey.currentState
                                                ?.pushNamed(
                                              AppRoutes.outcome,
                                              arguments: AppRoutesArgs
                                                  .outcomeRouteArgs(
                                                verified: widget
                                                    .homeDataModel.verified!,
                                                outcomeStatus: patient.sections
                                                        ?.outcomeStatus ??
                                                    false,
                                                patientName:
                                                    patient.name.toString(),
                                                patientId:
                                                    patient.id.toString(),
                                                currentDoctorModel:
                                                    widget.currentDoctorModel,
                                                doctorId: patient.doctor?.id
                                                        .toString() ??
                                                    '',
                                                homeDataModel:
                                                    widget.homeDataModel,
                                                isSyndicateCardRequired: widget
                                                    .homeDataModel
                                                    .isSyndicateCardRequired
                                                    .toString(),
                                                currentDoctorRole:
                                                    widget.currentDoctorRole,
                                                currentDoctorPoints:
                                                    widget.currentDoctorPoints,
                                              ),
                                            );
                                          },
                                          onAddCommentTap: () {
                                            navigatorKey.currentState
                                                ?.pushNamed(
                                              AppRoutes.comments,
                                              arguments: AppRoutesArgs
                                                  .patientCommentsRouteArgs(
                                                patientId:
                                                    patient.id.toString(),
                                                currentDoctorModel:
                                                    widget.currentDoctorModel,
                                                verified: widget
                                                    .homeDataModel.verified!,
                                                homeDataModel:
                                                    widget.homeDataModel,
                                                currentDoctorRole:
                                                    widget.currentDoctorRole,
                                                patientName:
                                                    patient.name.toString(),
                                                isSyndicateCardRequired: widget
                                                    .homeDataModel
                                                    .isSyndicateCardRequired
                                                    .toString(),
                                                currentDoctorPoints:
                                                    widget.currentDoctorPoints,
                                              ),
                                            );
                                          },
                                          onTap: () {
                                            navigatorKey.currentState
                                                ?.pushNamed(
                                              AppRoutes.patientSections,
                                              arguments: AppRoutesArgs
                                                  .patientSectionsRouteArguments(
                                                patientId:
                                                    patient.id.toString(),
                                                currentDoctorModel:
                                                    widget.currentDoctorModel,
                                                currentDoctorPoints:
                                                    widget.currentDoctorPoints,
                                                currentDoctorRole:
                                                    widget.currentDoctorRole,
                                                homeDataModel:
                                                    widget.homeDataModel,
                                                isAllDataOpen: false,
                                              ),
                                            );
                                          },
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
                      SizedBox(height: 10.h),
                      BlocBuilder<ProfilePatientsCubit, ProfilePatientsState>(
                        builder: (context, state) {
                          return state.maybeWhen(
                            orElse: () {
                              return const SizedBox.shrink();
                            },
                            loaded: (data, isSeeMore) {
                              return Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  isSeeMore
                                      ? Column(
                                          children: [
                                            SizedBox(
                                              height: 15,
                                              width: 15,
                                              child: CircularProgressIndicator(
                                                strokeWidth: 3,
                                                color: primary,
                                              ),
                                            ),
                                            SizedBox(height: 20.h),
                                          ],
                                        )
                                      : GestureDetector(
                                          onTap: () {
                                            cubit.loadMorePatients(
                                              widget.doctorId,
                                            );
                                          },
                                          child: const Text(
                                            '',
                                          ),
                                        ),
                                ],
                              );
                            },
                          );
                        },
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
