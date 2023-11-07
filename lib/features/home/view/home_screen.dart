import 'dart:math';

import 'package:timeago/timeago.dart' as timeago;

import '../../../exports.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Get.lazyPut(() => HomeController());
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'EgyAkin',
          style: TextStyle(
            color: AppColors.black,
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
              () => Text(
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
          IconButton(
            onPressed: () => Get.toNamed(AppRoutes.notification),
            icon: Icon(
              Icons.notifications,
              color: Colors.grey.shade500,
            ),
          ),
        ],
        elevation: 0,
      ),
      drawer: CustomDrawerWidget(
          currentDoctorPatientsCount: controller.currentPatinetList!.length),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () => Get.toNamed(AppRoutes.addPatient),
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
          physics: const BouncingScrollPhysics(),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: GestureDetector(
                  onTap: () => Get.toNamed(AppRoutes.search),
                  child: SizedBox(
                    height: 55,
                    child: TextField(
                      controller: controller.searchController,
                      cursorColor: AppColors.primary,
                      onTapOutside: (event) =>
                          FocusManager.instance.primaryFocus?.unfocus(),
                      decoration: InputDecoration(
                        hintText: 'Search...',
                        // Add a clear button to the search bar
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () => controller.searchController?.clear(),
                        ),
                        // Add a search icon or button to the search bar
                        prefixIcon: const Icon(
                          Icons.search,
                          // color: AppColors.primary,
                        ),
                        prefixIconColor: MaterialStateColor.resolveWith(
                            (states) => states.contains(MaterialState.focused)
                                ? AppColors.primary
                                : Colors.grey),
                        suffixIconColor: MaterialStateColor.resolveWith(
                            (states) => states.contains(MaterialState.focused)
                                ? AppColors.primary
                                : Colors.grey),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide:
                              const BorderSide(color: AppColors.primary),
                        ),
                      ),
                      enabled: false,
                    ),
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.02),
              CarouselSlider.builder(
                itemCount: 4,
                itemBuilder:
                    (BuildContext context, int itemIndex, int pageViewIndex) {
                  return Card(
                    color: Colors.white, // Backgrond color
                    elevation: 0.8,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(2),
                    ),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(2),
                      splashColor: AppColors.subBG, // Splash color
                      onTap: () {},
                      child: SizedBox(
                        width: size.width * 0.8,
                        child: Padding(
                          padding: const EdgeInsets.only(
                            top: 20,
                            left: 20,
                            right: 20,
                            bottom: 20,
                          ),
                          child: Column(
                            children: [
                              GetBuilder(
                                  init: HomeController(),
                                  builder: (homeController) {
                                    return Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        CircleAvatar(
                                          backgroundColor: AppColors.subBG,
                                          radius: 20,
                                          child: Text(
                                            homeController
                                                        .currentDoctorFirstName ==
                                                    null
                                                ? ''
                                                : '${homeController.currentDoctorFirstName![0].capitalizeFirst}${homeController.currentDoctorLastName![0].capitalizeFirst}',
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
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
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          homeController
                                                                      .currentDoctorFirstName ==
                                                                  null
                                                              ? ''
                                                              : 'Dr.${homeController.currentDoctorFirstName!.capitalizeFirst} ${homeController.currentDoctorLastName!.capitalizeFirst}',
                                                          style:
                                                              const TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                AppColors.title,
                                                          ),
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                        Text(
                                                          homeController
                                                                      .currentDoctorCreatedAt ==
                                                                  null
                                                              ? ''
                                                              : timeago
                                                                  .format(DateTime.parse(
                                                                      homeController
                                                                          .currentDoctorCreatedAt!))
                                                                  .toString(),
                                                          style:
                                                              const TextStyle(
                                                            color: AppColors
                                                                .description,
                                                            fontSize: 10,
                                                          ),
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(height: 4),
                                                    Text(
                                                      homeController
                                                                  .currentDoctorJob ==
                                                              null
                                                          ? ''
                                                          : homeController
                                                              .currentDoctorJob!,
                                                      style: const TextStyle(
                                                        color: AppColors
                                                            .description,
                                                        fontSize: 13,
                                                      ),
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    );
                                  }),
                              const Divider(),
                              Expanded(
                                child: SizedBox(
                                  width: double.infinity,
                                  height: size.height * 0.06,
                                  child: const Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Flexible(
                                        child: Text(
                                          'Welcome to EgyAkin App.Welcome to EgyAkin App.Welcome to EgyAkin App.Welcome to EgyAkin App.Welcome to EgyAkin App.Welcome to EgyAkin App.Welcome to EgyAkin App.Welcome to EgyAkin App.Welcome to EgyAkin App.Welcome to EgyAkin App.',
                                          style: TextStyle(
                                              color: AppColors.title,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 13,
                                              height: 1.3),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 4,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
                options: CarouselOptions(
                  height: size.height * 0.25,
                  aspectRatio: 16 / 9,
                  viewportFraction: 0.8,
                  initialPage: Random().nextInt(3),
                  enableInfiniteScroll: true,
                  reverse: false,
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 3),
                  autoPlayAnimationDuration: const Duration(milliseconds: 800),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enlargeCenterPage: true,
                  enlargeFactor: 0.3,
                  scrollDirection: Axis.horizontal,
                ),
              ),
              GetBuilder(
                init: HomeController(),
                builder: (homeController) {
                  return Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                    controller.isCurrentPatientsLoading.value ||
                                            controller.currentPatinetList ==
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
                            ? SizedBox(
                                height: size.height * 0.26,
                                child: Image.asset(
                                  AppImages.notFound,
                                  height: size.height * 0.2,
                                  width: size.width * 0.45,
                                  fit: BoxFit.fill,
                                ),
                              )
                            : SizedBox(
                                height: size.height * 0.22,
                                child: ListView.builder(
                                  physics: const BouncingScrollPhysics(),
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  padding: const EdgeInsets.only(
                                    left: 20,
                                  ),
                                  itemCount: homeController
                                              .currentPatinetList!.length <
                                          5
                                      ? homeController
                                          .currentPatinetList!.length
                                      : 5,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    var patient =
                                        controller.currentPatinetList![index];
                                    return PatientCard(
                                      size: size,
                                      isCurrentDoctorPatients: true,
                                      patientName: patient.name ?? '',
                                      drName:
                                          'Dr.${controller.currentDoctorFirstName!.capitalizeFirst ?? ''} ${controller.currentDoctorLastName!.capitalizeFirst ?? ''}',
                                      hospital: homeController
                                              .currentPatinetList![index]
                                              .hospital ??
                                          '',
                                      createdAt: homeController
                                              .currentPatinetList![index]
                                              .updatedAt ??
                                          '',
                                      updatedAt: homeController
                                              .currentPatinetList![index]
                                              .updatedAt ??
                                          '',
                                      submitStatus: homeController
                                                  .currentPatinetList![index]
                                                  .sections ==
                                              null
                                          ? false
                                          : homeController
                                                  .currentPatinetList![index]
                                                  .sections!
                                                  .submitStatus ??
                                              false,
                                      isOutcomeStatus:
                                          patient.sections!.outcomeStatus!,
                                      onOutcomeTap: () => Get.toNamed(
                                        AppRoutes.outcome,
                                        arguments: [
                                          patient.sections!.outcomeStatus,
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
                                        Get.toNamed(AppRoutes.patientSections,
                                            // arguments: homeController
                                            //     .currentPatinetList![index],
                                            arguments: [
                                              patient.id,
                                              patient.doctorModel!.id,
                                              patient.name,
                                              patient.sections!.submitStatus,
                                            ]);
                                      },
                                      onLongPress: () {},
                                    );
                                  },
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
                                        controller.allPatinetList == null
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
                          ? SizedBox(
                              height: size.height * 0.22,
                              child: Image.asset(
                                AppImages.notFound,
                                height: size.height * 0.2,
                                width: size.width * 0.45,
                                fit: BoxFit.fill,
                              ),
                            )
                          : SizedBox(
                              height: size.height * 0.22,
                              child: ListView.builder(
                                physics: const BouncingScrollPhysics(),
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                padding: const EdgeInsets.only(
                                  left: 20,
                                ),
                                itemCount: controller.allPatinetList!.length < 5
                                    ? controller.allPatinetList!.length
                                    : 5,
                                itemBuilder: (BuildContext context, int index) {
                                  var patient =
                                      controller.allPatinetList![index];
                                  return PatientCard(
                                    size: size,
                                    isCurrentDoctorPatients: false,
                                    patientName: patient.name!,
                                    drName:
                                        'Dr.${patient.doctorModel!.firstName == null ? '' : patient.doctorModel!.firstName!.capitalizeFirst} ${patient.doctorModel!.lastName == null ? '' : patient.doctorModel!.lastName!.capitalizeFirst}',
                                    createdAt: patient.updatedAt!,
                                    hospital: patient.hospital!,
                                    updatedAt: patient.updatedAt!,
                                    isOutcomeStatus:
                                        patient.sections!.outcomeStatus!,
                                    onOutcomeTap: () => Get.toNamed(
                                      AppRoutes.outcome,
                                      arguments: [
                                        patient.sections!.outcomeStatus,
                                        patient.id,
                                        patient.name
                                      ],
                                    ),
                                    submitStatus: patient.sections == null
                                        ? false
                                        : patient.sections!.submitStatus ??
                                            false,
                                    onTap: () {
                                      Get.toNamed(
                                        AppRoutes.patientSections,
                                        // arguments:
                                        //     controller.allPatinetList![index],
                                        arguments: [
                                          patient.id,
                                          patient.doctorModel!.id,
                                          patient.name,
                                          patient.sections!.submitStatus,
                                        ],
                                      );
                                    },
                                    onAddCommentTap: () {
                                      Get.toNamed(
                                        AppRoutes.comments,
                                        arguments: [
                                          patient.id,
                                          patient.name,
                                        ],
                                      );
                                    },
                                    onLongPress: () {},
                                  );
                                },
                              ),
                            ),
                ),
              ),
              SizedBox(height: size.height * 0.1),
            ],
          ),
        ),
      ),
    );
  }
}
