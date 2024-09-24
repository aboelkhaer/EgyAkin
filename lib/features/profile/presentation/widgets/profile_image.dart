import '../../../../exports.dart';

class ProfileImage extends StatelessWidget {
  final ProfileCubit cubit;
  final HomeModelResponse homeDataModel;
  const ProfileImage({
    super.key,
    required this.cubit,
    required this.homeDataModel,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CircleAvatar(
          radius: 50.r, // hidden widget to add stack raduis size
          backgroundColor: AppColors.transparent,
          child: Container(
            margin: const EdgeInsets.only(top: 3),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.4),
                  spreadRadius: 5,
                  blurRadius: 9,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: CircleAvatar(
              radius: 35.r, // border size which contain profile picture
              backgroundColor: AppColors.primary.withOpacity(0.4),
              child: CircleAvatar(
                radius: 33.r,
                backgroundColor: AppColors.white,
                child: BlocBuilder<ProfileCubit, ProfileState>(
                  builder: (context, state) {
                    return state.maybeWhen(
                      orElse: () {
                        return GestureDetector(
                          onTap: () {
                            navigatorKey.currentState?.pushNamed(
                              AppRoutes.doctorInfoView,
                              arguments: AppRoutesArgs.doctorInfoViewRouteArgs(
                                doctorId: cubit.currentDoctor.id.toString(),
                                currentDoctorModel: cubit.currentDoctor,
                                isSyndicateCardRequired: homeDataModel
                                    .isSyndicateCardRequired
                                    .toString(),
                                accountVerification: homeDataModel.verified!,
                                currentDoctorRole:
                                    homeDataModel.role.toString(),
                                currentDoctorPoints:
                                    int.parse(homeDataModel.scoreValue!),
                                homeDataModel: homeDataModel,
                                initialIndex: 0,
                                isNavigateToTheButtonOfInformationTab: false,
                              ),
                            );
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(80.r),
                            child: CachedNetworkImage(
                              imageUrl: cubit.currentDoctor.image.toString(),
                              width: 100.w,
                              height: 100.h,
                              fadeInDuration: const Duration(milliseconds: 200),
                              fadeInCurve: Curves.easeIn,
                              fit: BoxFit.cover,
                              placeholder: (context, url) =>
                                  Lottie.asset(AppImages.imageLoader),
                              errorWidget: (context, url, error) {
                                return Container(
                                  color: Colors.transparent,
                                  child: const Center(
                                    child: Icon(
                                      Icons.error_outline,
                                      color: AppColors.primary,
                                      size: 40.0,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        );
                      },
                      loading: () {
                        return Center(
                          child: Lottie.asset(AppImages.imageLoader),
                        );
                      },
                      loaded: (doctorModel, isLoadedImage) {
                        return cubit.imagePicked != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(80.r),
                                child: Image.file(
                                  cubit.imagePicked!,
                                  fit: BoxFit.cover,
                                  width: 100.w,
                                  height: 100.h,
                                ),
                              )
                            : GestureDetector(
                                onTap: () {
                                  navigatorKey.currentState?.pushNamed(
                                    AppRoutes.doctorInfoView,
                                    arguments:
                                        AppRoutesArgs.doctorInfoViewRouteArgs(
                                      doctorId:
                                          cubit.currentDoctor.id.toString(),
                                      initialIndex: 0,
                                      currentDoctorModel: cubit.currentDoctor,
                                      isSyndicateCardRequired: homeDataModel
                                          .isSyndicateCardRequired
                                          .toString(),
                                      accountVerification:
                                          homeDataModel.verified!,
                                      currentDoctorRole:
                                          homeDataModel.role.toString(),
                                      currentDoctorPoints:
                                          int.parse(homeDataModel.scoreValue!),
                                      homeDataModel: homeDataModel,
                                      isNavigateToTheButtonOfInformationTab:
                                          false,
                                    ),
                                  );
                                },
                                child: GestureDetector(
                                  onTap: () {
                                    navigatorKey.currentState?.pushNamed(
                                      AppRoutes.doctorInfoView,
                                      arguments:
                                          AppRoutesArgs.doctorInfoViewRouteArgs(
                                        doctorId:
                                            cubit.currentDoctor.id.toString(),
                                        currentDoctorModel: cubit.currentDoctor,
                                        initialIndex: 0,
                                        isSyndicateCardRequired: homeDataModel
                                            .isSyndicateCardRequired
                                            .toString(),
                                        accountVerification:
                                            homeDataModel.verified!,
                                        currentDoctorRole:
                                            homeDataModel.role.toString(),
                                        currentDoctorPoints: int.parse(
                                            homeDataModel.scoreValue!),
                                        homeDataModel: homeDataModel,
                                        isNavigateToTheButtonOfInformationTab:
                                            false,
                                      ),
                                    );
                                  },
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(80.r),
                                    child: CachedNetworkImage(
                                      imageUrl: doctorModel.image.toString(),
                                      width: 100.w,
                                      height: 100.h,
                                      fadeInDuration:
                                          const Duration(milliseconds: 200),
                                      fadeInCurve: Curves.easeIn,
                                      fit: BoxFit.cover,
                                      placeholder: (context, url) =>
                                          Lottie.asset(AppImages.imageLoader),
                                      errorWidget: (context, url, error) {
                                        return Container(
                                          color: Colors.transparent,
                                          child: const Center(
                                            child: Icon(
                                              Icons.error_outline,
                                              color: AppColors.primary,
                                              size: 40.0,
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              );
                      },
                    );
                  },
                ),
              ),
            ),
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 2.h,
          child: GestureDetector(
            onTap: () async {
              cubit.uploadProfileImage();
            },
            child: CircleAvatar(
              radius: 15.r, // white border for camera icon
              backgroundColor: AppColors.white,
              child: CircleAvatar(
                radius: 13.r, // camera background
                backgroundColor: AppColors.primary.withOpacity(0.8),
                child: Icon(
                  Icons.camera_alt_outlined,
                  size: 16.r,
                  color: AppColors.white,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
