import '../../../../exports.dart';

class PatientComments extends StatelessWidget {
  final PatientCommentsCubit cubit;
  final DoctorModel currentDoctorModel;
  final bool accountVerification;
  final String patientId;
  final int currentDoctorPoints;
  final String currentDoctorRole;
  final HomeModelResponse homeDataModel;
  const PatientComments({
    super.key,
    required this.cubit,
    required this.currentDoctorModel,
    required this.accountVerification,
    required this.patientId,
    required this.currentDoctorPoints,
    required this.currentDoctorRole,
    required this.homeDataModel,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PatientCommentsCubit, PatientCommentsState>(
        listener: (context, state) {
      state.maybeWhen(
        orElse: () {},
        error: (message) {
          customSnackBar(context: context, message: message);
        },
      );
    }, builder: (context, state) {
      return state.maybeWhen(
        orElse: () {
          return const ShimmerLoadingPatientsCards(
            ishorizontal: false,
            numberOfShimmer: 10,
          );
        },
        loaded:
            (comments, newCommentValue, isLoading, isCommentSuccess, message) {
          return Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      'Comments:',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 13.sp),
                    ),
                    const SizedBox(width: 5),
                    Text(
                      comments.length.toString(),
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: double.infinity,
                  // height: double.maxFinite,
                  child: ListView.builder(
                    itemCount: comments.length,
                    shrinkWrap: true,
                    padding: const EdgeInsets.only(top: 25),
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return CommentCard(
                        commentModel: comments[index],
                        currentDoctorModel: currentDoctorModel,
                        currentDoctorRole: currentDoctorRole,
                        homeDataModel: homeDataModel,
                        onDelete: () {
                          cubit.deletePatientComment(
                              comments[index].id.toString());
                        },
                      );
                    },
                  ),
                ),
                SizedBox(height: 100.h),
              ],
            ),
          );
        },
      );
    });
  }
}
