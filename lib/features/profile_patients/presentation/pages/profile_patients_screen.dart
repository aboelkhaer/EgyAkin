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
    Size size = MediaQuery.of(context).size;
    // log(sl<HomeCubit>().isSyndicateCardRequired);
    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
          onTap: () {
            animateToTopOfScreen(cubit.scrollController!);
          },
          child: Text(
            'Dr.${capitalizeFirstText(widget.doctorFirstName)}\'s Patients',
            style: const TextStyle(),
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<ProfilePatientsCubit, ProfilePatientsState>(
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
                      padding: const EdgeInsets.only(
                        left: 20,
                        top: 20,
                        right: 20,
                        bottom: 50,
                      ),
                      itemCount: data.data!.data!.length,
                      itemBuilder: (BuildContext context, int index) {
                        var patient = data.data!.data![index];

                        return PatientCard(
                          patientName: patient.name ?? AppStrings.empty,
                          drFirstName:
                              patient.doctor!.firstName ?? AppStrings.empty,
                          homeDataModel: widget.homeDataModel,
                          doctorId: patient.doctor!.id.toString(),
                          updatedAt: patient.updatedAt ?? AppStrings.empty,
                          accountVerification: widget.accountVerification,
                          drLastName:
                              patient.doctor!.lastName ?? AppStrings.empty,
                          hospital: patient.hospital ?? AppStrings.empty,
                          currentDoctorModel: widget.currentDoctorModel,
                          isSyndicateCardRequired:
                              patient.doctor!.isSyndicateCardRequired!,
                          doctorImage: patient.doctor!.image,
                          isOutcomeStatus: patient.sections!.outcomeStatus!,
                          currentDoctorPoints: widget.currentDoctorPoints,
                          currentDoctorRole: widget.currentDoctorRole,
                          submitStatus: patient.sections == null
                              ? false
                              : patient.sections!.submitStatus ?? false,
                          onOutcomeTap: () {
                            navigatorKey.currentState?.pushNamed(
                              AppRoutes.outcome,
                              arguments: AppRoutesArgs.outcomeRouteArgs(
                                verified: sl<HomeCubit>().accountVerification!,
                                outcomeStatus: patient.sections!.outcomeStatus!,
                                patientName: patient.name.toString(),
                                patientId: patient.id.toString(),
                                currentDoctorModel:
                                    sl<HomeCubit>().currentDoctorModel,
                                doctorId: patient.doctor!.id.toString(),
                                homeDataModel: widget.homeDataModel,
                                isSyndicateCardRequired:
                                    sl<HomeCubit>().isSyndicateCardRequired,
                                currentDoctorRole: widget.currentDoctorRole,
                                currentDoctorPoints: widget.currentDoctorPoints,
                              ),
                            );
                          },
                          onAddCommentTap: () {
                            navigatorKey.currentState?.pushNamed(
                              AppRoutes.comments,
                              arguments: AppRoutesArgs.patientCommentsRouteArgs(
                                patientId: patient.id.toString(),
                                currentDoctorModel:
                                    sl<HomeCubit>().currentDoctorModel,
                                verified: sl<HomeCubit>().accountVerification!,
                                homeDataModel: widget.homeDataModel,
                                currentDoctorRole: widget.currentDoctorRole,
                                patientName: patient.name.toString(),
                                isSyndicateCardRequired:
                                    sl<HomeCubit>().isSyndicateCardRequired,
                                currentDoctorPoints: widget.currentDoctorPoints,
                              ),
                            );
                          },
                          onTap: () {
                            navigatorKey.currentState?.pushNamed(
                              AppRoutes.patientSections,
                              arguments:
                                  AppRoutesArgs.patientSectionsRouteArguments(
                                patientId: patient.id.toString(),
                                currentDoctorModel:
                                    sl<HomeCubit>().currentDoctorModel,
                                currentDoctorPoints: widget.currentDoctorPoints,
                                currentDoctorRole: widget.currentDoctorRole,
                                homeDataModel: widget.homeDataModel,
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
                                cubit.loadMorePatients(widget.doctorId);
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
