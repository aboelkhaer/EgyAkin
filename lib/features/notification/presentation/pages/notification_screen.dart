import 'package:egy_akin/features/notification/presentation/widgets/notifications_view.dart';

import '../../../../exports.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    NotificationCubit cubit = NotificationCubit.get(context);
    return RefreshIndicator(
      onRefresh: () async {
        // return await cubit.onRefreshInicator();
        return await cubit.getAllNotifications();
      },
      color: AppColors.primary,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              BlocBuilder<NotificationCubit, NotificationState>(
                builder: (context, state) {
                  return state.maybeWhen(
                    orElse: () {
                      return const ShimmerLoadingPatientsCards(
                        ishorizontal: false,
                      );
                    },
                    loaded: (notificationData) {
                      return notificationData.todayRecords!.isEmpty
                          ? const SizedBox.shrink()
                          : Column(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      'Today',
                                      style: TextStyle(
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10.h),
                                NotificationsView(
                                    notificationsModel:
                                        notificationData.todayRecords!),
                              ],
                            );
                    },
                  );
                },
              ),
              SizedBox(height: 15.h),
              BlocBuilder<NotificationCubit, NotificationState>(
                builder: (context, state) {
                  return state.maybeWhen(
                    orElse: () {
                      return const ShimmerLoadingPatientsCards(
                        ishorizontal: false,
                      );
                    },
                    loaded: (notificationData) {
                      return Column(
                        children: [
                          notificationData.recentRecords!.isEmpty
                              ? const SizedBox.shrink()
                              : Column(
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          'Recent',
                                          style: TextStyle(
                                            fontSize: 18.sp,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10.h),
                                  ],
                                ),
                          NotificationsView(
                              notificationsModel:
                                  notificationData.recentRecords!),
                        ],
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
