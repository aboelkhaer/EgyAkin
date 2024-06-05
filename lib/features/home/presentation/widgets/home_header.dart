import '../../../../exports.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({
    super.key,
    required this.cubit,
  });

  final HomeCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () async {
            cubit.tabsController.jumpToTab(2);
            cubit.hideHomeHeader();
          },
          child: Row(
            children: [
              Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 3),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.4),
                          spreadRadius: 5,
                          blurRadius: 9,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: BlocBuilder<HomeCubit, HomeState>(
                      builder: (context, state) {
                        return state.maybeWhen(
                          orElse: () {
                            return ClipRRect(
                              borderRadius: BorderRadius.circular(80.r),
                              child: CircleAvatar(
                                radius: 20.r,
                                backgroundColor:
                                    AppColors.primary.withOpacity(0.8),
                                child: cubit.currentDoctorModel.image == null
                                    ? Text(
                                        cubit.currentDoctorModel.firstName ==
                                                null
                                            ? ''
                                            : cubit.currentDoctorModel
                                                .firstName![0]
                                                .toUpperCase(),
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16.sp),
                                      )
                                    : CustomCachedNetworkImage(
                                        imageUrl: cubit.currentDoctorModel.image
                                            .toString(),
                                      ),
                              ),
                            );
                          },
                          loaded: (homeData, currentDoctorModel, dotsPosition,
                              homeIndex) {
                            return ClipRRect(
                              borderRadius: BorderRadius.circular(80.r),
                              child: CircleAvatar(
                                radius: 20.r,
                                backgroundColor:
                                    AppColors.primary.withOpacity(0.8),
                                child: currentDoctorModel.image == null
                                    ? Text(
                                        currentDoctorModel.firstName == null
                                            ? ''
                                            : cubit.currentDoctorModel
                                                .firstName![0]
                                                .toUpperCase(),
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16.sp),
                                      )
                                    : CustomCachedNetworkImage(
                                        imageUrl:
                                            currentDoctorModel.image.toString(),
                                      ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(width: 8.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      BlocConsumer<HomeCubit, HomeState>(
                        listener: (context, state) {
                          state.maybeWhen(
                            orElse: () {},
                            loaded: (homeData, currentDoctorModel, dotsPosition,
                                homeIndex) {
                              context
                                  .read<ProfileCubit>()
                                  .getDoctorDataFromHomeCubit(
                                      currentDoctorModel);
                            },
                          );
                        },
                        builder: (context, state) {
                          return Text(
                            cubit.currentDoctorModel.firstName == null
                                ? ''
                                : 'Dr.${capitalizeFirstText(cubit.currentDoctorModel.firstName!)} ${capitalizeFirstText(cubit.currentDoctorModel.lastName!)}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey.shade700,
                              fontSize: 14.sp,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BlocBuilder<HomeCubit, HomeState>(
                        builder: (context, state) {
                          return Text(
                            capitalizeFirstText(
                                cubit.currentDoctorModel.specialty ??
                                    AppStrings.empty),
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 10.sp,
                                color: Colors.grey.shade600),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
        BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            return state.maybeWhen(
              orElse: () {
                return IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.add,
                    color: AppColors.description,
                    size: 30.r,
                  ),
                );
              },
              loaded: (homeData, currentDoctorModel, dotsPosition, homeIndex) {
                return Tooltip(
                  message: 'Add patient',
                  child: IconButton(
                    onPressed: () {
                      if (homeData.verified!) {
                        navigatorKey.currentState?.pushNamed(
                          AppRoutes.addPatient,
                          arguments: AppRoutesArgs.addPatientRouteArgs(
                            currentDoctorModel: cubit.currentDoctorModel,
                          ),
                        );
                      } else {
                        showCustomDialog(
                          context: context,
                          title: AppStrings.emailVerification,
                          description: AppStrings
                              .toAddPatientsYouMustVerifyYourEmailAddress,
                          noColoredBottonOnTap: () {
                            Navigator.of(context).pop();
                          },
                          coloredBottonText: AppStrings.verify,
                          noColoredBottonText: AppStrings.cancel,
                          coloredBottonOnTap: () {
                            Navigator.of(context).pop();
                            navigatorKey.currentState?.pushNamed(
                                AppRoutes.emailVerification,
                                arguments:
                                    AppRoutesArgs.emailVerificationRouteArgs(
                                        currentDoctorModel:
                                            currentDoctorModel));
                          },
                        );
                      }
                    },
                    icon: Icon(
                      Icons.add,
                      color: AppColors.description,
                      size: 30.r,
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
