import 'package:egy_akin/app/shared/functions/blocked_dialog.dart';

import '../../../../exports.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({
    super.key,
    required this.cubit,
  });

  final HomeCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () async {
            if (cubit.tabsController.index != 2) {
              cubit.tabsController.jumpToTab(2);
              cubit.hideHomeHeader(2);
            }
          },
          child: Row(
            children: [
              Column(
                children: [
                  Container(
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
                    child: BlocBuilder<HomeCubit, HomeState>(
                      builder: (context, state) {
                        return state.maybeWhen(
                          orElse: () {
                            return ClipRRect(
                              borderRadius: BorderRadius.circular(80.r),
                              child: CircleAvatar(
                                radius: 20.r,
                                backgroundColor:
                                    AppColors.primary.withOpacity(0.8),
                                child: cubit.currentDoctorModel.image == null
                                    ? Text(
                                        cubit.currentDoctorModel.firstName ==
                                                null
                                            ? ''
                                            : cubit.currentDoctorModel
                                                .firstName![0]
                                                .toUpperCase(),
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16.sp,
                                          color: Colors.white,
                                        ),
                                      )
                                    : CustomCachedNetworkImage(
                                        imageUrl: cubit.currentDoctorModel.image
                                            .toString(),
                                        height: 100.h,
                                        width: 100.w,
                                      ),
                              ),
                            );
                          },
                          loaded: (
                            homeData,
                            currentDoctorModel,
                            dotsPosition,
                            homeIndex,
                            isUploadingSyndicateCard,
                            isUploadedSyndicateCard,
                            message,
                            checkUpdateMessageCounter,
                            isUserBlocked,
                            changesCounter,
                          ) {
                            return ClipRRect(
                              borderRadius: BorderRadius.circular(80.r),
                              child: CircleAvatar(
                                radius: 20.r,
                                backgroundColor:
                                    AppColors.primary.withOpacity(0.8),
                                child: currentDoctorModel.image == null
                                    ? Text(
                                        currentDoctorModel.firstName == null
                                            ? ''
                                            : cubit.currentDoctorModel
                                                .firstName![0]
                                                .toUpperCase(),
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16.sp,
                                          color: Colors.white,
                                        ),
                                      )
                                    : CustomCachedNetworkImage(
                                        imageUrl:
                                            currentDoctorModel.image.toString(),
                                        height: 100.h,
                                        width: 100.w,
                                      ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(width: 8.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      BlocConsumer<HomeCubit, HomeState>(
                        listener: (context, state) {
                          state.maybeWhen(
                            orElse: () {},
                            loaded: (
                              homeData,
                              currentDoctorModel,
                              dotsPosition,
                              homeIndex,
                              isUploadingSyndicateCard,
                              isUploadedSyndicateCard,
                              message,
                              checkUpdateMessageCounter,
                              isUserBlocked,
                              changesCounter,
                            ) {
                              // context
                              //     .read<ProfileCubit>()
                              //     .getDoctorDataFromHomeCubit(
                              //         currentDoctorModel);
                            },
                          );
                        },
                        builder: (context, state) {
                          return Text(
                            cubit.currentDoctorModel.firstName == null
                                ? ''
                                : doctorName(
                                    firstName:
                                        cubit.currentDoctorModel.firstName ??
                                            '',
                                    lastName:
                                        cubit.currentDoctorModel.lastName ?? '',
                                    role: cubit
                                        .homeDataModel.isSyndicateCardRequired
                                        .toString(),
                                  ),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey.shade700,
                              fontSize: 14.sp,
                            ),
                          );
                        },
                      ),
                      BlocBuilder<HomeCubit, HomeState>(
                        builder: (context, state) {
                          return state.maybeWhen(
                            orElse: () {
                              return const SizedBox.shrink();
                            },
                            loading: (tabIndex) {
                              if (cubit.isSyndicateCardRequired == 'Verified') {
                                return const VerificationIcon(
                                  duration: 300,
                                );
                              }
                              return const SizedBox.shrink();
                            },
                            loaded: (
                              homeData,
                              currentDoctorModel,
                              dotsPosition,
                              homeIndex,
                              isUploadingSyndicateCard,
                              isUploadedSyndicateCard,
                              message,
                              checkUpdateMessageCounter,
                              isUserBlocked,
                              changesCounter,
                            ) {
                              if (homeData.isSyndicateCardRequired ==
                                  'Verified') {
                                return const VerificationIcon(
                                  duration: 300,
                                );
                              }
                              return const SizedBox.shrink();
                            },
                          );
                        },
                      )
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BlocBuilder<HomeCubit, HomeState>(
                        builder: (context, state) {
                          return Text(
                            capitalizeFirstText(
                                cubit.currentDoctorModel.specialty ??
                                    AppStrings.empty)!,
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 10.sp,
                                color: Colors.grey.shade600),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
        BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            return state.maybeWhen(
              orElse: () {
                return IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.add,
                    color: AppColors.description,
                    size: 30.r,
                  ),
                );
              },
              loaded: (
                homeData,
                currentDoctorModel,
                dotsPosition,
                homeIndex,
                isUploadingSyndicateCard,
                isUploadedSyndicateCard,
                message,
                checkUpdateMessageCounter,
                isUserBlocked,
                changesCounter,
              ) {
                if (!isVerifiedUser(homeData.isSyndicateCardRequired)) {
                  return Tooltip(
                    message: 'Add Post',
                    child: IconButton(
                      onPressed: () {
                        navigatorKey.currentState?.pushNamed(
                          AppRoutes.createPostInCommunity,
                          arguments:
                              AppRoutesArgs.createPostInCommunityRouteArgs(
                            currentDoctorModel: currentDoctorModel,
                            homeDataModel: homeData,
                          ),
                        );
                      },
                      icon: Icon(
                        Icons.add,
                        color: AppColors.description,
                        size: 30.r,
                      ),
                    ),
                  );
                }
                return Tooltip(
                  message: 'Add patient',
                  child: IconButton(
                    onPressed: () {
                      if (homeData.verified! &&
                          (homeData.isSyndicateCardRequired != 'Required' &&
                              homeData.isSyndicateCardRequired != 'Pending')) {
                        if (homeData.isUserBlocked != true) {
                          navigatorKey.currentState?.pushNamed(
                            AppRoutes.addPatient,
                            arguments: AppRoutesArgs.addPatientRouteArgs(
                              currentDoctorModel: cubit.currentDoctorModel,
                              currentDoctorRole: homeData.role.toString(),
                              currentDoctorPoints:
                                  int.parse(homeData.scoreValue!),
                              homeDataModel: homeData,
                            ),
                          );
                        } else {
                          showBlockedDialog(
                            context: context,
                            onDismissed: () {
                              cubit.signOut();
                              navigatorKey.currentState
                                  ?.pushReplacementNamed(AppRoutes.signIn);
                            },
                          );
                        }
                      }
                      if (!homeData.verified!) {
                        showCustomDialog(
                          context: context,
                          title: AppStrings.emailVerification,
                          description: AppStrings
                              .toAddPatientsYouMustVerifyYourEmailAddress,
                          noColoredButtonOnTap: () {
                            Navigator.of(context).pop();
                          },
                          coloredButtonText: AppStrings.verify,
                          noColoredButtonText: AppStrings.cancel,
                          coloredButtonOnTap: () {
                            Navigator.of(context).pop();
                            navigatorKey.currentState?.pushNamed(
                                AppRoutes.emailVerification,
                                arguments:
                                    AppRoutesArgs.emailVerificationRouteArgs(
                                        currentDoctorModel:
                                            currentDoctorModel));
                          },
                        );
                        return;
                      }
                      if (homeData.isSyndicateCardRequired == 'Required' ||
                          homeData.isSyndicateCardRequired == 'Pending') {
                        showCustomDialog(
                          context: context,
                          title: 'Syndicate card verification',
                          description:
                              'To add patients you must verify your syndicate card.',
                          noColoredButtonOnTap: () {
                            Navigator.of(context).pop();
                          },
                          coloredButtonText: AppStrings.ok,
                          noColoredButtonText: '',
                          isNoColorShow: true,
                          coloredButtonOnTap: () {
                            Navigator.of(context).pop();
                          },
                        );
                      }
                    },
                    icon: Icon(
                      Icons.add,
                      color: AppColors.description,
                      size: 30.r,
                    ),
                  ),
                );
              },
            );
          },
        ),
      ],
    );
  }
}
