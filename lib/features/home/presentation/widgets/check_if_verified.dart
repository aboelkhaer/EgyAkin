import '../../../../exports.dart';

class CheckIfVerified extends StatelessWidget {
  final bool verified;
  final String isSyndicateCardRequired;
  final bool isExitVerification;

  const CheckIfVerified({
    super.key,
    required this.verified,
    required this.isSyndicateCardRequired,
    required this.isExitVerification,
  });

  @override
  Widget build(BuildContext context) {
    if (context.read<HomeCubit>().isExistVerificationBanner != false ||
        context.read<HomeCubit>().isExistVerificationBanner == true) {
      return const SizedBox.shrink();
    }
    if (!verified) {
      return GestureDetector(
        onTap: () {
          navigatorKey.currentState?.pushNamed(AppRoutes.emailVerification,
              arguments: context.read<HomeCubit>().currentDoctorModel);
        },
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              height: 50,
              alignment: Alignment.center,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 7,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    color: Colors.blue.shade600,
                    size: 16,
                  ),
                  const SizedBox(width: 2),
                  Text(
                    'To add patients, you must verify your email address',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Colors.blue.shade600,
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward,
                    size: 18,
                    color: Colors.blue.shade600,
                  ),
                ],
              ),
            ),
            Positioned(
              right: 0,
              bottom: 1,
              child: IconButton(
                onPressed: () {
                  context.read<HomeCubit>().setVerifyBanner();
                },
                icon: const Icon(
                  Icons.cancel,
                  size: 20,
                  color: AppColors.primary,
                ),
              ),
            ),
          ],
        ),
      );
    }
    if (isSyndicateCardRequired == 'Required' ||
        isSyndicateCardRequired == 'Pending') {
      return GestureDetector(
        onTap: () {
          if (isSyndicateCardRequired == 'Required') {
            context.read<HomeCubit>().uploadSyndicateCard();
          }
        },
        child: Container(
          width: double.infinity,
          height: 50,
          alignment: Alignment.center,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 7,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.error_outline,
                color: Colors.blue.shade600,
                size: 16,
              ),
              const SizedBox(width: 2),
              Text(
                isSyndicateCardRequired == 'Required'
                    ? 'To add patients, you must verify your syndicate card'
                    : 'The Syndicate card is being processed for verification.',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Colors.blue.shade600,
                ),
              ),
              isSyndicateCardRequired == 'Required'
                  ? BlocConsumer<HomeCubit, HomeState>(
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
                            changesCounter,
                          ) {
                            if (message.isNotEmpty) {
                              customSnackBar(
                                  context: context, message: message);
                            }
                          },
                        );
                      },
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
                            if (isUploadingSyndicateCard) {
                              return Row(
                                children: [
                                  SizedBox(
                                    width: 3.w,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                    width: 10,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                    ),
                                  ),
                                ],
                              );
                            }
                            return Icon(
                              Icons.arrow_forward,
                              size: 18,
                              color: Colors.blue.shade600,
                            );
                          },
                        );
                      },
                    )
                  : const SizedBox.shrink(),
            ],
          ),
        ),
      );
    }
    return const SizedBox.shrink();
  }
}
