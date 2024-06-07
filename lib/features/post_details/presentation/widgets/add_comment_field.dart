import '../../../../exports.dart';

class AddCommentField extends StatelessWidget {
  const AddCommentField({
    super.key,
    required this.size,
    required this.cubit,
    required this.currentDoctorModel,
    required this.accountVerification,
    required this.postModel,
  });

  final Size size;
  final PostDetailsCubit cubit;
  final DoctorModel currentDoctorModel;
  final bool accountVerification;
  final PostModel postModel;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostDetailsCubit, PostDetailsState>(
      builder: (context, state) {
        return state.maybeWhen(
          orElse: () {
            return Container(
              height: size.height * 0.13,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                border: Border(
                    top: BorderSide(
                  color: Colors.black12,
                )),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0) +
                    const EdgeInsets.only(left: 10, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: CustomTextFormField(
                        title: 'Write comment',
                        textInputType: TextInputType.text,
                        enableSuggestions: true,
                        onChanged: (val) {
                          cubit.newComment = val;
                        },
                        // onFieldSubmitted: (val) {
                        //   if (controller.homeController
                        //       .currentDoctorVerification.value) {
                        //     controller.addCommentOnPost(
                        //       postId: postModel.id.toString(),
                        //     );
                        //   } else {
                        //     showCustomDialog(
                        //       context: context,
                        //       title: 'Email verification',
                        //       description:
                        //           'To add comment you must verify your email address',
                        //       noColoredBottonOnTap: () {
                        //         Get.back();
                        //       },
                        //       coloredBottonText: 'Verify',
                        //       noColoredBottonText: 'Cancel',
                        //       coloredBottonOnTap: () {
                        //         Get.offAndToNamed(
                        //             AppRoutes.emailVerification);
                        //       },
                        //     );
                        //   }
                        // },
                        textInputAction: TextInputAction.done,
                        validator: (val) {
                          return null;
                        },
                      ),
                    ),
                    // controller.newComment.value.trim() == ''
                    //     ? const SizedBox.shrink()
                    //     :
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: () {
                            if (accountVerification) {
                              cubit.addCommentOnPost(postModel.id.toString());
                            } else {
                              showCustomDialog(
                                context: context,
                                title: 'Email verification',
                                description:
                                    'To add comment you must verify your email address',
                                noColoredButtonOnTap: () {
                                  Navigator.of(context).pop();
                                },
                                coloredButtonText: 'Verify',
                                noColoredButtonText: 'Cancel',
                                coloredButtonOnTap: () {
                                  // Get.offAndToNamed(AppRoutes.emailVerification);
                                },
                              );
                            }
                          },
                          icon: Icon(
                            Icons.send_outlined,
                            size: 30,
                            color: AppColors.primary.withOpacity(0.7),
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.012,
                        )
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
          loading: () {
            return const SizedBox.shrink();
          },
          loaded: (comments) {
            return Container(
              height: size.height * 0.13,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                border: Border(
                    top: BorderSide(
                  color: Colors.black12,
                )),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0) +
                    const EdgeInsets.only(left: 10, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: CustomTextFormField(
                        title: 'Write comment',
                        textInputType: TextInputType.text,
                        enableSuggestions: true,
                        onChanged: (val) {
                          cubit.newComment = val;
                        },
                        // onFieldSubmitted: (val) {
                        //   if (controller.homeController
                        //       .currentDoctorVerification.value) {
                        //     controller.addCommentOnPost(
                        //       postId: postModel.id.toString(),
                        //     );
                        //   } else {
                        //     showCustomDialog(
                        //       context: context,
                        //       title: 'Email verification',
                        //       description:
                        //           'To add comment you must verify your email address',
                        //       noColoredBottonOnTap: () {
                        //         Get.back();
                        //       },
                        //       coloredBottonText: 'Verify',
                        //       noColoredBottonText: 'Cancel',
                        //       coloredBottonOnTap: () {
                        //         Get.offAndToNamed(
                        //             AppRoutes.emailVerification);
                        //       },
                        //     );
                        //   }
                        // },
                        textInputAction: TextInputAction.done,
                        validator: (val) {
                          return null;
                        },
                      ),
                    ),
                    // controller.newComment.value.trim() == ''
                    //     ? const SizedBox.shrink()
                    //     :
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: () {
                            cubit.addCommentOnPost(postModel.id.toString());

                            // if (accountVerification) {
                            //   // controller.addCommentOnPost(
                            //   //   postId: postModel.id.toString(),
                            //   // );
                            // } else {
                            //   showCustomDialog(
                            //     context: context,
                            //     title: 'Email verification',
                            //     description:
                            //         'To add comment you must verify your email address',
                            //     noColoredBottonOnTap: () {
                            //       Navigator.of(context).pop();
                            //     },
                            //     coloredBottonText: 'Verify',
                            //     noColoredBottonText: 'Cancel',
                            //     coloredBottonOnTap: () {
                            //       // Get.offAndToNamed(AppRoutes.emailVerification);
                            //     },
                            //   );
                            // }
                          },
                          icon: Icon(
                            Icons.send_outlined,
                            size: 30,
                            color: AppColors.primary.withOpacity(0.7),
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.012,
                        )
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
