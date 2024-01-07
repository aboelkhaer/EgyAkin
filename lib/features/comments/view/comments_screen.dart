import 'package:timeago/timeago.dart' as timeago;

import '../../../exports.dart';

class CommentsScreen extends StatefulWidget {
  const CommentsScreen({super.key});

  @override
  State<CommentsScreen> createState() => _CommentsScreenState();
}

class _CommentsScreenState extends State<CommentsScreen> {
  final CommentsController controller = Get.put(CommentsController());
  @override
  void initState() {
    controller.getComments(patientId.toString());
    super.initState();
  }

  int patientId = Get.arguments[0];

  String patientName = Get.arguments[1];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(patientName),
      ),
      body: Obx(
        () => controller.isCommentsLoading.value
            ? const ShimmerLoadingPatientsCards(ishorizontal: false)
            : Stack(
                fit: StackFit.expand,
                children: [
                  RefreshIndicator(
                    onRefresh: () async {
                      controller.getComments(patientId.toString());
                    },
                    color: AppColors.primary,
                    child: SingleChildScrollView(
                      controller: controller.scrollController,
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        // mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            height: size.height * 0.03,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Row(
                              children: [
                                const Text(
                                  'Comments:',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                GetBuilder(
                                  init: CommentsController(),
                                  builder: (commentsController) {
                                    return Text(
                                      '(${commentsController.commentsList!.length})',
                                      style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: ListView.builder(
                              itemCount: controller.commentsList!.length,
                              shrinkWrap: true,
                              padding: const EdgeInsets.all(20),
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return Card(
                                  color: Colors.white, // Backgrond color
                                  elevation: 0.8,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(10),
                                    splashColor:
                                        AppColors.subBG, // Splash color
                                    onLongPress: () {
                                      if (controller.commentsList![index]
                                              .baseDoctorModel!.id
                                              .toString() ==
                                          controller
                                              .homeController.currentDoctorId
                                              .toString()) {
                                        showCustomDialog(
                                            context: context,
                                            title: 'Delete',
                                            description:
                                                'Are you sure to delete comment?',
                                            noColoredBottonOnTap: () {
                                              Get.back();
                                              controller.deleteComment(
                                                  commentId: controller
                                                      .commentsList![index].id
                                                      .toString(),
                                                  patientId:
                                                      patientId.toString());
                                            },
                                            coloredBottonText: 'Cancel',
                                            noColoredBottonText: 'Delete',
                                            isNoColorShow: true,
                                            coloredBottonOnTap: () =>
                                                Get.back());
                                      }
                                    },
                                    onTap: () {},
                                    child: Container(
                                      width: size.width * 0.85,
                                      padding: const EdgeInsets.all(16),
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              CircleAvatar(
                                                backgroundColor:
                                                    AppColors.subBG,
                                                radius: 20,
                                                child: Text(
                                                  controller
                                                              .commentsList![
                                                                  index]
                                                              .baseDoctorModel!
                                                              .firstName ==
                                                          null
                                                      ? ''
                                                      : '${controller.commentsList![index].baseDoctorModel!.firstName![0].capitalizeFirst}${controller.commentsList![index].baseDoctorModel!.lastName![0].capitalizeFirst}',
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: AppColors.primary,
                                                      fontSize: 14),
                                                ),
                                              ),
                                              Expanded(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    const SizedBox(width: 15),
                                                    Expanded(
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Text(
                                                                controller
                                                                            .commentsList![index]
                                                                            .baseDoctorModel!
                                                                            .firstName ==
                                                                        null
                                                                    ? ''
                                                                    : 'Dr.${controller.commentsList![index].baseDoctorModel!.firstName!.capitalizeFirst} ${controller.commentsList![index].baseDoctorModel!.lastName!.capitalizeFirst}',
                                                                style: const TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: AppColors
                                                                        .title,
                                                                    fontSize:
                                                                        16),
                                                                maxLines: 1,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                              ),
                                                            ],
                                                          ),
                                                          const SizedBox(
                                                              height: 4),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          Row(
                                            children: [
                                              Flexible(
                                                child: Text(
                                                  controller
                                                      .commentsList![index]
                                                      .content!
                                                      .capitalizeFirst!,
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 16,
                                                    height: 1.6,
                                                    wordSpacing: 2,
                                                    letterSpacing: 1,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: size.height * 0.02),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                controller.commentsList![index]
                                                            .updatedAt ==
                                                        null
                                                    ? ''
                                                    : timeago.format(
                                                        DateTime.parse(
                                                            controller
                                                                .commentsList![
                                                                    index]
                                                                .updatedAt
                                                                .toString())),
                                                style: const TextStyle(
                                                  color: AppColors.description,
                                                  fontSize: 14,
                                                ),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              // IconButton(
                                              //   highlightColor:
                                              //       Colors.transparent,
                                              //   splashColor:
                                              //       Colors.transparent,
                                              //   onPressed: () {},
                                              //   icon: const Icon(
                                              //     Icons.favorite_border,
                                              //     size: 30,
                                              //     color: Colors.black45,
                                              //   ),
                                              // ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          SizedBox(height: size.height * 0.13),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Container(
                      height: size.height * 0.13,
                      width: double.infinity,
                      color: Colors.white,
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
                                  controller.newComment.value = val;
                                },
                                onFieldSubmitted: (val) {
                                  if (controller.homeController
                                      .currentDoctorVerification.value) {
                                    controller.addComment(
                                        patientId: patientId.toString());
                                  } else {
                                    showCustomDialog(
                                      context: context,
                                      title: 'Email verification',
                                      description:
                                          'To add comment you must verify your email address',
                                      noColoredBottonOnTap: () {
                                        Get.back();
                                      },
                                      coloredBottonText: 'Verify',
                                      noColoredBottonText: 'Cancel',
                                      coloredBottonOnTap: () {
                                        Get.offAndToNamed(
                                            AppRoutes.emailVerification);
                                      },
                                    );
                                  }
                                  controller.addComment(
                                      patientId: patientId.toString());
                                },
                                textInputAction: TextInputAction.done,
                                validator: (val) {
                                  return null;
                                },
                              ),
                            ),
                            controller.newComment.value.trim() == ''
                                ? const SizedBox.shrink()
                                : Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          if (controller
                                              .homeController
                                              .currentDoctorVerification
                                              .value) {
                                            controller.addComment(
                                                patientId:
                                                    patientId.toString());
                                          } else {
                                            showCustomDialog(
                                              context: context,
                                              title: 'Email verification',
                                              description:
                                                  'To add comment you must verify your email address',
                                              noColoredBottonOnTap: () {
                                                Get.back();
                                              },
                                              coloredBottonText: 'Verify',
                                              noColoredBottonText: 'Cancel',
                                              coloredBottonOnTap: () {
                                                Get.offAndToNamed(AppRoutes
                                                    .emailVerification);
                                              },
                                            );
                                          }
                                        },
                                        icon: Icon(
                                          Icons.send_outlined,
                                          size: 30,
                                          color: AppColors.primary
                                              .withOpacity(0.7),
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
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
