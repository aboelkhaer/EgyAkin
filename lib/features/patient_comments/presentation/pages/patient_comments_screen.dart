import '../../../../exports.dart';
import 'dart:ui' as ui;

class PatientCommentsScreen extends StatefulWidget {
  final String patientId;
  final DoctorModel currentDoctorModel;
  final String? patientName;
  final bool accountVerification;
  final String isSyndicateCardRequired;
  final int currentDoctorPoints;
  final String currentDoctorRole;
  final HomeModelResponse homeDataModel;

  const PatientCommentsScreen({
    super.key,
    required this.patientId,
    required this.currentDoctorModel,
    required this.patientName,
    required this.accountVerification,
    required this.isSyndicateCardRequired,
    required this.currentDoctorPoints,
    required this.currentDoctorRole,
    required this.homeDataModel,
  });

  @override
  State<PatientCommentsScreen> createState() => _PatientCommentsScreenState();
}

class _PatientCommentsScreenState extends State<PatientCommentsScreen> {
  @override
  void initState() {
    context.read<PatientCommentsCubit>().getPatientComments(widget.patientId);

    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final cubit = context.read<PatientCommentsCubit>();
    if (!cubit.isClosed && cubit.scrollController.hasClients) {
      cubit.scrollController.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    PatientCommentsCubit cubit = PatientCommentsCubit.get(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Patient comments',
        ),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          SingleChildScrollView(
            controller: cubit.scrollController,
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              children: [
                //  Container(
                //           margin: const EdgeInsets.only(top: 20),
                //           child: PatientCard(
                //             patientName:
                //                 widget.patientName,
                //             drFirstName: consultDetails
                //                 .patientModel!.doctor!.firstName
                //                 .toString(),
                //             isAllDataOpen: true,
                //             drLastName: consultDetails
                //                 .patientModel!.doctor!.lastName
                //                 .toString(),
                //             isOutcomeStatus: consultDetails
                //                 .patientModel!.sections!.outcomeStatus!,
                //             hospital: consultDetails.patientModel!.hospital
                //                 .toString(),
                //             submitStatus: consultDetails
                //                 .patientModel!.sections!.submitStatus!,
                //             updatedAt: consultDetails.patientModel!.updatedAt
                //                 .toString(),
                //             doctorImage: consultDetails
                //                 .patientModel!.doctor!.image
                //                 .toString(),
                //             doctorId: consultDetails.patientModel!.doctor!.id
                //                 .toString(),
                //             currentDoctorModel: widget.currentDoctorModel,
                //             isSyndicateCardRequired: consultDetails
                //                 .patientModel!.doctor!.isSyndicateCardRequired
                //                 .toString(),
                //             accountVerification: consultDetails.patientModel!
                //                         .doctor!.emailVerifiedAt ==
                //                     null
                //                 ? false
                //                 : true,
                //             currentDoctorRole:
                //                 widget.homeDataModel.role.toString(),
                //             currentDoctorPoints: int.parse(
                //                 widget.homeDataModel.scoreValue.toString()),
                //             homeDataModel: widget.homeDataModel,
                //             onAddCommentTap: () {
                //               navigatorKey.currentState?.pushNamed(
                //                 AppRoutes.comments,
                //                 arguments: AppRoutesArgs
                //                     .patientCommentsRouteArgs(
                //                         patientId: consultDetails
                //                             .patientModel!.id
                //                             .toString(),
                //                         currentDoctorModel: widget
                //                             .currentDoctorModel,
                //                         verified: widget
                //                             .homeDataModel.verified!,
                //                         patientName: consultDetails
                //                             .patientModel!.name
                //                             .toString(),
                //                         currentDoctorPoints: int.parse(widget
                //                             .homeDataModel.scoreValue!),
                //                         currentDoctorRole: widget
                //                             .homeDataModel.role
                //                             .toString(),
                //                         homeDataModel: widget.homeDataModel,
                //                         isSyndicateCardRequired: widget
                //                             .homeDataModel
                //                             .isSyndicateCardRequired!),
                //               );
                //             },
                //             onOutcomeTap: () {
                //               navigatorKey.currentState?.pushNamed(
                //                 AppRoutes.outcome,
                //                 arguments: AppRoutesArgs.outcomeRouteArgs(
                //                   verified: widget.homeDataModel.verified!,
                //                   outcomeStatus: consultDetails
                //                       .patientModel!.sections!.outcomeStatus!,
                //                   patientName: consultDetails.patientModel!.name
                //                       .toString(),
                //                   patientId: consultDetails.patientModel!.id
                //                       .toString(),
                //                   currentDoctorModel: widget.currentDoctorModel,
                //                   doctorId: consultDetails
                //                       .patientModel!.doctor!.id
                //                       .toString(),
                //                   isSyndicateCardRequired: widget
                //                       .homeDataModel.isSyndicateCardRequired!,
                //                   currentDoctorRole:
                //                       widget.homeDataModel.role.toString(),
                //                   currentDoctorPoints: int.parse(
                //                       widget.homeDataModel.scoreValue!),
                //                   homeDataModel: widget.homeDataModel,
                //                 ),
                //               );
                //             },
                //             onTap: () {
                //               navigatorKey.currentState?.pushNamed(
                //                 AppRoutes.patientSections,
                //                 arguments:
                //                     AppRoutesArgs.patientSectionsRouteArguments(
                //                   patientId: consultDetails.patientModel!.id
                //                       .toString(),
                //                   currentDoctorRole:
                //                       widget.homeDataModel.role.toString(),
                //                   currentDoctorPoints: int.parse(
                //                       widget.homeDataModel.scoreValue!),
                //                   currentDoctorModel: widget.currentDoctorModel,
                //                   homeDataModel: widget.homeDataModel,
                //                   isAllDataOpen: true,
                //                 ),
                //               );
                //             },
                //           ),
                //         ),
                //         SizedBox(height: 10.h),
                PatientComments(
                  cubit: cubit,
                  currentDoctorModel: widget.currentDoctorModel,
                  accountVerification: widget.accountVerification,
                  patientId: widget.patientId,
                  currentDoctorPoints: widget.currentDoctorPoints,
                  currentDoctorRole: widget.currentDoctorRole,
                  homeDataModel: widget.homeDataModel,
                ),
              ],
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: WriteCommentField(
              cubit: cubit,
              accountVerification: widget.accountVerification,
              currentDoctorModel: widget.currentDoctorModel,
              patientId: widget.patientId,
              isSyndicateCardRequired: widget.isSyndicateCardRequired,
            ),
          ),
        ],
      ),
    );
  }
}
