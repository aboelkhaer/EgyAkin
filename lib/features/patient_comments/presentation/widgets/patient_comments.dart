import '../../../../exports.dart';

class PatientComments extends StatelessWidget {
  final PatientCommentsCubit cubit;
  final DoctorModel currentDoctorModel;
  final bool accountVerification;
  final String patientId;
  const PatientComments({
    super.key,
    required this.cubit,
    required this.currentDoctorModel,
    required this.accountVerification,
    required this.patientId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PatientCommentsCubit, PatientCommentsState>(
        builder: (context, state) {
      return state.maybeWhen(
        orElse: () {
          return const ShimmerLoadingPatientsCards(
            ishorizontal: false,
            numberOfShimmer: 10,
          );
        },
        loaded: (comments, newCommentValue) {
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
