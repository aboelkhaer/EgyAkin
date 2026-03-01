import '../../../../exports.dart';
import '../cubit/marked_patients_cubit.dart';
import '../cubit/marked_patients_state.dart';

class MarkedPatientsScreen extends StatefulWidget {
  final DoctorModel currentDoctorModel;
  final HomeModelResponse homeDataModel;

  const MarkedPatientsScreen({
    super.key,
    required this.currentDoctorModel,
    required this.homeDataModel,
  });

  @override
  State<MarkedPatientsScreen> createState() => _MarkedPatientsScreenState();
}

class _MarkedPatientsScreenState extends State<MarkedPatientsScreen> {
  MarkedPatientsCubit? _cubit;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _cubit = context.read<MarkedPatientsCubit>();
      if (!_cubit!.isClosed) {
        _cubit!.scrollController = ScrollController();
        _cubit!.scrollController!.addListener(_onScroll);
        _cubit!.getMarkedPatients();
      }
    });
  }

  @override
  void dispose() {
    if (_cubit != null && !_cubit!.isClosed) {
      _cubit!.scrollController?.dispose();
    }
    super.dispose();
  }

  void _onScroll() {
    final cubit = context.read<MarkedPatientsCubit>();

    if (cubit.isLastPage ||
        cubit.isLoadingMoreForScroll ||
        cubit.scrollController == null) {
      return;
    }

    final position = cubit.scrollController!.position;
    final maxScroll = position.maxScrollExtent;
    final currentScroll = position.pixels;
    const threshold = 200.0;

    if (maxScroll - currentScroll <= threshold) {
      cubit.isLoadingMoreForScroll = true;
      cubit.loadMoreMarkedPatients();
    }
  }

  @override
  Widget build(BuildContext context) {
    MarkedPatientsCubit cubit = MarkedPatientsCubit.get(context);
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
          onTap: () {
            if (cubit.scrollController != null) {
              animateToTopOfScreen(cubit.scrollController!);
            }
          },
          child: Text(
            'Marked Patients', // TODO: Add to AppStrings
            style: TextStyle(fontSize: 16.sp),
          ),
        ),
      ),
      body: BlocConsumer<MarkedPatientsCubit, MarkedPatientsState>(
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
                    return const ShimmerLoadingPatientsCards(
                        ishorizontal: false);
                  },
                  loading: () {
                    // return ShimmerLoadingPatientsCards(
                    //   ishorizontal: false,
                    //   numberOfShimmer: int.parse(
                    //       widget.homeDataModel.markedPatientsCount ?? '0'),
                    // );
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                  loaded: (response, isSeeMore) {
                    if (response.data?.data == null ||
                        response.data!.data!.isEmpty) {
                      return Center(
                        child: Image.asset(
                          AppImages.notFound,
                          width: 150.h,
                          height: 200.h,
                        ),
                      );
                    }

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
                      itemCount: response.data!.data!.length,
                      itemBuilder: (BuildContext context, int index) {
                        var patient = response.data!.data![index];
                        return PatientCard(
                          patientName: patient.name ?? AppStrings.empty,
                          drFirstName:
                              patient.doctor?.firstName ?? AppStrings.empty,
                          isAllDataOpen: false,
                          doctorId: patient.doctor?.id.toString() ?? '',
                          homeDataModel: widget.homeDataModel,
                           width: 300.w,
                          updatedAt: patient.updatedAt ?? AppStrings.empty,
                          drLastName:
                              patient.doctor?.lastName ?? AppStrings.empty,
                          currentDoctorPoints:
                              int.parse(widget.homeDataModel.scoreValue!),
                          accountVerification:
                              widget.homeDataModel.verified ?? false,
                          currentDoctorModel: widget.currentDoctorModel,
                          hospital: patient.hospital ?? AppStrings.empty,
                          isSyndicateCardRequired: patient
                                  .doctor?.isSyndicateCardRequired
                                  ?.toString() ??
                              '',
                          currentDoctorRole:
                              widget.homeDataModel.role.toString(),
                          doctorImage: patient.doctor?.image,
                          isOutcomeStatus:
                              patient.sections?.outcomeStatus ?? false,
                          submitStatus: patient.sections?.submitStatus ?? false,
                          onOutcomeTap: () {
                            navigatorKey.currentState?.pushNamed(
                              AppRoutes.outcome,
                              arguments: AppRoutesArgs.outcomeRouteArgs(
                                verified:
                                    widget.homeDataModel.verified ?? false,
                                outcomeStatus:
                                    patient.sections?.outcomeStatus ?? false,
                                patientName: patient.name.toString(),
                                patientId: patient.id.toString(),
                                currentDoctorModel: widget.currentDoctorModel,
                                doctorId: patient.doctor?.id.toString() ?? '',
                                isSyndicateCardRequired: widget.homeDataModel
                                        .isSyndicateCardRequired ??
                                    '',
                                currentDoctorRole:
                                    widget.homeDataModel.role.toString(),
                                currentDoctorPoints:
                                    int.parse(widget.homeDataModel.scoreValue!),
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
                                verified:
                                    widget.homeDataModel.verified ?? false,
                                patientName: patient.name.toString(),
                                currentDoctorPoints:
                                    int.parse(widget.homeDataModel.scoreValue!),
                                currentDoctorRole:
                                    widget.homeDataModel.role.toString(),
                                isSyndicateCardRequired: widget.homeDataModel
                                        .isSyndicateCardRequired ??
                                    '',
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
                                currentDoctorPoints:
                                    int.parse(widget.homeDataModel.scoreValue!),
                                currentDoctorRole:
                                    widget.homeDataModel.role.toString(),
                                homeDataModel: widget.homeDataModel,
                                isAllDataOpen: false,
                              ),
                            );
                          },
                        );
                      },
                    );
                  },
                  error: (message) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            message,
                            style: TextStyle(fontSize: 14.sp),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 20.h),
                          ElevatedButton(
                            onPressed: () {
                              cubit.getMarkedPatients();
                            },
                            child: Text(context.tr(AppStrings.tryAgain)),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 10.h),
              BlocBuilder<MarkedPatientsCubit, MarkedPatientsState>(
                builder: (context, state) {
                  return state.maybeWhen(
                    orElse: () => const SizedBox.shrink(),
                    loaded: (response, isSeeMore) {
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
                              : const SizedBox.shrink(),
                        ],
                      );
                    },
                  );
                },
              ),
              const SizedBox(height: 90),
            ],
          );
        },
      ),
    );
  }
}
