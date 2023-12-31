import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../app/utilities/lunch_url.dart';
import '../../../exports.dart';

class PostDetailsScreen extends StatefulWidget {
  const PostDetailsScreen({super.key});

  @override
  State<PostDetailsScreen> createState() => _PostDetailsScreenState();
}

class _PostDetailsScreenState extends State<PostDetailsScreen> {
  final PostDetailsController controller = Get.put(PostDetailsController());
  int index = Get.arguments[0];
  BasePostModel postModel = Get.arguments[1];
  @override
  void initState() {
    controller.getPostComments(postModel.id.toString());
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        fit: StackFit.expand,
        children: [
          RefreshIndicator(
            onRefresh: () {
              return controller.getPostComments(postModel.id.toString());
            },
            color: AppColors.primary,
            child: SingleChildScrollView(
              controller: controller.scrollController,
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  // SizedBox(height: size.height * 0.05),
                  // Row(
                  //   children: [
                  //     // const SizedBox(width: 20),
                  //     IconButton(
                  //       highlightColor: Colors.transparent,
                  //       splashColor: Colors.transparent,
                  //       onPressed: () => Get.back(),
                  //       icon: const Icon(
                  //         Icons.arrow_back,
                  //         color: AppColors.title,
                  //         size: 30,
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  // SizedBox(height: size.height * 0.01),
                  Hero(
                    tag:
                        Get.arguments[2] <= 1 ? 'postImage' : 'postImage$index',
                    child: CachedNetworkImage(
                      imageUrl: postModel.image.toString(),
                      width: double.infinity,
                      fadeInCurve: Curves.easeIn,
                      height: size.height * 0.25,
                      fit: BoxFit.cover,
                      placeholder: (context, url) =>
                          Lottie.asset(AppImages.imageLoader),
                      errorWidget: (context, url, error) {
                        return Container(
                          color: AppColors.primary,
                          child: const Center(
                            child: Icon(
                              Icons.error_outline,
                              color: Colors.white,
                              size: 40.0,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Flexible(
                              child: Text(
                                postModel.title.toString(),
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.title,
                                  height: 1.5,
                                  wordSpacing: 0.5,
                                  letterSpacing: 1,
                                  fontSize: 17,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: size.height * 0.008),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              DateFormat.yMMMEd().format(DateTime.parse(
                                  postModel.updatedAt.toString())),
                              style: const TextStyle(
                                color: AppColors.description,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: size.height * 0.03),
                        Row(
                          children: [
                            Flexible(
                              // child: Text(
                              //   postModel.content.toString(),
                              //   style: TextStyle(
                              //     fontSize: 15,
                              //     wordSpacing: 1,
                              //     letterSpacing: 1,
                              //     height: 1.5,
                              //     color: Colors.grey.shade900,
                              //   ),
                              // ),
                              child: HtmlWidget(postModel.content.toString(),
                                  onTapUrl: (url) {
                                log(url.toString());
                                launchURL(url);
                                return true;
                              }),
                            ),
                          ],
                        ),
                        SizedBox(height: size.height * 0.06),
                        Column(
                          children: [
                            Row(
                              children: [
                                const Text(
                                  'Comments:',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Obx(
                                  () => Text(
                                    controller.isCommentsLoading.value
                                        ? ''
                                        : '(${controller.postCommentsList!.length.toString()})',
                                    style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Obx(
                              () => controller.isCommentsLoading.value
                                  ? const ShimmerLoadingPatientsCards(
                                      ishorizontal: false)
                                  : SizedBox(
                                      width: double.infinity,
                                      // height: double.maxFinite,
                                      child: ListView.builder(
                                        itemCount:
                                            controller.postCommentsList!.length,
                                        shrinkWrap: true,
                                        padding: const EdgeInsets.only(top: 25),
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemBuilder: (context, index) {
                                          return Card(
                                            color: Colors.white,
                                            // Backgrond color
                                            margin: const EdgeInsets.only(
                                                bottom: 10),
                                            elevation: 0.8,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: InkWell(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              splashColor: AppColors
                                                  .subBG, // Splash color
                                              onLongPress: () {
                                                if (controller
                                                        .postCommentsList![
                                                            index]
                                                        .baseDoctorModel!
                                                        .id
                                                        .toString() ==
                                                    controller.homeController
                                                        .currentDoctorId
                                                        .toString()) {
                                                  showCustomDialog(
                                                      context: context,
                                                      title: 'Delete',
                                                      description:
                                                          'Are you sure to delete comment?',
                                                      noColoredBottonOnTap: () {
                                                        Get.back();
                                                        controller
                                                            .deletePostComment(
                                                          commentId: controller
                                                              .postCommentsList![
                                                                  index]
                                                              .id
                                                              .toString(),
                                                        );
                                                      },
                                                      coloredBottonText:
                                                          'Cancel',
                                                      noColoredBottonText:
                                                          'Delete',
                                                      isNoColorShow: true,
                                                      coloredBottonOnTap: () =>
                                                          Get.back());
                                                }
                                              },
                                              onTap: () {},
                                              child: Container(
                                                width: size.width * 0.85,
                                                padding:
                                                    const EdgeInsets.all(16),
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      children: [
                                                        CircleAvatar(
                                                          backgroundColor:
                                                              AppColors.subBG,
                                                          radius: 20,
                                                          child: Text(
                                                            '${controller.postCommentsList![index].baseDoctorModel!.firstName![0].capitalizeFirst}${controller.postCommentsList![index].baseDoctorModel!.lastName![0].capitalizeFirst}',
                                                            style: const TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: AppColors
                                                                    .primary,
                                                                fontSize: 14),
                                                          ),
                                                        ),
                                                        Expanded(
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              const SizedBox(
                                                                  width: 15),
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
                                                                          'Dr.${controller.postCommentsList![index].baseDoctorModel!.firstName!.capitalizeFirst} ${controller.postCommentsList![index].baseDoctorModel!.lastName!.capitalizeFirst}',
                                                                          style: const TextStyle(
                                                                              fontWeight: FontWeight.bold,
                                                                              color: AppColors.title,
                                                                              fontSize: 14),
                                                                          maxLines:
                                                                              1,
                                                                          overflow:
                                                                              TextOverflow.ellipsis,
                                                                        ),
                                                                        // Text(
                                                                        //   homeController
                                                                        //               .currentDoctorCreatedAt ==
                                                                        //           null
                                                                        //       ? ''
                                                                        //       : timeago
                                                                        //           .format(DateTime.parse(
                                                                        //               homeController
                                                                        //                   .currentDoctorCreatedAt!))
                                                                        //           .toString(),
                                                                        //   style:
                                                                        //       const TextStyle(
                                                                        //     color: AppColors
                                                                        //         .description,
                                                                        //     fontSize: 10,
                                                                        //   ),
                                                                        //   maxLines: 1,
                                                                        //   overflow: TextOverflow
                                                                        //       .ellipsis,
                                                                        // ),
                                                                      ],
                                                                    ),
                                                                    const SizedBox(
                                                                        height:
                                                                            4),
                                                                    // Text(
                                                                    //   homeController
                                                                    //               .currentDoctorJob ==
                                                                    //           null
                                                                    //       ? ''
                                                                    //       : homeController
                                                                    //           .currentDoctorJob!,
                                                                    //   style: const TextStyle(
                                                                    //     color: AppColors
                                                                    //         .description,
                                                                    //     fontSize: 13,
                                                                    //   ),
                                                                    //   maxLines: 1,
                                                                    //   overflow:
                                                                    //       TextOverflow.ellipsis,

                                                                    // ),
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
                                                                .postCommentsList![
                                                                    index]
                                                                .content
                                                                .toString(),
                                                            style:
                                                                const TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontSize: 14,
                                                              height: 1.6,
                                                              wordSpacing: 2,
                                                              letterSpacing: 1,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                        height:
                                                            size.height * 0.02),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          timeago.format(DateTime
                                                              .parse(controller
                                                                  .postCommentsList![
                                                                      index]
                                                                  .updatedAt
                                                                  .toString())),
                                                          style:
                                                              const TextStyle(
                                                            color: AppColors
                                                                .description,
                                                            fontSize: 12,
                                                          ),
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
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
                            ),
                          ],
                        ),
                      ],
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
            child: Obx(
              () => controller.isCommentsLoading.value
                  ? const SizedBox.shrink()
                  : Container(
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
                                  controller.addCommentOnPost(
                                    postId: postModel.id.toString(),
                                  );
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
                                          controller.addCommentOnPost(
                                            postId: postModel.id.toString(),
                                          );
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
          ),
        ],
      ),
    );
  }
}
