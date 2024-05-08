import 'dart:developer';

import 'package:egy_akin/features/patient_sections/presentation/widgets/footer_bottons.dart';

import '../../../../exports.dart';

class PatientSectionsScreen extends StatefulWidget {
  final String patientId;
  final String currentDoctorId;
  const PatientSectionsScreen({
    super.key,
    required this.patientId,
    required this.currentDoctorId,
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
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: BlocConsumer<PatientSectionsCubit, PatientSectionsState>(
          listener: (context, state) {
            state.maybeWhen(
              orElse: () {},
              loaded: (response, isDelete, isFinalSubmit) {
                if (isDelete) {
                  Navigator.pushReplacementNamed(context, AppRoutes.home);
                }
                if (isFinalSubmit) {
                  Navigator.pushReplacementNamed(context, AppRoutes.home);
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
              loaded: (response, isDelete, isFinalSubmit) {
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
      body: BlocBuilder<PatientSectionsCubit, PatientSectionsState>(
        builder: (context, state) {
          return state.maybeWhen(
            orElse: () {
              return const ShimmerLoadingPatientsCards(ishorizontal: false);
            },
            loaded: (response, isDelete, isFinalSubmit) {
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
                                      // Get.toNamed(
                                      //   AppRoutes.sectionDetails,
                                      //   arguments: [
                                      //     section.sectionId,
                                      //     section.sectionName,
                                      //     submitStatus,
                                      //     patientId,
                                      //     doctorId,
                                      //   ],
                                      // );
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
                        loaded: (response, isDelete, isFinalSubmit) {
                          if ((response.doctorId.toString() ==
                                  widget.currentDoctorId.toString()) &&
                              (response.submitStatus != null &&
                                  !response.submitStatus!)) {
                            return FooterBottons(
                              currentDoctorId: widget.currentDoctorId,
                              doctorId: response.doctorId!,
                              patientName: response.patientName!,
                              cubit: cubit,
                              patientId: widget.patientId,
                            );
                          }
                          return const SizedBox.shrink();
                        },
                      );
                    },
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
