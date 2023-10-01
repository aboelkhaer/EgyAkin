import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';

import '../../../exports.dart';
import 'widgets/custom_drawer.dart';
import 'widgets/patient_card.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var logoutController = Get.find<LogoutController>();
    var authRepo = Get.find<AuthRepository>();
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
        elevation: 0,
      ),
      drawer: const CustomDrawerWidget(),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {},
          label: const Row(
            children: [
              Icon(Icons.add),
              Text('Add patient'),
            ],
          )),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // ElevatedButton(
            //     onPressed: () {
            //       logoutController.logout();
            //     },
            //     child: const Text('hello')),
            // Text(controller.firstName.toString()),
            Padding(
              padding: const EdgeInsets.all(20.0),
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
                      onPressed: () => controller.searchController.clear(),
                    ),
                    // Add a search icon or button to the search bar
                    prefixIcon: const Icon(
                      Icons.search,
                      // color: AppColors.primary,
                    ),
                    prefixIconColor: MaterialStateColor.resolveWith((states) =>
                        states.contains(MaterialState.focused)
                            ? AppColors.primary
                            : Colors.grey),
                    suffixIconColor: MaterialStateColor.resolveWith((states) =>
                        states.contains(MaterialState.focused)
                            ? AppColors.primary
                            : Colors.grey),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(color: AppColors.primary),
                    ),
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
                            GetBuilder<HomeController>(
                                init: HomeController(),
                                builder: (homeController) {
                                  return Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          CircleAvatar(
                                            backgroundColor: AppColors.subBG,
                                            radius: 20,
                                            child: Text(
                                              controller.currentDoctorFirstName ==
                                                          null ||
                                                      controller
                                                              .currentDoctorLastName ==
                                                          null
                                                  ? ''
                                                  : controller
                                                          .currentDoctorFirstName![
                                                              0]
                                                          .toUpperCase()
                                                          .toString() +
                                                      controller
                                                          .currentDoctorLastName![
                                                              0]
                                                          .toUpperCase()
                                                          .toString(),
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: AppColors.primary),
                                            ),
                                          ),
                                          const SizedBox(width: 8),
                                          Row(
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    controller.currentDoctorFirstName ==
                                                                null ||
                                                            controller
                                                                    .currentDoctorLastName ==
                                                                null
                                                        ? ''
                                                        : 'Dr.${controller.currentDoctorFirstName!.capitalizeFirst} ${controller.currentDoctorLastName!.capitalizeFirst}',
                                                    style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: AppColors.title,
                                                    ),
                                                  ),
                                                  Text(
                                                    controller.currentDoctorJob ==
                                                            null
                                                        ? ''
                                                        : controller
                                                            .currentDoctorJob!
                                                            .capitalizeFirst
                                                            .toString(),
                                                    style: const TextStyle(
                                                      color:
                                                          AppColors.description,
                                                      fontSize: 13,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
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
                                          controller.currentPatinetList == null
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
                      ? const CircularProgressIndicator()
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
                              height: size.height * 0.26,
                              child: ListView.builder(
                                physics: const BouncingScrollPhysics(),
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                padding: const EdgeInsets.only(
                                  left: 20,
                                ),
                                itemCount: 5,
                                itemBuilder: (BuildContext context, int index) {
                                  return PatientCard(
                                    size: size,
                                    isCurrentDoctorPatients: true,
                                    patientName: homeController
                                        .currentPatinetList![index].name!,
                                    drName:
                                        'Dr.${controller.currentDoctorFirstName!.capitalizeFirst} ${controller.currentDoctorLastName!.capitalizeFirst}',
                                    hospital: homeController
                                        .currentPatinetList![index].hospital!,
                                    createdAt: homeController
                                        .currentPatinetList![index].createdAt!,
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
                    ? const CircularProgressIndicator()
                    : SizedBox(
                        height: size.height * 0.26,
                        child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.only(
                            left: 20,
                          ),
                          itemCount: 5,
                          itemBuilder: (BuildContext context, int index) {
                            return PatientCard(
                              size: size,
                              isCurrentDoctorPatients: false,
                              patientName:
                                  controller.allPatinetList![index].name!,
                              drName:
                                  'Dr.${controller.allPatinetList![index].ownerModel!.name!.capitalizeFirst} ${controller.allPatinetList![index].ownerModel!.lastName!.capitalizeFirst}',
                              createdAt:
                                  controller.allPatinetList![index].createdAt!,
                              hospital:
                                  controller.allPatinetList![index].hospital!,
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
    );
  }
}
