import 'package:flutter/scheduler.dart';
import 'package:egy_akin/features/home/data/models/home_dashboard_fake_data.dart';
import 'package:egy_akin/features/home/presentation/widgets/dashboard/home_consultations_section.dart';
import 'package:egy_akin/features/home/presentation/widgets/dashboard/home_dashboard_shared.dart';
import 'package:egy_akin/features/home/presentation/widgets/dashboard/home_email_verification_banner.dart';
import 'package:egy_akin/features/home/presentation/widgets/dashboard/home_syndicate_card_banner.dart';
import 'package:egy_akin/features/home/presentation/widgets/dashboard/home_network_insights_section.dart';
import 'package:egy_akin/features/home/presentation/widgets/dashboard/home_outcomes_section.dart';
import 'package:egy_akin/features/home/presentation/widgets/dashboard/home_patients_section.dart';
import 'package:egy_akin/features/home/presentation/widgets/dashboard/home_resume_drafts_section.dart';
import 'package:egy_akin/features/home/presentation/widgets/dashboard/home_search_field.dart';
import 'package:egy_akin/features/home/presentation/widgets/dashboard/home_stats_section.dart';
import 'package:egy_akin/features/home/presentation/widgets/dashboard/home_tab_loading.dart';
import 'package:egy_akin/features/home/presentation/widgets/dashboard/home_tools_section.dart';
import 'package:egy_akin/features/home/presentation/widgets/dashboard/home_week_summary_section.dart';

import '../../../../exports.dart';

class HomeTab extends StatefulWidget {
  final HomeCubit cubit;
  const HomeTab({
    super.key,
    required this.cubit,
  });

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  late final HomeCubit homeCubit;
  bool _pinScrollAfterLoad = false;

  void _pinHomeScrollToTop() {
    void jump() {
      if (!mounted) return;
      widget.cubit.resetHomeTabScrollToTop();
    }

    jump();
    WidgetsBinding.instance.addPostFrameCallback((_) => jump());
  }

  @override
  void initState() {
    super.initState();
    homeCubit = context.read<HomeCubit>();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      _pinHomeScrollToTop();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _openSearch({
    required DoctorModel currentDoctorModel,
    required HomeModelResponse homeData,
  }) {
    navigatorKey.currentState?.pushNamed(
      AppRoutes.search,
      arguments: AppRoutesArgs.searchRouteArgs(
        currentDoctorModel: currentDoctorModel,
        verified: homeData.verified ?? false,
        isSyndicateCardRequired: homeData.isSyndicateCardRequired ?? '',
        currentDoctorRole: homeData.role.toString(),
        currentDoctorPoints: int.tryParse(homeData.scoreValue ?? '0') ?? 0,
        homeDataModel: homeData,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        final isDarkMode = themeState is ThemeLoaded && themeState.isDarkMode;
        final primary =
            isDarkMode ? AppColors.darkPrimary : AppColors.primary;

        return Container(
          color: HomeDashboardColors.scaffold(isDarkMode),
          child: BlocConsumer<HomeCubit, HomeState>(
            listener: (context, state) {
              state.maybeWhen(
                orElse: () {},
                loading: (_) {
                  _pinScrollAfterLoad = true;
                  _pinHomeScrollToTop();
                },
                loaded: (
                  _,
                  __,
                  ___,
                  ____,
                  _____,
                  ______,
                  _______,
                  ________,
                  _________,
                  __________,
                ) {
                  if (_pinScrollAfterLoad) {
                    _pinScrollAfterLoad = false;
                    _pinHomeScrollToTop();
                  }
                },
                error: (message) {
                  _pinScrollAfterLoad = false;
                  customSnackBar(message: message, context: context);

                  if (message == 'Unauthenticated.') {
                    SchedulerBinding.instance.addPostFrameCallback((_) {
                      context.read<HomeCubit>().signOutForUnUnauthenticated();
                      navigatorKey.currentState
                          ?.pushReplacementNamed(AppRoutes.signIn);
                    });
                  }
                },
              );
            },
            builder: (context, state) {
              final showLoadingSkeleton = state.maybeWhen(
                initial: () => true,
                loading: (_) => true,
                orElse: () => false,
              );
              // Keep the previous dashboard mounted (invisible) while the
              // skeleton shows so scroll extent does not jump mid-page.
              final hasCachedDashboard =
                  widget.cubit.homeDataModel.data != null;

              final homeData = state.maybeWhen(
                loaded: (data, _, __, ___, ____, _____, ______, _______,
                        ________, _________) =>
                    data,
                orElse: () => widget.cubit.homeDataModel,
              );
              final currentDoctor = state.maybeWhen(
                loaded: (_, doctor, __, ___, ____, _____, ______, _______,
                        ________, _________) =>
                    doctor,
                orElse: () => widget.cubit.currentDoctorModel,
              );

              final dashboard = Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w) +
                      EdgeInsets.only(top: 6.h, bottom: 16.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      HomeSearchField(
                        isDark: isDarkMode,
                        onTap: () {
                          _openSearch(
                            currentDoctorModel: currentDoctor,
                            homeData: homeData,
                          );
                        },
                      ),
                      SizedBox(height: 12.h),
                      Builder(
                        builder: (context) {
                          final emailVerified = isDoctorEmailVerified(
                            doctor: currentDoctor,
                            homeData: homeData,
                          );
                          final bannerDismissed =
                              homeCubit.isExistVerificationBanner ==
                                  true;

                          if (!emailVerified && !bannerDismissed) {
                            return Padding(
                              padding: EdgeInsets.only(bottom: 12.h),
                              child: HomeEmailVerificationBanner(
                                isDark: isDarkMode,
                                currentDoctorModel: currentDoctor,
                                onDismiss: () {
                                  homeCubit.setVerifyBanner();
                                },
                                onVerify: () {
                                  navigatorKey.currentState?.pushNamed(
                                    AppRoutes.emailVerification,
                                    arguments: AppRoutesArgs
                                        .emailVerificationRouteArgs(
                                      currentDoctorModel:
                                          currentDoctor,
                                    ),
                                  );
                                },
                              ),
                            );
                          }

                          final showSyndicate =
                              needsSyndicateCardVerification(
                            doctor: currentDoctor,
                            homeData: homeData,
                          );
                          if (!showSyndicate) {
                            return const SizedBox.shrink();
                          }

                          final isUploadingSyndicate =
                              state.maybeWhen(
                            loaded: (_, __, ___, ____, uploading, _____,
                                    ______, _______, ________,
                                    _________) =>
                                uploading,
                            orElse: () => false,
                          );

                          return Padding(
                            padding: EdgeInsets.only(bottom: 12.h),
                            child: HomeSyndicateCardBanner(
                              isDark: isDarkMode,
                              isPending:
                                  isSyndicateCardPending(homeData),
                              isUploading: isUploadingSyndicate,
                              onDismiss: null,
                              onUpload: () {
                                homeCubit.uploadSyndicateCard();
                              },
                            ),
                          );
                        },
                      ),
                      HomeStatsSection(
                        isDark: isDarkMode,
                        myPatientsCount: int.tryParse(
                              homeData.doctorPatientCount ?? '',
                            ) ??
                            0,
                        myPatientsDelta:
                            homeData.data?.weekRecap?.patientsAdded ?? 0,
                        allPatientsCount: int.tryParse(
                              homeData.allPatientCount ?? '',
                            ) ??
                            0,
                        allPatientsDelta:
                            homeData.data?.weekRecap?.allPatientsAdded ?? 0,
                        score: int.tryParse(homeData.scoreValue ?? '') ?? 0,
                        scoreDelta: homeData.data?.weekRecap?.pointsEarned ?? 0,
                      ),
                      SizedBox(height: 10.h),
                      Builder(
                        builder: (context) {
                          final drafts = homeData.data?.drafts ??
                              const <PatientHomeDataModel>[];
                          final draftCount = int.tryParse(
                                homeData.draftCount ?? '',
                              ) ??
                              0;
                          final showDrafts =
                              drafts.isNotEmpty || draftCount > 0;
                          final outcomes =
                              homeData.data?.pendingOutcomes ??
                                  const <PatientHomeDataModel>[];
                          final outcomeCount = int.tryParse(
                                homeData.pendingOutcomeCount ?? '',
                              ) ??
                              0;
                          final showOutcomes =
                              outcomes.isNotEmpty || outcomeCount > 0;

                          return Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.stretch,
                            children: [
                              DoctorsActivation(isDark: isDarkMode),
                              if (showDrafts) ...[
                                SizedBox(height: 12.h),
                                HomeResumeDraftsSection(
                                  isDark: isDarkMode,
                                  drafts: drafts,
                                  draftCount: draftCount > 0
                                      ? draftCount
                                      : drafts.length,
                                  onViewAll: () {
                                    widget.cubit.openMyPatientsDrafts();
                                  },
                                  onResume: (patient) {
                                    navigatorKey.currentState
                                        ?.pushNamed(
                                      AppRoutes.patientSections,
                                      arguments: AppRoutesArgs
                                          .patientSectionsRouteArguments(
                                        patientId:
                                            patient.id.toString(),
                                        currentDoctorModel:
                                            currentDoctor,
                                        currentDoctorPoints:
                                            int.tryParse(
                                                  homeData.scoreValue ??
                                                      '0',
                                                ) ??
                                                0,
                                        currentDoctorRole:
                                            homeData.role.toString(),
                                        homeDataModel: homeData,
                                        isAllDataOpen: false,
                                      ),
                                    );
                                  },
                                ),
                              ],
                              if (showOutcomes) ...[
                                SizedBox(height: 14.h),
                                HomeOutcomesSection(
                                  isDark: isDarkMode,
                                  outcomes: outcomes,
                                  badgeCount: outcomeCount,
                                  onViewAll: () {
                                    widget.cubit
                                        .openMyPatientsWithoutOutcome();
                                  },
                                  onAddOutcome: (patient) {
                                    final patientId =
                                        patient.id?.toString();
                                    if (patientId == null ||
                                        patientId.isEmpty) {
                                      return;
                                    }
                                    navigatorKey.currentState
                                        ?.pushNamed(
                                      AppRoutes.outcome,
                                      arguments: AppRoutesArgs
                                          .outcomeRouteArgs(
                                        verified:
                                            homeData.verified ?? false,
                                        outcomeStatus: false,
                                        patientName:
                                            patient.name?.toString() ??
                                                '',
                                        patientId: patientId,
                                        currentDoctorModel:
                                            currentDoctor,
                                        doctorId: patient.doctor?.id
                                                ?.toString() ??
                                            currentDoctor.id
                                                .toString(),
                                        isSyndicateCardRequired:
                                            homeData
                                                    .isSyndicateCardRequired ??
                                                '',
                                        homeDataModel: homeData,
                                        currentDoctorPoints:
                                            int.tryParse(
                                                  homeData.scoreValue ??
                                                      '0',
                                                ) ??
                                                0,
                                        currentDoctorRole:
                                            homeData.role.toString(),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ],
                          );
                        },
                      ),
                      HomeConsultationsSection(
                        isDark: isDarkMode,
                        currentDoctorModel: currentDoctor,
                        homeDataModel: homeData,
                        reloadToken: state.maybeWhen(
                          loaded: (_, __, ___, ____, _____, ______, _______,
                                  ________, _________, changesCounter) =>
                              changesCounter,
                          orElse: () => 0,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      HomePatientsSection(
                        isDark: isDarkMode,
                        myPatients:
                            homeData.data?.currentPatients ?? const [],
                        allPatients:
                            homeData.data?.allPatients ?? const [],
                        onSeeAll: () {
                          widget.cubit.jumpToPatientsTab();
                        },
                        onPatientTap:
                            (patient, {required isAllDataOpen}) {
                          final patientId = patient.id?.toString();
                          if (patientId == null || patientId.isEmpty) {
                            return;
                          }
                          navigatorKey.currentState?.pushNamed(
                            AppRoutes.patientSections,
                            arguments: AppRoutesArgs
                                .patientSectionsRouteArguments(
                              patientId: patientId,
                              currentDoctorModel: currentDoctor,
                              currentDoctorPoints: int.tryParse(
                                    homeData.scoreValue ?? '0',
                                  ) ??
                                  0,
                              currentDoctorRole:
                                  homeData.role.toString(),
                              homeDataModel: homeData,
                              isAllDataOpen: isAllDataOpen,
                            ),
                          );
                        },
                        onOutcomeTap:
                            (patient, {required isAllDataOpen}) {
                          final patientId = patient.id?.toString();
                          if (patientId == null || patientId.isEmpty) {
                            return;
                          }
                          navigatorKey.currentState?.pushNamed(
                            AppRoutes.outcome,
                            arguments: AppRoutesArgs.outcomeRouteArgs(
                              verified: homeData.verified ?? false,
                              outcomeStatus: patient
                                      .sections?.outcomeStatus ??
                                  false,
                              patientName:
                                  patient.name?.toString() ?? '',
                              patientId: patientId,
                              currentDoctorModel: currentDoctor,
                              doctorId: patient.doctor?.id
                                      ?.toString() ??
                                  currentDoctor.id.toString(),
                              isSyndicateCardRequired: homeData
                                      .isSyndicateCardRequired ??
                                  '',
                              homeDataModel: homeData,
                              currentDoctorPoints: int.tryParse(
                                    homeData.scoreValue ?? '0',
                                  ) ??
                                  0,
                              currentDoctorRole:
                                  homeData.role.toString(),
                            ),
                          );
                        },
                        onAddCommentTap:
                            (patient, {required isAllDataOpen}) {
                          final patientId = patient.id?.toString();
                          if (patientId == null || patientId.isEmpty) {
                            return;
                          }
                          navigatorKey.currentState?.pushNamed(
                            AppRoutes.comments,
                            arguments: AppRoutesArgs
                                .patientCommentsRouteArgs(
                              patientId: patientId,
                              currentDoctorModel: currentDoctor,
                              verified: homeData.verified ?? false,
                              patientName:
                                  patient.name?.toString() ?? '',
                              currentDoctorPoints: int.tryParse(
                                    homeData.scoreValue ?? '0',
                                  ) ??
                                  0,
                              homeDataModel: homeData,
                              isSyndicateCardRequired: homeData
                                      .isSyndicateCardRequired ??
                                  '',
                              currentDoctorRole:
                                  homeData.role.toString(),
                            ),
                          );
                        },
                      ),
                      SizedBox(height: 8.h),
                      HomeToolsSection(
                        isDark: isDarkMode,
                        tools: HomeDashboardFakeData.tools,
                        currentDoctorModel: currentDoctor,
                        homeDataModel: homeData,
                      ),
                      if (homeData.data?.weekRecap != null) ...[
                        SizedBox(height: 14.h),
                        HomeWeekSummarySection(
                          isDark: isDarkMode,
                          summary: homeData.data!.weekRecap!,
                        ),
                      ],
                      if ((homeData.data?.researchInsights ??
                              homeData.researchInsights) !=
                          null) ...[
                        SizedBox(height: 14.h),
                        HomeNetworkInsightsSection(
                          isDark: isDarkMode,
                          insights: homeData.data?.researchInsights ??
                              homeData.researchInsights!,
                        ),
                      ],
                    ],
                  ),
                )
;

              return RefreshIndicator(
                color: primary,
                displacement: 40,
                onRefresh: () async {
                  _pinHomeScrollToTop();
                  if (widget.cubit.isUnreadNotification) {
                    context.read<NotificationCubit>().getAllNotifications();
                  }
                  await widget.cubit.getHome(showLoading: true);
                },
                child: SingleChildScrollView(
                  key: ValueKey(
                    'home_tab_scroll_${widget.cubit.homeScrollEpoch}',
                  ),
                  controller: widget.cubit.homeTabScrollController,
                  physics: const AlwaysScrollableScrollPhysics(
                    parent: BouncingScrollPhysics(),
                  ),
                  child: Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      if (!showLoadingSkeleton || hasCachedDashboard)
                        Opacity(
                          opacity: showLoadingSkeleton ? 0 : 1,
                          child: IgnorePointer(
                            ignoring: showLoadingSkeleton,
                            child: dashboard,
                          ),
                        ),
                      if (showLoadingSkeleton)
                        HomeTabLoading(isDark: isDarkMode),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
