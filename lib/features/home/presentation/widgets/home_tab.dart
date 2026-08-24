import 'package:flutter/scheduler.dart';
import 'package:egy_akin/features/home/data/models/home_dashboard_fake_data.dart';
import 'package:egy_akin/features/home/presentation/widgets/dashboard/home_consultations_section.dart';
import 'package:egy_akin/features/home/presentation/widgets/dashboard/home_dashboard_shared.dart';
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

  @override
  void initState() {
    super.initState();
    homeCubit = context.read<HomeCubit>();
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
                error: (message) {
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

              return RefreshIndicator(
                color: primary,
                displacement: 40,
                onRefresh: () async {
                  final scroll = widget.cubit.homeTabScrollController;
                  if (scroll.hasClients) {
                    scroll.jumpTo(0);
                  }

                  if (widget.cubit.isUnreadNotification) {
                    context.read<NotificationCubit>().getAllNotifications();
                  }
                  await widget.cubit.getHome(showLoading: true);

                  // Content height changes after reload; pin back to top.
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    if (!mounted) return;
                    final c = widget.cubit.homeTabScrollController;
                    if (c.hasClients && c.offset != 0) {
                      c.jumpTo(0);
                    }
                  });
                },
                child: SingleChildScrollView(
                  key: const PageStorageKey('home_tab_scroll'),
                  controller: widget.cubit.homeTabScrollController,
                  physics: const AlwaysScrollableScrollPhysics(
                    parent: BouncingScrollPhysics(),
                  ),
                  child: showLoadingSkeleton
                      ? HomeTabLoading(isDark: isDarkMode)
                      : Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.w) +
                              EdgeInsets.only(top: 6.h, bottom: 16.h),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              HomeSearchField(
                                isDark: isDarkMode,
                                onTap: () {
                                  state.maybeWhen(
                                    loaded: (
                                      homeData,
                                      currentDoctorModel,
                                      _,
                                      __,
                                      ___,
                                      ____,
                                      _____,
                                      ______,
                                      _______,
                                      ________,
                                    ) {
                                      _openSearch(
                                        currentDoctorModel: currentDoctorModel,
                                        homeData: homeData,
                                      );
                                    },
                                    orElse: () {},
                                  );
                                },
                              ),
                              SizedBox(height: 12.h),
                              HomeStatsSection(
                                isDark: isDarkMode,
                                stats: HomeDashboardFakeData.stats,
                              ),
                              SizedBox(height: 10.h),
                              HomeUpdatedLabel(
                                isDark: isDarkMode,
                                label: context.tr(AppStrings.updatedJustNow),
                              ),
                              Builder(
                                builder: (context) {
                                  final homeData = widget.cubit.homeDataModel;
                                  final currentPatients =
                                      homeData.data?.currentPatients ??
                                          const <PatientHomeDataModel>[];
                                  final drafts = currentPatients
                                      .where(
                                        (patient) =>
                                            patient.sections?.submitStatus !=
                                            true,
                                      )
                                      .toList();
                                  final draftCount = int.tryParse(
                                        homeData.draftCount ?? '',
                                      ) ??
                                      0;
                                  final showDrafts = drafts.isNotEmpty;
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
                                      if (showDrafts) ...[
                                        SizedBox(height: 12.h),
                                        HomeResumeDraftsSection(
                                          isDark: isDarkMode,
                                          drafts: drafts,
                                          draftCount: draftCount > 0
                                              ? draftCount
                                              : drafts.length,
                                          onResume: (patient) {
                                            navigatorKey.currentState
                                                ?.pushNamed(
                                              AppRoutes.patientSections,
                                              arguments: AppRoutesArgs
                                                  .patientSectionsRouteArguments(
                                                patientId:
                                                    patient.id.toString(),
                                                currentDoctorModel: widget
                                                    .cubit.currentDoctorModel,
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
                                                // Pending outcomes → fill form.
                                                outcomeStatus: false,
                                                patientName:
                                                    patient.name?.toString() ??
                                                        '',
                                                patientId: patientId,
                                                currentDoctorModel: widget
                                                    .cubit.currentDoctorModel,
                                                doctorId: patient.doctor?.id
                                                        ?.toString() ??
                                                    widget.cubit
                                                        .currentDoctorModel.id
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
                                      SizedBox(height: 14.h),
                                    ],
                                  );
                                },
                              ),
                              HomeConsultationsSection(
                                isDark: isDarkMode,
                                consultations:
                                    HomeDashboardFakeData.consultations,
                              ),
                              SizedBox(height: 8.h),
                              HomePatientsSection(
                                isDark: isDarkMode,
                                myPatients: widget.cubit.homeDataModel.data
                                        ?.currentPatients ??
                                    const [],
                                allPatients: widget.cubit.homeDataModel.data
                                        ?.allPatients ??
                                    const [],
                                myPatientsCount: int.tryParse(
                                      widget.cubit.homeDataModel
                                              .doctorPatientCount ??
                                          '',
                                    ) ??
                                    (widget.cubit.homeDataModel.data
                                            ?.currentPatients?.length ??
                                        0),
                                allPatientsCount: int.tryParse(
                                      widget
                                              .cubit
                                              .homeDataModel
                                              .allPatientCount ??
                                          '',
                                    ) ??
                                    (widget.cubit.homeDataModel.data
                                            ?.allPatients?.length ??
                                        0),
                                onSeeAll: () {
                                  widget.cubit.tabsController.jumpToTab(1);
                                  widget.cubit.hideHomeHeader(1);
                                },
                                onPatientTap:
                                    (patient, {required isAllDataOpen}) {
                                  final homeData = widget.cubit.homeDataModel;
                                  final patientId = patient.id?.toString();
                                  if (patientId == null || patientId.isEmpty) {
                                    return;
                                  }
                                  navigatorKey.currentState?.pushNamed(
                                    AppRoutes.patientSections,
                                    arguments: AppRoutesArgs
                                        .patientSectionsRouteArguments(
                                      patientId: patientId,
                                      currentDoctorModel:
                                          widget.cubit.currentDoctorModel,
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
                                  final homeData = widget.cubit.homeDataModel;
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
                                      currentDoctorModel:
                                          widget.cubit.currentDoctorModel,
                                      doctorId: patient.doctor?.id
                                              ?.toString() ??
                                          widget.cubit.currentDoctorModel.id
                                              .toString(),
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
                                  final homeData = widget.cubit.homeDataModel;
                                  final patientId = patient.id?.toString();
                                  if (patientId == null || patientId.isEmpty) {
                                    return;
                                  }
                                  navigatorKey.currentState?.pushNamed(
                                    AppRoutes.comments,
                                    arguments: AppRoutesArgs
                                        .patientCommentsRouteArgs(
                                      patientId: patientId,
                                      currentDoctorModel:
                                          widget.cubit.currentDoctorModel,
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
                                currentDoctorModel:
                                    widget.cubit.currentDoctorModel,
                                homeDataModel: widget.cubit.homeDataModel,
                              ),
                              if (widget.cubit.homeDataModel.data?.weekRecap !=
                                  null) ...[
                                SizedBox(height: 14.h),
                                HomeWeekSummarySection(
                                  isDark: isDarkMode,
                                  summary: widget
                                      .cubit.homeDataModel.data!.weekRecap!,
                                ),
                              ],
                              if ((widget.cubit.homeDataModel.data
                                          ?.researchInsights ??
                                      widget.cubit.homeDataModel
                                          .researchInsights) !=
                                  null) ...[
                                SizedBox(height: 14.h),
                                HomeNetworkInsightsSection(
                                  isDark: isDarkMode,
                                  insights: widget.cubit.homeDataModel.data
                                          ?.researchInsights ??
                                      widget.cubit.homeDataModel
                                          .researchInsights!,
                                ),
                              ],
                            ],
                          ),
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
