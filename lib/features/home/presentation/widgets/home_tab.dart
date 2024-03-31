import 'dart:developer';

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
      onRefresh: () async => await cubit.getHome(),
      child: Column(
        children: [
          BlocConsumer<HomeCubit, HomeState>(
            listener: (context, state) {
              state.maybeWhen(
                orElse: () {},
                loaded: (homeData, currentDoctorModel, dotsPosition,
                    notificationDataModel) {
                  // context
                  // .read<NotificationCubit>()
                  // .fetchNotifications(notificationDataModel.data ?? []);
                },
              );
            },
            builder: (context, state) {
              return state.maybeWhen(
                loaded: (homeData, currentDoctorModel, dotsPosition,
                    notificationData) {
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
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const HomeSearchBotton(),
                    PostsSliderAndDots(cubit: cubit),
                    SizedBox(height: size.height * 0.5),
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
