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
  late final HomeCubit homeCubit; // Store a reference to the cubit

  @override
  void initState() {
    super.initState();
    homeCubit = context.read<HomeCubit>(); // Initialize cubit reference
    homeCubit.homeTabScrollController = ScrollController();
  }

  @override
  void dispose() {
    if (!homeCubit.isClosed && homeCubit.homeTabScrollController.hasClients) {
      homeCubit.homeTabScrollController.dispose();
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
            widget.cubit.currentDoctorModel.email == 'aboelkhaer@yandex.com'
                ? const SizedBox.shrink()
                : BlocConsumer<HomeCubit, HomeState>(
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
                              context
                                  .read<HomeCubit>()
                                  .signOutForUnUnauthenticated();
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
                      widget.cubit.currentDoctorModel.email ==
                              'aboelkhaer@yandex.com'
                          ? const SizedBox.shrink()
                          : PostsSliderAndDots(cubit: widget.cubit),
                      widget.cubit.currentDoctorModel.email ==
                              'aboelkhaer@yandex.com'
                          ? const SizedBox.shrink()
                          : SizedBox(height: 10.h),
                      TextButton(
                          onPressed: () {
                            navigatorKey.currentState?.pushNamed(
                              AppRoutes.community,
                              arguments: AppRoutesArgs.communityRouteArgs(
                                homeDataModel: widget.cubit.homeDataModel,
                                currentDoctorModel:
                                    widget.cubit.currentDoctorModel,
                                initialTab: 0,
                              ),
                            );
                          },
                          child: const Text('hello')),
                      const DoctorsActivation(),
                      SizedBox(height: 10.h),
                      TopDoctors(cubit: widget.cubit),
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
