import 'dart:developer';

import '../../../../exports.dart';

class ProfileTabIcon extends StatelessWidget {
  const ProfileTabIcon({super.key});

  @override
  Widget build(BuildContext context) {
    HomeCubit cubit = HomeCubit.get(context);

    return BlocBuilder<HomeCubit, HomeState>(builder: (context, state) {
      return state.maybeWhen(
        orElse: () {
          return const Icon(Icons.person);
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
          return GestureDetector(
            onTap: () {
              log('done');
              if (cubit.tabsController.index != 2) {
                cubit.tabsController.jumpToTab(2);
                cubit.hideHomeHeader(2);
              }
            },
            child: const Icon(Icons.person),
          );
        },
      );
    });
  }
}
