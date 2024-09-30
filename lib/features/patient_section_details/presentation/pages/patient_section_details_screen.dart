import 'dart:developer';

import 'package:egy_akin/features/patient_section_details/presentation/widgets/build_section_details_if_final_submit_false.dart';
import 'package:egy_akin/features/patient_section_details/presentation/widgets/build_section_details_if_final_submit_true.dart';

import '../../../../exports.dart';

class PatientSectionDetailsScreen extends StatefulWidget {
  final DoctorModel currentDoctorModel;
  final SectionModel sectionModel;
  final bool finalSubmitStatus;
  final String patientId;
  final String currentDoctorRole;
  final int currentDoctorPoints;
  final String doctorId;
  final HomeModelResponse homeDataModel;
  final bool isAllDataOpen;
  const PatientSectionDetailsScreen({
    super.key,
    required this.currentDoctorModel,
    required this.sectionModel,
    required this.finalSubmitStatus,
    required this.patientId,
    required this.doctorId,
    required this.currentDoctorRole,
    required this.currentDoctorPoints,
    required this.homeDataModel,
    required this.isAllDataOpen,
  });

  @override
  State<PatientSectionDetailsScreen> createState() =>
      _PatientSectionDetailsScreenState();
}

class _PatientSectionDetailsScreenState
    extends State<PatientSectionDetailsScreen> {
  @override
  void initState() {
    context.read<PatientSectionDetailsCubit>().getPatientSectionDetails(
        widget.sectionModel.sectionId.toString(), widget.patientId.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    PatientSectionDetailsCubit cubit = PatientSectionDetailsCubit.get(context);
    Size size = MediaQuery.of(context).size;
    log(widget.isAllDataOpen.toString());

    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
            onTap: () {
              animateToTopOfScreen(cubit.patientSectionDetailsScrollController);
            },
            child: Text(
              widget.sectionModel.sectionName.toString(),
            )),
        centerTitle: true,
        backgroundColor: AppColors.primary,
      ),
      body:
          BlocConsumer<PatientSectionDetailsCubit, PatientSectionDetailsState>(
        listener: (context, state) {
          state.maybeWhen(
            orElse: () {},
            error: (message) {
              customSnackBar(context: context, message: message);
            },
          );
        },
        builder: (context, state) {
          return state.maybeWhen(
            orElse: () {
              return const ShimmerLoadingPatientsCards(ishorizontal: false);
            },
            loaded: (
              questions,
              isSubmitLoading,
              isSubmitted,
              message,
              snackbarErrorCounter,
              isChooseFilesLoading,
              isChooseFilesLoaded,
              uploadFilesProgress,
            ) {
              if (widget.currentDoctorRole == AppStrings.roleAdmin) {
                return BuildSectionDetailsIfFinalSubmitFalse(
                  questions: questions,
                  patientId: widget.patientId,
                  doctorId: widget.doctorId,
                  sectionModel: widget.sectionModel,
                  homeDataModel: widget.homeDataModel,
                  currentDoctorModel: widget.currentDoctorModel,
                  finalSubmitStatus: widget.finalSubmitStatus,
                  isAllDataOpen: widget.isAllDataOpen,
                );
              }
              if (widget.finalSubmitStatus) {
                return BuildSectionDetailsIfFinalSubmitTrue(
                  questionList: cubit.questionModelList,
                  doctorId: widget.doctorId,
                  isAllDataOpen: widget.isAllDataOpen,
                  currentDoctorId: widget.currentDoctorModel.id.toString(),
                );
              }
              if (widget.doctorId.toString() !=
                  widget.currentDoctorModel.id.toString()) {
                BuildSectionDetailsIfFinalSubmitTrue(
                  questionList: cubit.questionModelList,
                  doctorId: widget.doctorId,
                  isAllDataOpen: widget.isAllDataOpen,
                  currentDoctorId: widget.currentDoctorModel.id.toString(),
                );
              }
              return BuildSectionDetailsIfFinalSubmitFalse(
                questions: questions,
                patientId: widget.patientId,
                doctorId: widget.doctorId,
                sectionModel: widget.sectionModel,
                homeDataModel: widget.homeDataModel,
                currentDoctorModel: widget.currentDoctorModel,
                finalSubmitStatus: widget.finalSubmitStatus,
                isAllDataOpen: widget.isAllDataOpen,
              );
              // return widget.finalSubmitStatus
              //     ? BuildSectionDetailsIfFinalSubmitTrue(
              //         questionList: cubit.questionModelList,
              //         doctorId: widget.doctorId,
              //         currentDoctorId: widget.currentDoctorModel.id.toString(),
              //       )
              //     : widget.doctorId.toString() !=
              //             widget.currentDoctorModel.id.toString()
              //         ? BuildSectionDetailsIfFinalSubmitTrue(
              //             questionList: cubit.questionModelList,
              //             doctorId: widget.doctorId,
              //             currentDoctorId:
              //                 widget.currentDoctorModel.id.toString(),
              //           )
              //         : buildSectionForm(
              //             size: size,
              //             cubit: cubit,
              //             questions: cubit.questionModelList);
            },
          );
        },
      ),
    );
  }
}
