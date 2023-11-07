import '../../../../exports.dart';

class CustomDrawerWidget extends GetView<LogoutController> {
  final int currentDoctorPatientsCount;
  const CustomDrawerWidget({
    super.key,
    required this.currentDoctorPatientsCount,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        physics: const BouncingScrollPhysics(),
        children: [
          GestureDetector(
            onTap: () {
              Get.back();
              Get.toNamed(AppRoutes.doctorProfile);
            },
            child: DrawerHeader(
              child: GetBuilder<HomeController>(
                init: HomeController(),
                builder: (homeController) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        backgroundColor: AppColors.subBG,
                        radius: 25,
                        child: Text(
                          homeController.currentDoctorFirstName == null ||
                                  homeController.currentDoctorLastName == null
                              ? ''
                              : homeController.currentDoctorFirstName![0]
                                      .toUpperCase()
                                      .toString() +
                                  homeController.currentDoctorLastName![0]
                                      .toUpperCase()
                                      .toString(),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        homeController.currentDoctorFirstName == null ||
                                homeController.currentDoctorLastName == null
                            ? ''
                            : 'Dr.${homeController.currentDoctorFirstName.toString().capitalizeFirst} ${homeController.currentDoctorLastName.toString().capitalizeFirst}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 5),
                      Text(
                        homeController.currentDoctorJob == null
                            ? ''
                            : homeController.currentDoctorJob!.toString(),
                        style: const TextStyle(color: AppColors.description),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
          ListTile(
            title: const Text('Contact us'),
            onTap: () {
              Get.back();
              Get.toNamed(AppRoutes.contactUs);
            },
          ),
          ListTile(
            title: const Text('Logout'),
            onTap: () {
              Get.back();
              controller.logout();
            },
          ),
        ],
      ),
    );
  }
}
