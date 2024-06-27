import 'package:egy_akin/features/all_doctors_patients/presentation/cubit/all_doctors_patients_state.dart';

import '../../../../exports.dart';

class AllDoctorsPatientsScreen extends StatefulWidget {
  final DoctorModel currentDoctorModel;
  final bool accountVerification;
  final String isSyndicateCardRequired;

  const AllDoctorsPatientsScreen(
      {super.key,
      required this.currentDoctorModel,
      required this.accountVerification,
      required this.isSyndicateCardRequired});

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

  // @override
  // void initState() {
  //   super.initState();
  //   context
  //       .read<AllDoctorsPatientsCubit>()
  //       .scrollController
  //       .addListener(_onScroll);
  // }

  void _onScroll() {
    if (context.read<AllDoctorsPatientsCubit>().isLastPage) {
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
      if (context.read<AllDoctorsPatientsCubit>().isLoadingMoreForScroll ==
              false &&
          maxScroll - currentScroll <= threshold) {
        context.read<AllDoctorsPatientsCubit>().isLoadingMoreForScroll = true;

        context.read<AllDoctorsPatientsCubit>().loadMorePatients();
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
          child: const Text(
            AppStrings.allPatients,
            style: TextStyle(),
          ),
        ),
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
                  loaded: (data, isSeeMore) {
                    return ListView.builder(
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
                      itemCount: data.data!.data!.length,
                      itemBuilder: (BuildContext context, int index) {
                        var patient = data.data!.data![index];
                        return PatientCard(
                          patientName: patient.name ?? AppStrings.empty,
                          drFirstName:
                              patient.doctor!.firstName ?? AppStrings.empty,
                          accountVerification: widget.accountVerification,
                          doctorId: patient.doctor!.id.toString(),
                          updatedAt: patient.updatedAt ?? AppStrings.empty,
                          drLastName:
                              patient.doctor!.lastName ?? AppStrings.empty,
                          hospital: patient.hospital ?? AppStrings.empty,
                          currentDoctorModel: widget.currentDoctorModel,
                          isSyndicateCardRequired:
                              patient.doctor!.isSyndicateCardRequired!,
                          doctorImage: patient.doctor!.image,
                          isOutcomeStatus: patient.sections!.outcomeStatus!,
                          submitStatus: patient.sections == null
                              ? false
                              : patient.sections!.submitStatus ?? false,
                          onOutcomeTap: () {
                            navigatorKey.currentState?.pushNamed(
                              AppRoutes.outcome,
                              arguments: AppRoutesArgs.outcomeRouteArgs(
                                verified: widget.accountVerification,
                                outcomeStatus: patient.sections!.outcomeStatus!,
                                patientName: patient.name.toString(),
                                patientId: patient.id.toString(),
                                currentDoctorModel: widget.currentDoctorModel,
                                doctorId: patient.doctor!.id.toString(),
                                isSyndicateCardRequired:
                                    widget.isSyndicateCardRequired,
                              ),
                            );
                          },
                          onAddCommentTap: () {
                            navigatorKey.currentState?.pushNamed(
                              AppRoutes.comments,
                              arguments: AppRoutesArgs.patientCommentsRouteArgs(
                                patientId: patient.id.toString(),
                                currentDoctorModel: widget.currentDoctorModel,
                                verified: widget.accountVerification,
                                patientName: patient.name.toString(),
                                isSyndicateCardRequired:
                                    widget.isSyndicateCardRequired,
                              ),
                            );
                          },
                          onTap: () {
                            navigatorKey.currentState?.pushNamed(
                              AppRoutes.patientSections,
                              arguments:
                                  AppRoutesArgs.patientSectionsRouteArguments(
                                patientId: patient.id.toString(),
                                currentDoctorModel: widget.currentDoctorModel,
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
                loaded: (data, isSeeMore) {
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
                                cubit.loadMorePatients();
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
    );
  }
}
