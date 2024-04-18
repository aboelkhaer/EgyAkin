import '../../../../exports.dart';

class HomeTab extends StatelessWidget {
  final HomeCubit cubit;
  const HomeTab({
    super.key,
    required this.cubit,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return RefreshIndicator(
      color: AppColors.primary,
      onRefresh: () async {
        await cubit.getHome();
        if (cubit.scrollController.hasClients) {
          cubit.scrollController.animateTo(0,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut);
        }
      },
      child: Column(
        children: [
          BlocConsumer<HomeCubit, HomeState>(
            listener: (context, state) {
              state.maybeWhen(
                orElse: () {},
                loaded:
                    (homeData, currentDoctorModel, dotsPosition, homeIndex) {
                  // context
                  // .read<NotificationCubit>()
                  // .fetchNotifications(notificationDataModel.data ?? []);
                },
                error: (message) {
                  customSnackBar(message: message, context: context);
                },
              );
            },
            builder: (context, state) {
              return state.maybeWhen(
                loaded:
                    (homeData, currentDoctorModel, dotsPosition, homeIndex) {
                  return CheckIfVerified(
                    verified: homeData.verified!,
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
                    const HomeSearchBotton(),
                    PostsSliderAndDots(
                      cubit: cubit,
                    ),
                    SizedBox(height: 30.h),
                    const YourPatientSection(),
                    const AllPatientSection(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
