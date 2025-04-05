import '../../../../exports.dart';

class CommunityButton extends StatelessWidget {
  const CommunityButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
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
            changesCounter,
          ) {
            return Column(
              children: [
                SizedBox(height: 10.h),
                GestureDetector(
                  onTap: () {
                    navigatorKey.currentState?.pushNamed(
                      AppRoutes.community,
                      arguments: AppRoutesArgs.communityRouteArgs(
                        homeDataModel: homeData,
                        currentDoctorModel: currentDoctorModel,
                        initialTab: 0,
                      ),
                    );
                  },
                  child: TweenAnimationBuilder(
                    tween: Tween(begin: 1.0, end: 1.05),
                    duration: const Duration(milliseconds: 1000),
                    curve: Curves.easeInOut,
                    builder: (context, value, child) {
                      return Transform.scale(
                        scale: value,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 16.w, vertical: 10.h),
                          margin: EdgeInsets.symmetric(
                              horizontal: 20.w, vertical: 10.h),
                          width: double.infinity,
                          decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                  colors: [AppColors.primary, Colors.white54],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight),
                              borderRadius: BorderRadius.circular(30),
                              boxShadow: [
                                BoxShadow(
                                    color: AppColors.primary.withOpacity(0.4),
                                    blurRadius: 10,
                                    spreadRadius: 2)
                              ]),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.rocket_launch,
                                  color: Colors.white),
                              SizedBox(width: 8.w),
                              const Text('EXPLORE COMMUNITY',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 1)),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
