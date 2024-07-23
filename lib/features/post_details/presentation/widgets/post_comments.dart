import '../../../../exports.dart';

class PostComments extends StatelessWidget {
  final PostDetailsCubit cubit;
  final DoctorModel currentDoctorModel;
  final String currentDoctorRole;
  const PostComments({
    super.key,
    required this.cubit,
    required this.currentDoctorModel,
    required this.currentDoctorRole,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostDetailsCubit, PostDetailsState>(
        builder: (context, state) {
      return state.maybeWhen(
        orElse: () {
          return const ShimmerLoadingPatientsCards(
            ishorizontal: false,
            numberOfShimmer: 2,
          );
        },
        loaded: (comments) {
          return Column(
            children: [
              Row(
                children: [
                  Text(
                    'Comments:',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 13.sp),
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
                      onDelete: () {
                        cubit.deletePostComment(comments[index].id.toString());
                      },
                    );
                  },
                ),
              ),
            ],
          );
        },
      );
    });
  }
}
