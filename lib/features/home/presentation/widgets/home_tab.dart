import 'package:egy_akin/features/home/presentation/widgets/top_doctors.dart';
import 'package:egy_akin/features/home/presentation/widgets/doctors_activation.dart';
import 'package:flutter/scheduler.dart';

import '../../../../exports.dart';

class HomeTab extends StatefulWidget {
  final HomeCubit cubit;
  const HomeTab({
    super.key,
    required this.cubit,
  });

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  @override
  void initState() {
    context.read<HomeCubit>().homeTabScrollController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    if (context.read<HomeCubit>().isClosed) {
      if (context.read<HomeCubit>().homeTabScrollController.hasClients) {
        context.read<HomeCubit>().homeTabScrollController.dispose();
      }
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      color: AppColors.primary,
      onRefresh: () {
        animateToTopOfScreen(widget.cubit.homeTabScrollController);
        // if (cubit.scrollController.hasClients) {
        //   cubit.scrollController.animateTo(0,
        //       duration: const Duration(milliseconds: 300),
        //       curve: Curves.easeInOut);
        // }

        if (widget.cubit.isUnreadNotification) {
          context.read<NotificationCubit>().getAllNotifications();
        }

        return widget.cubit.getHome();
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
                    isUserBlocked,
                  ) {},
                  error: (message) {
                    customSnackBar(message: message, context: context);
                    // todo fix crash here
                    if (message == 'Unauthenticated.') {
                      SchedulerBinding.instance.addPostFrameCallback((_) {
                        context.read<HomeCubit>().signOutForUnUnauthenticated();
                        navigatorKey.currentState
                            ?.pushReplacementNamed(AppRoutes.signIn);
                      });
                    }
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
                    isUserBlocked,
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
                controller: widget.cubit.homeTabScrollController,
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
                              isUserBlocked,
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
                      PostsSliderAndDots(cubit: widget.cubit),
                      SizedBox(height: 10.h),
                      TextButton(
                          onPressed: () {
                            navigatorKey.currentState?.pushNamed(
                              AppRoutes.community,
                              arguments: AppRoutesArgs.communityRouteArgs(
                                homeDataModel: widget.cubit.homeDataModel,
                                currentDoctorModel:
                                    widget.cubit.currentDoctorModel,
                              ),
                            );
                          },
                          child: const Text('hello')),
                      const DoctorsActivation(),
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
