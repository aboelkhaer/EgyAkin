import 'dart:developer';

import 'package:egy_akin/app/shared/functions/update_dialog.dart';
import 'package:egy_akin/features/home/presentation/widgets/top_doctors.dart';

import '../../../../exports.dart';

class HomeTab extends StatelessWidget {
  final HomeCubit cubit;
  const HomeTab({
    super.key,
    required this.cubit,
  });

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      color: AppColors.primary,
      onRefresh: () {
        // if (cubit.scrollController.hasClients) {
        //   cubit.scrollController.animateTo(0,
        //       duration: const Duration(milliseconds: 300),
        //       curve: Curves.easeInOut);
        // }
        animateToTopOfScreen(cubit.scrollController);

        if (cubit.isUnreadNotification) {
          context.read<NotificationCubit>().getAllNotifications();
        }
        return cubit.getHome();
      },
      child: Container(
        color: Colors.grey.shade100,
        child: Column(
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
                  ) {},
                  error: (message) {
                    customSnackBar(message: message, context: context);
                  },
                );
              },
              builder: (context, state) {
                return state.maybeWhen(
                  loaded: (
                    homeData,
                    currentDoctorModel,
                    dotsPosition,
                    homeIndex,
                    isUploadingSyndicateCard,
                    isUploadedSyndicateCard,
                    message,
                    checkUpdateMessageCounter,
                  ) {
                    return CheckIfVerified(
                      verified: homeData.verified!,
                      isSyndicateCardRequired:
                          homeData.isSyndicateCardRequired!,
                    );
                  },
                  orElse: () => const SizedBox.shrink(),
                );
              },
            ),
            Expanded(
              child: SingleChildScrollView(
                controller: cubit.scrollController,
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      BlocBuilder<HomeCubit, HomeState>(
                        builder: (context, state) {
                          return state.maybeWhen(
                            orElse: () {
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
                            ) {
                              return HomeSearchBotton(
                                currentDoctorModel: currentDoctorModel,
                                verified: homeData.verified!,
                                isSyndicateCardRequired:
                                    homeData.isSyndicateCardRequired!,
                                currentDoctorPoints:
                                    int.parse(homeData.scoreValue!),
                                currentDoctorRole: homeData.role.toString(),
                                homeDataModel: homeData,
                              );
                            },
                          );
                        },
                      ),
                      // CustomElevatedButton(
                      //     onPressed: () {
                      //       showUpdateDialog(
                      //         context: context,
                      //         isUpdateMessageSeen: cubit.isUpdateMessageSeen,
                      //         onDismissed: () {
                      //           context
                      //               .read<HomeCubit>()
                      //               .setUpdateMessageStatusToLocal();
                      //         },
                      //       );
                      //     },
                      //     title: 'hello'),
                      PostsSliderAndDots(cubit: cubit),
                      SizedBox(height: 10.h),
                      const TopDoctors(),
                      const YourPatientSection(),
                      const AllPatientSection(),
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
