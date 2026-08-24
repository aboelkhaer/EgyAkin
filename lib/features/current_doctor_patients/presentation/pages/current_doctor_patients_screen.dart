import 'package:egy_akin/features/all_doctors_patients/presentation/pages/widgets/build_filter_widget.dart';
import 'package:egy_akin/features/home/presentation/widgets/dashboard/home_dashboard_shared.dart';
import 'package:egy_akin/features/home/presentation/widgets/patients/home_patient_widgets.dart';
import 'package:egy_akin/features/home/presentation/widgets/patients/home_patients_loading.dart';

import '../../../../exports.dart';

class CurrentDoctorPatientsScreen extends StatefulWidget {
  final DoctorModel currentDoctorModel;
  final bool accountVerification;
  final String isSyndicateCardRequired;
  final String currentDoctorRole;
  final int currentDoctorPoints;
  final HomeModelResponse homeDataModel;
  const CurrentDoctorPatientsScreen(
      {super.key,
      required this.currentDoctorModel,
      required this.accountVerification,
      required this.isSyndicateCardRequired,
      required this.currentDoctorRole,
      required this.currentDoctorPoints,
      required this.homeDataModel});

  @override
  State<CurrentDoctorPatientsScreen> createState() =>
      _CurrentDoctorPatientsScreenState();
}

class _CurrentDoctorPatientsScreenState
    extends State<CurrentDoctorPatientsScreen> {
  CurrentDoctorPatientsCubit? _cubit;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _cubit = context.read<CurrentDoctorPatientsCubit>();

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
    final cubit = context.read<CurrentDoctorPatientsCubit>();

    // Early return conditions in a single check
    if (cubit.isLastPage ||
        cubit.isLoadingMoreForScroll ||
        cubit.scrollController == null) {
      return;
    }

    final position = cubit.scrollController!.position;
    final maxScroll = position.maxScrollExtent;
    final currentScroll = position.pixels;
    const threshold = 200.0;

    // Trigger load more when near bottom
    if (maxScroll - currentScroll <= threshold) {
      cubit.isLoadingMoreForScroll = true;
      cubit.loadMorePatients();
    }
  }

  @override
  Widget build(BuildContext context) {
    CurrentDoctorPatientsCubit cubit = CurrentDoctorPatientsCubit.get(context);

    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        final isDark = themeState is ThemeLoaded && themeState.isDarkMode;
        final primary = HomeDashboardColors.primary(isDark);
        final titleColor = HomeDashboardColors.title(isDark);
        final scaffold = HomeDashboardColors.scaffold(isDark);
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
                _PatientsScreenHeader(
                  isDark: isDark,
                  scaffold: scaffold,
                  primary: primary,
                  titleColor: titleColor,
                  title: context.tr(AppStrings.yourPatients),
                  onBack: () => Navigator.of(context).maybePop(),
                  onTitleTap: () {
                    if (cubit.scrollController != null) {
                      animateToTopOfScreen(cubit.scrollController!);
                    }
                  },
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      BlocBuilder<CurrentDoctorPatientsCubit,
                          CurrentDoctorPatientsState>(
                        builder: (context, state) {
                          return state.maybeWhen(
                            orElse: () => const SizedBox.shrink(),
                            loaded: (
                              response,
                              isSeeMore,
                              message,
                              isApplyFilterLoading,
                              isApplyFilterLoaded,
                              isExportLoading,
                              isExportLoaded,
                              fileUrl,
                              filters,
                              totalPatientInFilter,
                            ) {
                              if (cubit.totalPatientInFilter == 0) {
                                return const SizedBox.shrink();
                              }
                              final shown = response.data?.data?.length ?? 0;
                              return Padding(
                                padding: EdgeInsets.only(right: 4.w),
                                child: FadeIn(
                                  child: Text(
                                    '$shown ${context.tr(AppStrings.of)} ${cubit.totalPatientInFilter}',
                                    style: TextStyle(
                                      color: isDark ? Colors.white70 : muted,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 11.sp,
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                      BlocBuilder<CurrentDoctorPatientsCubit,
                          CurrentDoctorPatientsState>(
                        builder: (context, state) {
                          return state.maybeWhen(
                            orElse: () {
                              return _HeaderIconButton(
                                isDark: isDark,
                                icon: Icons.tune_rounded,
                                onTap: () {},
                              );
                            },
                            loaded: (
                              response,
                              isSeeMore,
                              message,
                              isApplyFilterLoading,
                              isApplyFilterLoaded,
                              isExportLoading,
                              isExportLoaded,
                              fileUrl,
                              filters,
                              totalPatientInFilter,
                            ) {
                              return _HeaderIconButton(
                                isDark: isDark,
                                icon: cubit.isApplyFilterDone
                                    ? Icons.filter_alt_rounded
                                    : Icons.tune_rounded,
                                color: cubit.isApplyFilterDone ? primary : null,
                                onTap: () {
                                  showCustomBottomSheet(
                                    context: context,
                                    isFilter: true,
                                    builder: (context) {
                                      return BuildFilterWidget(
                                        filters: response.filters,
                                        cubit: cubit,
                                        isCurrentDoctor: true,
                                      );
                                    },
                                  );
                                },
                              );
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
        children: [
          Expanded(
            child: BlocBuilder<CurrentDoctorPatientsCubit,
                CurrentDoctorPatientsState>(
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
                  loaded: (
                    data,
                    isSeeMore,
                    message,
                    isApplyFilterLoading,
                    isApplyFilterLoaded,
                    isExportLoading,
                    isExportLoaded,
                    fileUrl,
                    filters,
                    totalPatientInFilter,
                  ) {
                    if (isApplyFilterLoading) {
                      return Center(
                        child: CircularProgressIndicator(color: primary),
                      );
                    }

                    final patients = data.data?.data ?? [];
                    if (patients.isEmpty) {
                      return RefreshIndicator(
                        onRefresh: () async {
                          await cubit.getCurrentDoctorPatients();
                        },
                        color: primary,
                        child: ListView(
                          physics: const AlwaysScrollableScrollPhysics(
                            parent: BouncingScrollPhysics(),
                          ),
                          children: [
                            SizedBox(
                              height: MediaQuery.sizeOf(context).height * 0.62,
                              child: PatientsListEmptyState(
                                isDark: isDark,
                                isFiltered: cubit.isApplyFilterDone,
                                subtitle: cubit.isApplyFilterDone
                                    ? null
                                    : context.tr(
                                        AppStrings.patientsYouAddWillShowUpHere,
                                      ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }

                    return RefreshIndicator(
                      onRefresh: () async {
                        if (cubit.isApplyFilterDone) {
                          await cubit.applyPatientFilters('true');
                        } else {
                          await cubit.getCurrentDoctorPatients();
                        }
                      },
                      color: primary,
                      child: ListView.builder(
                        physics: const AlwaysScrollableScrollPhysics(
                          parent: BouncingScrollPhysics(),
                        ),
                        controller: cubit.scrollController,
                        padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 80.h),
                        itemCount: patients.length,
                        itemBuilder: (BuildContext context, int index) {
                          final patient = patients[index];
                          return Padding(
                            padding: EdgeInsets.only(bottom: 12.h),
                            child: HomePatientCard(
                              isDark: isDark,
                              patient: patient,
                              onOutcomeTap: () {
                                navigatorKey.currentState?.pushNamed(
                                  AppRoutes.outcome,
                                  arguments: AppRoutesArgs.outcomeRouteArgs(
                                    verified: widget.accountVerification,
                                    outcomeStatus:
                                        patient.sections?.outcomeStatus ??
                                            false,
                                    patientName: patient.name.toString(),
                                    patientId: patient.id.toString(),
                                    currentDoctorModel:
                                        widget.currentDoctorModel,
                                    doctorId:
                                        patient.doctor?.id.toString() ?? '',
                                    isSyndicateCardRequired:
                                        widget.isSyndicateCardRequired,
                                    currentDoctorRole: widget.currentDoctorRole,
                                    currentDoctorPoints:
                                        widget.currentDoctorPoints,
                                    homeDataModel: widget.homeDataModel,
                                  ),
                                );
                              },
                              onAddCommentTap: () {
                                navigatorKey.currentState?.pushNamed(
                                  AppRoutes.comments,
                                  arguments:
                                      AppRoutesArgs.patientCommentsRouteArgs(
                                    patientId: patient.id.toString(),
                                    currentDoctorModel:
                                        widget.currentDoctorModel,
                                    verified: widget.accountVerification,
                                    patientName: patient.name.toString(),
                                    currentDoctorPoints:
                                        widget.currentDoctorPoints,
                                    currentDoctorRole: widget.currentDoctorRole,
                                    isSyndicateCardRequired:
                                        widget.isSyndicateCardRequired,
                                    homeDataModel: widget.homeDataModel,
                                  ),
                                );
                              },
                              onTap: () {
                                navigatorKey.currentState?.pushNamed(
                                  AppRoutes.patientSections,
                                  arguments: AppRoutesArgs
                                      .patientSectionsRouteArguments(
                                    patientId: patient.id.toString(),
                                    currentDoctorModel:
                                        widget.currentDoctorModel,
                                    currentDoctorPoints:
                                        widget.currentDoctorPoints,
                                    currentDoctorRole: widget.currentDoctorRole,
                                    homeDataModel: widget.homeDataModel,
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
          BlocBuilder<CurrentDoctorPatientsCubit, CurrentDoctorPatientsState>(
            builder: (context, state) {
              return state.maybeWhen(
                orElse: () {
                  return const SizedBox.shrink();
                },
                loaded: (
                  data,
                  isSeeMore,
                  message,
                  isApplyFilterLoading,
                  isApplyFilterLoaded,
                  isExportLoading,
                  isExportLoaded,
                  fileUrl,
                  filters,
                  totalPatientInFilter,
                ) {
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
                                if (cubit.isApplyFilterDone) {
                                  cubit.applyPatientFiltersLoadMore();
                                } else {
                                  cubit.loadMorePatients();
                                }
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
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          BlocBuilder<CurrentDoctorPatientsCubit, CurrentDoctorPatientsState>(
            builder: (context, state) {
              return state.maybeWhen(
                orElse: () => FloatingActionButton(
                  onPressed: () {
                    // Export patients (filtered or all)
                    cubit.exportFilteredPatients(true);
                  },
                  backgroundColor: primary.withOpacity(0.9),
                  heroTag: 'export',
                  child: const Icon(
                    Icons.download,
                    color: Colors.white,
                  ),
                ),
                loaded: (
                  response,
                  isSeeMore,
                  message,
                  isApplyFilterLoading,
                  isApplyFilterLoaded,
                  isExportLoading,
                  isExportLoaded,
                  fileUrl,
                  filters,
                  totalPatientInFilter,
                ) {
                  if (response.data!.data!.isEmpty) {
                    return const SizedBox.shrink();
                  }
                  // Handle export loaded state - open file URL
                  if (isExportLoaded && fileUrl != null) {
                    WidgetsBinding.instance.addPostFrameCallback((_) async {
                      try {
                        // Open file URL in external browser
                        final Uri url = Uri.parse(fileUrl);
                        if (await canLaunchUrl(url)) {
                          await launchUrl(
                            url,
                            mode: LaunchMode.externalApplication,
                          );
                        } else {
                          // Fallback: show a snackbar or dialog with the URL
                          if (mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  '${context.tr(AppStrings.cannotOpenUrl)}: $fileUrl',
                                ),
                                action: SnackBarAction(
                                  label: context.tr(AppStrings.copyUrl),
                                  onPressed: () {
                                    // Copy URL to clipboard
                                    Clipboard.setData(
                                        ClipboardData(text: fileUrl));
                                  },
                                ),
                              ),
                            );
                          }
                        }
                      } catch (e) {
                        // Handle any errors
                        if (mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                '${context.tr(AppStrings.errorOpeningFile)}: $e',
                              ),
                              action: SnackBarAction(
                                label: context.tr(AppStrings.copyUrl),
                                onPressed: () {
                                  // Copy URL to clipboard
                                  Clipboard.setData(
                                      ClipboardData(text: fileUrl));
                                },
                              ),
                            ),
                          );
                        }
                      } finally {
                        // Reset export loaded state
                        cubit.resetExportState();
                      }
                    });
                  }

                  return FloatingActionButton(
                    onPressed: isExportLoading
                        ? null
                        : () {
                            // Export patients (filtered or all)
                            cubit.exportFilteredPatients(true);
                          },
                    backgroundColor: primary.withOpacity(0.9),
                    heroTag: 'export',
                    child: isExportLoading
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                          )
                        : const Icon(
                            Icons.download,
                            color: Colors.white,
                          ),
                  );
                },
              );
            },
          ),
          // Show clear button only when filters are applied
          BlocBuilder<CurrentDoctorPatientsCubit, CurrentDoctorPatientsState>(
            builder: (context, state) {
              return state.maybeWhen(
                orElse: () => const SizedBox.shrink(),
                loaded: (
                  response,
                  isSeeMore,
                  message,
                  isApplyFilterLoading,
                  isApplyFilterLoaded,
                  isExportLoading,
                  isExportLoaded,
                  fileUrl,
                  filters,
                  totalPatientInFilter,
                ) {
                  if (cubit.isApplyFilterDone) {
                    return Column(
                      children: [
                        const SizedBox(height: 16),
                        FloatingActionButton(
                          onPressed: () {
                            // Clear filters and reload all patients
                            cubit.resetFormData();
                            cubit.isApplyFilterDone = false;
                            cubit.totalPatientInFilter = 0;
                            cubit.getCurrentDoctorPatients();
                          },
                          backgroundColor: primary.withOpacity(0.9),
                          heroTag: 'clear',
                          child: const Icon(
                            Icons.clear,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    );
                  }
                  return const SizedBox.shrink();
                },
              );
            },
          ),
        ],
      ),
          ),
        );
      },
    );
  }
}

class _PatientsScreenHeader extends StatelessWidget {
  final bool isDark;
  final Color scaffold;
  final Color primary;
  final Color titleColor;
  final String title;
  final VoidCallback onBack;
  final VoidCallback onTitleTap;
  final Widget trailing;

  const _PatientsScreenHeader({
    required this.isDark,
    required this.scaffold,
    required this.primary,
    required this.titleColor,
    required this.title,
    required this.onBack,
    required this.onTitleTap,
    required this.trailing,
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
          padding: EdgeInsets.fromLTRB(14.w, 4.h, 10.w, 12.h),
          child: Row(
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
                            : const Color(0xFFE6E2F0),
                      ),
                    ),
                    child: Icon(
                      Icons.arrow_back_ios_new_rounded,
                      size: 16.sp,
                      color: isDark ? Colors.white : const Color(0xFF1F2937),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: GestureDetector(
                  onTap: onTitleTap,
                  child: Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w800,
                      color: isDark ? Colors.white : titleColor,
                      letterSpacing: -0.2,
                    ),
                  ),
                ),
              ),
              trailing,
            ],
          ),
        ),
      ),
    );
  }
}

class _HeaderIconButton extends StatelessWidget {
  final bool isDark;
  final IconData icon;
  final VoidCallback onTap;
  final Color? color;

  const _HeaderIconButton({
    required this.isDark,
    required this.icon,
    required this.onTap,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final fg = color ??
        (isDark ? Colors.white : const Color(0xFF1F2937));

    return Material(
      color: isDark ? const Color(0xFF2A2733) : Colors.white,
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
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
          child: Icon(icon, size: 18.sp, color: fg),
        ),
      ),
    );
  }
}
