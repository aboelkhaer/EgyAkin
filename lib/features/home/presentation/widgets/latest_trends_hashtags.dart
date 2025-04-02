import 'package:egy_akin/exports.dart';

class LatestTrendsHashtags extends StatelessWidget {
  const LatestTrendsHashtags({super.key});

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
            if (isVerifiedUser(homeData.isSyndicateCardRequired)) {
              return const SizedBox.shrink();
            }

            return Card(
              color: Colors.white,
              elevation: 0.8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              child: GestureDetector(
                onTap: () {
                  navigatorKey.currentState?.pushNamed(
                    AppRoutes.community,
                    arguments: AppRoutesArgs.communityRouteArgs(
                      homeDataModel: homeData,
                      currentDoctorModel: currentDoctorModel,
                      initialTab: 1,
                    ),
                  );
                },
                child: Container(
                  width: double.infinity,
                  height: 100.h,
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Expanded(
                        child: Image.asset(
                          'assets/images/trend.jpg',
                          fit: BoxFit.cover,
                        ),
                      ),
                      VerticalDivider(
                        color: Colors.grey.shade200,
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            const SizedBox(width: 5),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ...homeData.data!.trendsHashtags!
                                    .take(6)
                                    .toList()
                                    .asMap()
                                    .entries
                                    .map((entry) => Text(
                                          '${entry.key + 1}. #${entry.value.tag}',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w500,
                                            color: Colors.blue,
                                          ),
                                        )),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
