import 'package:cached_network_image/cached_network_image.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:lottie/lottie.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../exports.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> animation;
  @override
  void initState() {
    animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    animation = Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(animationController);
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  final HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    animationController.forward();

    Get.lazyPut(() => HomeController());
    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
          onTap: () {
            if (controller.homeScrollController.hasClients) {
              controller.homeScrollController.animateTo(
                0,
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut,
              );
            }
          },
          child: const Text(
            AppStrings.appName,
            style: TextStyle(
              color: AppColors.black,
            ),
          ),
        ),
        iconTheme: const IconThemeData(color: AppColors.black),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        actions: [
          Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.only(right: 16),
            child: Obx(
              () => Tooltip(
                message: 'Score',
                child: FadeTransition(
                  opacity: animation,
                  child: Text(
                    controller.currentDoctorScoreValue == null
                        ? ''
                        : controller.currentDoctorScoreValue!.value,
                    style: TextStyle(
                        color: Colors.orange.shade300,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                ),
              ),
            ),
          ),
          Tooltip(
            message: 'Notification',
            child: GestureDetector(
              onTap: () {
                Get.toNamed(AppRoutes.notification,
                        arguments: controller.notificationsList)!
                    .then((value) {
                  if (controller.unreadNotificationCount > 0) {
                    controller.getNotifications();
                  }
                });
              },
              child: Stack(
                alignment: Alignment.center,
                children: [
                  IconButton(
                    onPressed: null,
                    icon: Icon(
                      Icons.notifications,
                      color: Colors.grey.shade500,
                    ),
                  ),
                  Positioned(
                    left: 12,
                    bottom: 14,
                    child: Obx(
                      () => controller.isNotificationsLoading.value ||
                              controller.unreadNotificationCount == 0
                          ? const SizedBox.shrink()
                          : CircleAvatar(
                              radius: 7,
                              backgroundColor: Colors.red,
                              child: Text(
                                controller.unreadNotificationCount.toString(),
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 10),
                              ),
                            ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
        elevation: 0,
      ),
      drawer: CustomDrawerWidget(
          currentDoctorPatientsCount: controller.currentPatinetList!.length),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            if (controller.isNetworkConnected.value) {
              Get.toNamed(AppRoutes.addPatient);
            } else {
              return;
            }
          },
          label: const Row(
            children: [
              Icon(Icons.add),
              Text('Add patient'),
            ],
          )),
      body: RefreshIndicator(
        onRefresh: () async {
          await controller.homeInit();
        },
        color: AppColors.primary,
        child: SingleChildScrollView(
          controller: controller.homeScrollController,
          physics: const BouncingScrollPhysics(),
          child: Obx(
            () => controller.isNetworkConnected.value
                ? Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: GestureDetector(
                          onTap: () => Get.toNamed(AppRoutes.search),
                          child: SizedBox(
                            height: 55,
                            child: TextField(
                              // controller: controller.searchController,
                              cursorColor: AppColors.primary,
                              onTapOutside: (event) =>
                                  FocusManager.instance.primaryFocus?.unfocus(),
                              decoration: InputDecoration(
                                hintText: 'Search...',
                                // Add a clear button to the search bar
                                suffixIcon: IconButton(
                                  icon: const Icon(Icons.clear),
                                  onPressed: () =>
                                      controller.searchController?.clear(),
                                ),
                                // Add a search icon or button to the search bar
                                prefixIcon: const Icon(
                                  Icons.search,
                                  // color: AppColors.primary,
                                ),
                                prefixIconColor: MaterialStateColor.resolveWith(
                                    (states) =>
                                        states.contains(MaterialState.focused)
                                            ? AppColors.primary
                                            : Colors.grey),
                                suffixIconColor: MaterialStateColor.resolveWith(
                                    (states) =>
                                        states.contains(MaterialState.focused)
                                            ? AppColors.primary
                                            : Colors.grey),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: const BorderSide(
                                      color: AppColors.primary),
                                ),
                              ),
                              enabled: false,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: size.height * 0.01),
                      Obx(
                        () => controller.isPostsLoading.value == true ||
                                controller.postsList == null
                            ? SizedBox(
                                height: size.height * 0.2,
                                child: Lottie.asset(AppImages.imageLoader),
                              )
                            : controller.postsList!.isEmpty
                                ? FadeTransition(
                                    opacity: animation,
                                    child: SizedBox(
                                      height: size.height * 0.2,
                                      child: Image.asset(AppImages.noNetwork),
                                    ),
                                  )
                                : FadeTransition(
                                    opacity: animation,
                                    child: CarouselSlider.builder(
                                      itemCount: controller.postsList!.length,
                                      carouselController:
                                          controller.carouselController,
                                      itemBuilder: (BuildContext context,
                                          int index, int pageViewIndex) {
                                        return Card(
                                          color:
                                              Colors.white, // Backgrond color
                                          elevation: 0.8,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          child: InkWell(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            splashColor:
                                                AppColors.subBG, // Splash color
                                            onTap: () {
                                              Get.toNamed(
                                                AppRoutes.postDetails,
                                                arguments: [
                                                  index,
                                                  controller.postsList![index],
                                                  controller.postsList!.length,
                                                ],
                                              );
                                            },
                                            child: SizedBox(
                                              width: size.width * 0.9,
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Expanded(
                                                    child: Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .stretch,
                                                      children: [
                                                        ClipRRect(
                                                          borderRadius:
                                                              const BorderRadius
                                                                      .only(
                                                                  topLeft: Radius
                                                                      .circular(
                                                                          8),
                                                                  bottomLeft: Radius
                                                                      .circular(
                                                                          8)),
                                                          child: Hero(
                                                            tag: controller
                                                                        .postsList!
                                                                        .length <=
                                                                    1
                                                                ? 'postImage'
                                                                : 'postImage$index',
                                                            child:
                                                                CachedNetworkImage(
                                                              imageUrl: controller
                                                                  .postsList![
                                                                      index]
                                                                  .image
                                                                  .toString(),
                                                              width:
                                                                  size.width *
                                                                      0.3,
                                                              fadeInCurve:
                                                                  Curves.easeIn,
                                                              fit: BoxFit.cover,
                                                              placeholder: (context,
                                                                      url) =>
                                                                  Lottie.asset(
                                                                      AppImages
                                                                          .imageLoader),
                                                              errorWidget:
                                                                  (context, url,
                                                                      error) {
                                                                return Container(
                                                                  color: AppColors
                                                                      .primary,
                                                                  child:
                                                                      const Center(
                                                                    child: Icon(
                                                                      Icons
                                                                          .error_outline,
                                                                      color: Colors
                                                                          .white,
                                                                      size:
                                                                          40.0,
                                                                    ),
                                                                  ),
                                                                );
                                                              },
                                                            ),
                                                          ),
                                                        ),
                                                        Expanded(
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8),
                                                            child: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              children: [
                                                                // const SizedBox(height: 10),
                                                                Row(
                                                                  children: [
                                                                    Flexible(
                                                                      child:
                                                                          Text(
                                                                        controller
                                                                            .postsList![index]
                                                                            .title
                                                                            .toString()
                                                                            .capitalizeFirst!,
                                                                        style: const TextStyle(
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                            color: AppColors.title,
                                                                            fontSize: 16),
                                                                        maxLines:
                                                                            2,
                                                                        overflow:
                                                                            TextOverflow.ellipsis,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                                SizedBox(
                                                                    height: size
                                                                            .height *
                                                                        0.01),
                                                                Row(
                                                                  children: [
                                                                    Flexible(
                                                                      child:
                                                                          Text(
                                                                        controller
                                                                            .postsList![index]
                                                                            .content
                                                                            .toString()
                                                                            .capitalizeFirst!,
                                                                        style: const TextStyle(
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                            color: AppColors.description,
                                                                            fontSize: 13),
                                                                        maxLines:
                                                                            5,
                                                                        overflow:
                                                                            TextOverflow.ellipsis,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                                const Spacer(),
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .end,
                                                                  children: [
                                                                    Text(
                                                                      timeago
                                                                          .format(
                                                                              DateTime.parse(
                                                                            controller.postsList![index].updatedAt.toString(),
                                                                          ))
                                                                          .toString(),
                                                                      style:
                                                                          const TextStyle(
                                                                        color: AppColors
                                                                            .description,
                                                                        fontSize:
                                                                            10,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                      options: CarouselOptions(
                                        height: size.height * 0.23,
                                        aspectRatio: 16 / 9,
                                        viewportFraction: 1,
                                        initialPage: 0,
                                        enableInfiniteScroll: true,
                                        reverse: false,
                                        onPageChanged: (index, reason) {
                                          controller.dotsPosition.value = index;
                                          if (controller
                                              .dotsController.hasClients) {
                                            WidgetsBinding.instance
                                                .addPostFrameCallback((_) {
                                              if (controller
                                                  .dotsController.hasClients) {
                                                controller.dotsController
                                                    .jumpToPage(index);
                                              }
                                            });
                                          }
                                        },
                                        autoPlay: true,
                                        autoPlayInterval:
                                            const Duration(seconds: 3),
                                        autoPlayAnimationDuration:
                                            const Duration(milliseconds: 800),
                                        autoPlayCurve: Curves.fastOutSlowIn,
                                        enlargeCenterPage: false,
                                        // scrollPhysics: const BouncingScrollPhysics(),
                                        enlargeFactor: 0.3,
                                        scrollDirection: Axis.horizontal,
                                      ),
                                    ),
                                  ),
                      ),
                      SizedBox(height: size.height * 0.01),
                      // todo moatz123
                      Obx(
                        () => controller.isPostsLoading.value ||
                                controller.postsList == null ||
                                controller.postsList!.isEmpty
                            ? const SizedBox.shrink()
                            : DotsIndicator(
                                dotsCount: controller.postsList!.length,
                                position: controller.dotsPosition.value,
                                decorator: DotsDecorator(
                                  activeColor:
                                      AppColors.primary.withOpacity(0.6),
                                  color: Colors.grey.shade300,
                                  size: const Size(5, 5),
                                ),
                              ),
                      ),
                      SizedBox(height: size.height * 0.01),
                      GetBuilder(
                        init: HomeController(),
                        builder: (homeController) {
                          return Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        const Text(
                                          'Your patients',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Obx(
                                          () => Text(
                                            controller.isCurrentPatientsLoading
                                                        .value ||
                                                    controller
                                                            .currentPatinetList ==
                                                        null
                                                ? ''
                                                : ' (${controller.currentPatinetList!.length})',
                                            style: const TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Get.toNamed(
                                          AppRoutes.currentPatients,
                                        );
                                      },
                                      child: const Icon(Icons.arrow_forward),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                      GetBuilder<HomeController>(
                        init: HomeController(),
                        builder: (homeController) {
                          return SizedBox(
                            child: homeController.isCurrentPatientsLoading.value
                                ? const ShimmerLoadingPatientsCards(
                                    ishorizontal: true,
                                  )
                                : controller.currentPatinetList == null ||
                                        controller.currentPatinetList!.isEmpty
                                    ? FadeTransition(
                                        opacity: animation,
                                        child: SizedBox(
                                          height: size.height * 0.20,
                                          child: Image.asset(
                                            AppImages.notFound,
                                            height: size.height * 0.2,
                                            width: size.width * 0.45,
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      )
                                    : FadeTransition(
                                        opacity: animation,
                                        child: SizedBox(
                                          height: size.height * 0.26,
                                          child: ListView.builder(
                                            physics:
                                                const BouncingScrollPhysics(),
                                            shrinkWrap: true,
                                            scrollDirection: Axis.horizontal,
                                            padding: const EdgeInsets.only(
                                              left: 20,
                                            ),
                                            itemCount: homeController
                                                        .currentPatinetList!
                                                        .length <
                                                    5
                                                ? homeController
                                                    .currentPatinetList!.length
                                                : 5,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              var patient = controller
                                                  .currentPatinetList![index];
                                              // return PatientCard(
                                              //   size: size,
                                              //   isCurrentDoctorPatients: true,
                                              //   patientName:
                                              //       patient.name ?? '',
                                              //   drName:
                                              //       'Dr.${controller.currentDoctorFirstName!.capitalizeFirst ?? ''} ${controller.currentDoctorLastName!.capitalizeFirst ?? ''}',
                                              //   hospital: homeController
                                              //           .currentPatinetList![
                                              //               index]
                                              //           .hospital ??
                                              //       '',
                                              //   createdAt: homeController
                                              //           .currentPatinetList![
                                              //               index]
                                              //           .updatedAt ??
                                              //       '',
                                              //   updatedAt: homeController
                                              //           .currentPatinetList![
                                              //               index]
                                              //           .updatedAt ??
                                              //       '',
                                              //   submitStatus: homeController
                                              //               .currentPatinetList![
                                              //                   index]
                                              //               .sections ==
                                              //           null
                                              //       ? false
                                              //       : homeController
                                              //               .currentPatinetList![
                                              //                   index]
                                              //               .sections!
                                              //               .submitStatus ??
                                              //           false,
                                              //   isOutcomeStatus: patient
                                              //       .sections!.outcomeStatus!,
                                              //   onOutcomeTap: () =>
                                              //       Get.toNamed(
                                              //     AppRoutes.outcome,
                                              //     arguments: [
                                              //       patient.sections!
                                              //           .outcomeStatus,
                                              //       patient.id,
                                              //       patient.name
                                              //     ],
                                              //   ),
                                              //   onAddCommentTap: () {
                                              //     Get.toNamed(
                                              //       AppRoutes.comments,
                                              //       arguments: [
                                              //         patient.id,
                                              //         patient.name,
                                              //       ],
                                              //     );
                                              //   },
                                              //   onTap: () {
                                              //     Get.toNamed(
                                              //         AppRoutes
                                              //             .patientSections,
                                              //         // arguments: homeController
                                              //         //     .currentPatinetList![index],
                                              //         arguments: [
                                              //           patient.id,
                                              //           patient
                                              //               .doctorModel!.id,
                                              //           patient.name,
                                              //           patient.sections!
                                              //               .submitStatus,
                                              //         ]);
                                              //   },
                                              //   onLongPress: () {},
                                              // );
                                              return VerticalPatientCard(
                                                patientName: patient.name ?? '',
                                                drFirstName: patient
                                                        .doctorModel!
                                                        .firstName ??
                                                    '',
                                                drLastName: patient.doctorModel!
                                                        .lastName ??
                                                    '',
                                                updatedAt:
                                                    patient.updatedAt ?? '',
                                                hospital:
                                                    patient.hospital ?? '',
                                                submitStatus:
                                                    patient.sections == null
                                                        ? false
                                                        : patient.sections!
                                                                .submitStatus ??
                                                            false,
                                                isOutcomeStatus: patient
                                                    .sections!.outcomeStatus!,
                                                onOutcomeTap: () => Get.toNamed(
                                                  AppRoutes.outcome,
                                                  arguments: [
                                                    patient.sections!
                                                        .outcomeStatus,
                                                    patient.id,
                                                    patient.name
                                                  ],
                                                ),
                                                onAddCommentTap: () {
                                                  Get.toNamed(
                                                    AppRoutes.comments,
                                                    arguments: [
                                                      patient.id,
                                                      patient.name,
                                                    ],
                                                  );
                                                },
                                                onTap: () {
                                                  Get.toNamed(
                                                      AppRoutes.patientSections,
                                                      arguments: [
                                                        patient.id,
                                                        patient.doctorModel!.id,
                                                        patient.name,
                                                        patient.sections!
                                                            .submitStatus,
                                                      ]);
                                                },
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                          );
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    const Text(
                                      'All patients',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Obx(
                                      () => Text(
                                        controller.isAllPatientsLoading.value ||
                                                controller.allPatinetList ==
                                                    null
                                            ? ' '
                                            : ' (${controller.allPatinetList!.length})',
                                        style: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Get.toNamed(
                                      AppRoutes.allPatients,
                                    );
                                  },
                                  child: const Icon(Icons.arrow_forward),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Obx(
                        () => SizedBox(
                          child: controller.isAllPatientsLoading.value
                              ? const ShimmerLoadingPatientsCards(
                                  ishorizontal: true,
                                )
                              : controller.allPatinetList == null ||
                                      controller.allPatinetList!.isEmpty
                                  ? FadeTransition(
                                      opacity: animation,
                                      child: SizedBox(
                                        height: size.height * 0.22,
                                        child: Image.asset(
                                          AppImages.notFound,
                                          height: size.height * 0.2,
                                          width: size.width * 0.45,
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    )
                                  : FadeTransition(
                                      opacity: animation,
                                      child: SizedBox(
                                        height: size.height * 0.26,
                                        child: ListView.builder(
                                          physics:
                                              const BouncingScrollPhysics(),
                                          shrinkWrap: true,
                                          scrollDirection: Axis.horizontal,
                                          padding: const EdgeInsets.only(
                                            left: 20,
                                          ),
                                          itemCount: controller
                                                      .allPatinetList!.length <
                                                  5
                                              ? controller
                                                  .allPatinetList!.length
                                              : 5,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            var patient = controller
                                                .allPatinetList![index];
                                            // return PatientCard(
                                            //   size: size,
                                            //   isCurrentDoctorPatients: false,
                                            //   patientName: patient.name!,
                                            //   drName:
                                            //       'Dr.${patient.doctorModel!.firstName == null ? '' : patient.doctorModel!.firstName!.capitalizeFirst} ${patient.doctorModel!.lastName == null ? '' : patient.doctorModel!.lastName!.capitalizeFirst}',
                                            //   createdAt: patient.updatedAt!,
                                            //   hospital: patient.hospital!,
                                            //   updatedAt: patient.updatedAt!,
                                            //   isOutcomeStatus: patient
                                            //       .sections!.outcomeStatus!,
                                            //   onOutcomeTap: () => Get.toNamed(
                                            //     AppRoutes.outcome,
                                            //     arguments: [
                                            //       patient.sections!
                                            //           .outcomeStatus,
                                            //       patient.id,
                                            //       patient.name
                                            //     ],
                                            //   ),
                                            //   submitStatus:
                                            //       patient.sections == null
                                            //           ? false
                                            //           : patient.sections!
                                            //                   .submitStatus ??
                                            //               false,
                                            //   onTap: () {
                                            //     Get.toNamed(
                                            //       AppRoutes.patientSections,
                                            //       // arguments:
                                            //       //     controller.allPatinetList![index],
                                            //       arguments: [
                                            //         patient.id,
                                            //         patient.doctorModel!.id,
                                            //         patient.name,
                                            //         patient.sections!
                                            //             .submitStatus,
                                            //       ],
                                            //     );
                                            //   },
                                            //   onAddCommentTap: () {
                                            //     Get.toNamed(
                                            //       AppRoutes.comments,
                                            //       arguments: [
                                            //         patient.id,
                                            //         patient.name,
                                            //       ],
                                            //     );
                                            //   },
                                            //   onLongPress: () {},
                                            // );
                                            return VerticalPatientCard(
                                              patientName: patient.name ?? '',
                                              drFirstName: patient
                                                      .doctorModel!.firstName ??
                                                  '',
                                              drLastName: patient
                                                      .doctorModel!.lastName ??
                                                  '',
                                              updatedAt:
                                                  patient.updatedAt ?? '',
                                              hospital: patient.hospital ?? '',
                                              submitStatus:
                                                  patient.sections == null
                                                      ? false
                                                      : patient.sections!
                                                              .submitStatus ??
                                                          false,
                                              isOutcomeStatus: patient
                                                  .sections!.outcomeStatus!,
                                              onOutcomeTap: () => Get.toNamed(
                                                AppRoutes.outcome,
                                                arguments: [
                                                  patient
                                                      .sections!.outcomeStatus,
                                                  patient.id,
                                                  patient.name
                                                ],
                                              ),
                                              onAddCommentTap: () {
                                                Get.toNamed(
                                                  AppRoutes.comments,
                                                  arguments: [
                                                    patient.id,
                                                    patient.name,
                                                  ],
                                                );
                                              },
                                              onTap: () {
                                                Get.toNamed(
                                                    AppRoutes.patientSections,
                                                    arguments: [
                                                      patient.id,
                                                      patient.doctorModel!.id,
                                                      patient.name,
                                                      patient.sections!
                                                          .submitStatus,
                                                    ]);
                                              },
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                        ),
                      ),
                      SizedBox(height: size.height * 0.1),
                    ],
                  )
                : SizedBox(
                    width: double.infinity,
                    height: size.height * 0.9,
                    child: Column(
                      children: [
                        SizedBox(
                          height: size.height * 0.09,
                        ),
                        Image.asset(
                          AppImages.noNetwork,
                          height: size.height * 0.3,
                        ),
                        SizedBox(
                          height: size.height * 0.01,
                        ),
                        const Text(
                          'Ooops!',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                            color: AppColors.title,
                          ),
                        ),
                        SizedBox(height: size.height * 0.02),
                        const Text(
                          'No Internet Connection Found\nCheck Your Connection',
                          style: TextStyle(
                            fontSize: 18,
                            color: AppColors.description,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: size.height * 0.07),
                        SizedBox(
                          width: size.width * 0.4,
                          child: CustomElevatedButton(
                              size: size,
                              onPressed: () async {
                                controller.homeInit();
                              },
                              title: 'Try Again'),
                        ),
                      ],
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
