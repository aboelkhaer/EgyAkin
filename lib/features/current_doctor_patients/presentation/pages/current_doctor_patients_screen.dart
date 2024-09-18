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
    if (context.read<CurrentDoctorPatientsCubit>().isLastPage) {
      return;
    } else {
      final maxScroll = context
          .read<CurrentDoctorPatientsCubit>()
          .scrollController!
          .position
          .maxScrollExtent;
      final currentScroll = context
          .read<CurrentDoctorPatientsCubit>()
          .scrollController!
          .position
          .pixels;
      const threshold = 200.0;
      if (context.read<CurrentDoctorPatientsCubit>().isLoadingMoreForScroll ==
              false &&
          maxScroll - currentScroll <= threshold) {
        context.read<CurrentDoctorPatientsCubit>().isLoadingMoreForScroll =
            true;

        context.read<CurrentDoctorPatientsCubit>().loadMorePatients();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    CurrentDoctorPatientsCubit cubit = CurrentDoctorPatientsCubit.get(context);
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
          onTap: () {
            animateToTopOfScreen(cubit.scrollController!);
          },
          child: const Text(
            AppStrings.yourPatients,
            style: TextStyle(),
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<CurrentDoctorPatientsCubit,
                CurrentDoctorPatientsState>(
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
                          isAllDataOpen: false,
                          doctorId: patient.doctor!.id.toString(),
                          homeDataModel: widget.homeDataModel,
                          updatedAt: patient.updatedAt ?? AppStrings.empty,
                          drLastName:
                              patient.doctor!.lastName ?? AppStrings.empty,
                          currentDoctorPoints: widget.currentDoctorPoints,
                          accountVerification: widget.accountVerification,
                          currentDoctorModel: widget.currentDoctorModel,
                          hospital: patient.hospital ?? AppStrings.empty,
                          isSyndicateCardRequired:
                              patient.doctor!.isSyndicateCardRequired!,
                          currentDoctorRole: widget.currentDoctorRole,
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
                                currentDoctorRole: widget.currentDoctorRole,
                                currentDoctorPoints: widget.currentDoctorPoints,
                                homeDataModel: widget.homeDataModel,
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
                                currentDoctorPoints: widget.currentDoctorPoints,
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
                              arguments:
                                  AppRoutesArgs.patientSectionsRouteArguments(
                                patientId: patient.id.toString(),
                                currentDoctorModel: widget.currentDoctorModel,
                                currentDoctorPoints: widget.currentDoctorPoints,
                                currentDoctorRole: widget.currentDoctorRole,
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
          BlocBuilder<CurrentDoctorPatientsCubit, CurrentDoctorPatientsState>(
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
