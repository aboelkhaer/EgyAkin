import 'package:egy_akin/features/patient_sections/presentation/widgets/footer_bottons.dart';

import '../../../../exports.dart';

class PatientSectionsScreen extends StatefulWidget {
  final String patientId;
  final DoctorModel currentDoctorModel;
  const PatientSectionsScreen({
    super.key,
    required this.patientId,
    required this.currentDoctorModel,
  });

  @override
  State<PatientSectionsScreen> createState() => _PatientSectionsScreenState();
}

class _PatientSectionsScreenState extends State<PatientSectionsScreen> {
  @override
  void initState() {
    context.read<PatientSectionsCubit>().getPatientSections(widget.patientId);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    PatientSectionsCubit cubit = PatientSectionsCubit.get(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: BlocConsumer<PatientSectionsCubit, PatientSectionsState>(
          listener: (context, state) {
            state.maybeWhen(
              orElse: () {},
              loaded: (response,
                  isDelete,
                  isFinalSubmit,
                  message,
                  isLoading,
                  reportProgress,
                  filePath,
                  isDownloadingReport,
                  isDownloadedReport) {
                if (isDelete) {
                  Navigator.pushReplacementNamed(context, AppRoutes.home,
                      arguments: 0);
                }
                if (isFinalSubmit) {
                  Navigator.pushReplacementNamed(context, AppRoutes.home,
                      arguments: 0);
                }
              },
            );
          },
          builder: (context, state) {
            return state.maybeWhen(
              orElse: () {
                return const Text(
                  '',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                );
              },
              loaded: (response,
                  isDelete,
                  isFinalSubmit,
                  message,
                  isLoading,
                  reportProgress,
                  filePath,
                  isDownloadingReport,
                  isDownloadedReport) {
                return Text(
                  response.patientName.toString(),
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                );
              },
            );
          },
        ),
        centerTitle: true,
      ),
      body: BlocConsumer<PatientSectionsCubit, PatientSectionsState>(
        listener: (context, state) {
          state.maybeWhen(
            orElse: () {},
            loaded: (response,
                isDelete,
                isFinalSubmit,
                message,
                isLoading,
                reportProgress,
                filePath,
                isDownloadingReport,
                isDownloadedReport) {
              if (message.isNotEmpty) {
                customSnackBar(context: context, message: message);
              }

              if (isDownloadedReport && reportProgress == 1.0) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('PDF downloaded: $filePath')),
                );
              }
            },
          );
        },
        builder: (context, state) {
          return state.maybeWhen(
            orElse: () {
              return const ShimmerLoadingPatientsCards(ishorizontal: false);
            },
            loaded: (response,
                isDelete,
                isFinalSubmit,
                message,
                isLoading,
                reportProgress,
                filePath,
                isDownloadingReport,
                isDownloadedReport) {
              if (isLoading) {
                return const ShimmerLoadingPatientsCards(ishorizontal: false);
              } else {
                return Column(
                  children: [
                    Expanded(
                      child: Padding(
                        padding:
                            const EdgeInsets.only(top: 30, left: 30, right: 30),
                        child: response.data == null || response.data!.isEmpty
                            ? const SizedBox.shrink()
                            : ListView.builder(
                                itemCount: response.data!.length,
                                shrinkWrap: true,
                                padding: const EdgeInsets.only(bottom: 20),
                                physics: const BouncingScrollPhysics(),
                                itemBuilder: (context, index) {
                                  var section = response.data![index];
                                  return Padding(
                                    padding: const EdgeInsets.only(bottom: 8),
                                    child: SectionCard(
                                      onTap: () {
                                        navigatorKey.currentState?.pushNamed(
                                          AppRoutes.patientSectionDetails,
                                          arguments: AppRoutesArgs
                                              .patientSectionDetailsRouteArgs(
                                                  sectionModel: section,
                                                  currentDoctorModel:
                                                      widget.currentDoctorModel,
                                                  finalSubmitStatus:
                                                      response.submitStatus!,
                                                  patientId: widget.patientId,
                                                  doctorId: response.doctorId
                                                      .toString()),
                                        );
                                      },
                                      updatedAt: section.updatedAt ?? '',
                                      isSubmitStatus:
                                          section.sectionStatus ?? false,
                                      index: index,
                                      sectionName: section.sectionName ?? '',
                                    ),
                                  );
                                },
                              ),
                      ),
                    ),
                    BlocBuilder<PatientSectionsCubit, PatientSectionsState>(
                      builder: (context, state) {
                        return state.maybeWhen(
                          orElse: () {
                            return const SizedBox.shrink();
                          },
                          loaded: (response,
                              isDelete,
                              isFinalSubmit,
                              message,
                              isLoading,
                              reportProgress,
                              filePath,
                              isDownloadingReport,
                              isDownloadedReport) {
                            if ((response.doctorId.toString() ==
                                    widget.currentDoctorModel.id.toString()) &&
                                (response.submitStatus != null &&
                                    !response.submitStatus!)) {
                              return FooterButtons(
                                currentDoctorId:
                                    widget.currentDoctorModel.id.toString(),
                                doctorId: response.doctorId!,
                                patientName: response.patientName!,
                                cubit: cubit,
                                patientId: widget.patientId,
                                finalSubmit: response.submitStatus!,
                              );
                            }
                            if (isDownloadingReport) {
                              return SizedBox(
                                height: 100.h,
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Text('Downloading...'),
                                      const SizedBox(height: 10),
                                      LinearProgressIndicator(
                                          value: reportProgress),
                                      const SizedBox(height: 10),
                                      Text(
                                          '${(reportProgress * 100).toStringAsFixed(0)}%'),
                                    ],
                                  ),
                                ),
                              );
                            }
                            return FooterButtons(
                              currentDoctorId:
                                  widget.currentDoctorModel.id.toString(),
                              doctorId: response.doctorId!,
                              patientName: response.patientName!,
                              cubit: cubit,
                              patientId: widget.patientId,
                              finalSubmit: response.submitStatus!,
                            );
                          },
                        );
                      },
                    ),
                  ],
                );
              }
            },
          );
        },
      ),
    );
  }
}
