import 'package:egy_akin/app/shared/functions/hospital_text.dart';
import 'package:egy_akin/features/all_doctors_patients/presentation/cubit/all_doctors_patients_state.dart';
import 'package:egy_akin/features/all_doctors_patients/presentation/pages/widgets/build_filter_widget.dart';

import '../../../../exports.dart';

class AllDoctorsPatientsScreen extends StatefulWidget {
  final DoctorModel currentDoctorModel;
  final bool accountVerification;
  final String isSyndicateCardRequired;
  final String currentDoctorRole;
  final int currentDoctorPoints;
  final HomeModelResponse homeDataModel;

  const AllDoctorsPatientsScreen(
      {super.key,
      required this.currentDoctorModel,
      required this.accountVerification,
      required this.isSyndicateCardRequired,
      required this.currentDoctorRole,
      required this.currentDoctorPoints,
      required this.homeDataModel});

  @override
  State<AllDoctorsPatientsScreen> createState() =>
      _AllDoctorsPatientsScreenState();
}

class _AllDoctorsPatientsScreenState extends State<AllDoctorsPatientsScreen> {
  AllDoctorsPatientsCubit? _cubit;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _cubit = context.read<AllDoctorsPatientsCubit>();
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
    if (context.read<AllDoctorsPatientsCubit>().isLastPage ||
        context.read<AllDoctorsPatientsCubit>().isLastPageFilter) {
      return;
    } else {
      final maxScroll = context
          .read<AllDoctorsPatientsCubit>()
          .scrollController!
          .position
          .maxScrollExtent;
      final currentScroll = context
          .read<AllDoctorsPatientsCubit>()
          .scrollController!
          .position
          .pixels;
      const threshold = 200.0;
      if (context.read<AllDoctorsPatientsCubit>().isApplyFilterDone) {
        if ((context
                    .read<AllDoctorsPatientsCubit>()
                    .isLoadingMoreForScrollForFilter ==
                false) &&
            maxScroll - currentScroll <= threshold) {
          context
              .read<AllDoctorsPatientsCubit>()
              .isLoadingMoreForScrollForFilter = true;

          context.read<AllDoctorsPatientsCubit>().applyPatientFiltersLoadMore();
        }
      } else {
        if ((context.read<AllDoctorsPatientsCubit>().isLoadingMoreForScroll ==
                false) &&
            maxScroll - currentScroll <= threshold) {
          context.read<AllDoctorsPatientsCubit>().isLoadingMoreForScroll = true;

          context.read<AllDoctorsPatientsCubit>().loadMorePatients();
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    AllDoctorsPatientsCubit cubit = AllDoctorsPatientsCubit.get(context);
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
          onTap: () {
            animateToTopOfScreen(cubit.scrollController!);
          },
          child: Text(
            context.tr(AppStrings.allPatients),
            style: TextStyle(fontSize: 16.sp),
          ),
        ),
        actions: [
          BlocBuilder<AllDoctorsPatientsCubit, AllDoctorsPatientsState>(
            builder: (context, state) {
              return state.maybeWhen(
                orElse: () {
                  return const SizedBox.shrink();
                },
                loaded: (
                  response,
                  isSeeMore,
                  message,
                  isApplyFilterLoading,
                  isApplyFilterLoaded,
                ) {
                  return IconButton(
                    onPressed: () {},
                    icon: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        cubit.totalPatientInFilter == 0
                            ? const SizedBox.shrink()
                            : FadeIn(
                                child: Row(
                                  children: [
                                    Directionality(
                                      textDirection:
                                          context.currentLocale?.languageCode ==
                                                  'ar'
                                              ? TextDirection.rtl
                                              : TextDirection.ltr,
                                      child: Text(
                                        '${response.data!.data!.length} ${context.tr(AppStrings.of)} ${cubit.totalPatientInFilter}',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 9.sp,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
          BlocBuilder<AllDoctorsPatientsCubit, AllDoctorsPatientsState>(
            builder: (context, state) {
              return state.maybeWhen(
                orElse: () {
                  return IconButton(
                    onPressed: () {},
                    icon: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.filter_list),
                        const SizedBox(height: 2),
                        Text(
                          context.tr(AppStrings.filter),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 8.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  );
                },
                loaded: (
                  response,
                  isSeeMore,
                  message,
                  isApplyFilterLoading,
                  isApplyFilterLoaded,
                ) {
                  return IconButton(
                    onPressed: () {
                      showCustomBottomSheet(
                        context: context,
                        isFilter: true,
                        builder: (context) {
                          return BuildFilterWidget(
                            filters: response.filters,
                            cubit: cubit,
                          );
                        },
                      );
                    },
                    icon: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.filter_list),
                        const SizedBox(height: 2),
                        Text(
                          context.tr(AppStrings.filter),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 8.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child:
                BlocBuilder<AllDoctorsPatientsCubit, AllDoctorsPatientsState>(
              builder: (context, state) {
                return state.maybeWhen(
                  orElse: () {
                    return const ShimmerLoadingPatientsCards(
                        ishorizontal: false);
                  },
                  loaded: (
                    response,
                    isSeeMore,
                    message,
                    isApplyFilterLoading,
                    isApplyFilterLoaded,
                  ) {
                    return response.data!.data!.isEmpty
                        ? Center(
                            child: Image.asset(
                              AppImages.notFound,
                              width: 150.h,
                              height: 200.h,
                            ),
                          )
                        : isApplyFilterLoading
                            ? const Center(
                                child: CircularProgressIndicator(),
                              )
                            : ListView.builder(
                                physics: const AlwaysScrollableScrollPhysics(),
                                shrinkWrap: true,
                                controller: cubit.scrollController,
                                scrollDirection: Axis.vertical,
                                padding: EdgeInsets.only(
                                  left: 20,
                                  top: 20,
                                  right: size.width * 0.09,
                                  bottom: 50,
                                ),
                                itemCount: response.data!.data!.length,
                                itemBuilder: (BuildContext context, int index) {
                                  var patient = response.data!.data![index];
                                  return PatientCard(
                                    patientName:
                                        patient.name ?? AppStrings.empty,
                                    drFirstName: patient.doctor!.firstName ??
                                        AppStrings.empty,
                                    isAllDataOpen: false,
                                    homeDataModel: widget.homeDataModel,
                                    accountVerification:
                                        widget.accountVerification,
                                    doctorId: patient.doctor!.id.toString(),
                                    updatedAt:
                                        patient.updatedAt ?? AppStrings.empty,
                                    drLastName: patient.doctor!.lastName ??
                                        AppStrings.empty,
                                    hospital: hospitalText(patient.hospital),
                                    currentDoctorModel:
                                        widget.currentDoctorModel,
                                    currentDoctorPoints:
                                        widget.currentDoctorPoints,
                                    currentDoctorRole: widget.currentDoctorRole,
                                    isSyndicateCardRequired: patient
                                        .doctor!.isSyndicateCardRequired!,
                                    doctorImage: patient.doctor!.image,
                                    isOutcomeStatus:
                                        patient.sections!.outcomeStatus!,
                                    submitStatus: patient.sections == null
                                        ? false
                                        : patient.sections!.submitStatus ??
                                            false,
                                    onOutcomeTap: () {
                                      navigatorKey.currentState?.pushNamed(
                                        AppRoutes.outcome,
                                        arguments:
                                            AppRoutesArgs.outcomeRouteArgs(
                                          verified: widget.accountVerification,
                                          outcomeStatus:
                                              patient.sections!.outcomeStatus!,
                                          patientName: patient.name.toString(),
                                          patientId: patient.id.toString(),
                                          currentDoctorModel:
                                              widget.currentDoctorModel,
                                          doctorId:
                                              patient.doctor!.id.toString(),
                                          isSyndicateCardRequired:
                                              widget.isSyndicateCardRequired,
                                          currentDoctorRole:
                                              widget.currentDoctorRole,
                                          currentDoctorPoints:
                                              widget.currentDoctorPoints,
                                          homeDataModel: widget.homeDataModel,
                                        ),
                                      );
                                    },
                                    onAddCommentTap: () {
                                      navigatorKey.currentState?.pushNamed(
                                        AppRoutes.comments,
                                        arguments: AppRoutesArgs
                                            .patientCommentsRouteArgs(
                                          patientId: patient.id.toString(),
                                          currentDoctorModel:
                                              widget.currentDoctorModel,
                                          verified: widget.accountVerification,
                                          patientName: patient.name.toString(),
                                          currentDoctorPoints:
                                              widget.currentDoctorPoints,
                                          isSyndicateCardRequired:
                                              widget.isSyndicateCardRequired,
                                          currentDoctorRole:
                                              widget.currentDoctorRole,
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
                                          currentDoctorRole:
                                              widget.currentDoctorRole,
                                          homeDataModel: widget.homeDataModel,
                                          isAllDataOpen: false,
                                        ),
                                      );
                                    },
                                  );
                                },
                              );
                  },
                );
              },
            ),
          ),
          SizedBox(height: 10.h),
          BlocBuilder<AllDoctorsPatientsCubit, AllDoctorsPatientsState>(
            builder: (context, state) {
              return state.maybeWhen(
                orElse: () {
                  return const SizedBox.shrink();
                },
                loaded: (
                  response,
                  isSeeMore,
                  message,
                  isApplyFilterLoading,
                  isApplyFilterLoaded,
                ) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      isSeeMore
                          ? Column(
                              children: [
                                const SizedBox(
                                  height: 15,
                                  width: 15,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 3,
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
      floatingActionButton:
          BlocBuilder<AllDoctorsPatientsCubit, AllDoctorsPatientsState>(
        builder: (context, state) {
          return state.maybeWhen(
            orElse: () => const SizedBox.shrink(),
            loaded: (response, isSeeMore, message, isApplyFilterLoading,
                isApplyFilterLoaded) {
              // Show FAB only when filters are applied
              if (cubit.isApplyFilterDone) {
                return FloatingActionButton(
                  onPressed: () {
                    // Clear filters and reload all patients
                    cubit.resetFormData();
                    cubit.isApplyFilterDone = false;
                    cubit.totalPatientInFilter = 0;
                    cubit.getCurrentDoctorPatients();
                  },
                  backgroundColor: AppColors.primary.withOpacity(0.8),
                  child: const Icon(
                    Icons.clear,
                    color: Colors.white,
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          );
        },
      ),
    );
  }
}
