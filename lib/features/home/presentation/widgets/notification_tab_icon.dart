import 'dart:developer';

import '../../../../exports.dart';

class NotificationTabIcon extends StatelessWidget {
  const NotificationTabIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        const Icon(Icons.notifications),
        BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            return state.maybeWhen(
              orElse: () {
                return const SizedBox.shrink();
              },
              loaded: (homeData, currentDoctorModel, dotsPosition,
                  notificationData, homeIndex) {
                return Positioned(
                  left: 0,
                  right: 10.w,
                  top: 2.h,
                  child: notificationData.unreadCount == null ||
                          notificationData.unreadCount.toString() == '0'
                      ? const SizedBox.shrink()
                      : CircleAvatar(
                          backgroundColor: Colors.red,
                          radius: 5.r,
                          child: Text(
                            notificationData.unreadCount == null
                                ? ''
                                : notificationData.unreadCount.toString(),
                            style: TextStyle(
                                fontSize: 7.sp, color: AppColors.white),
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
