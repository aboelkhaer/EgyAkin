import 'package:egy_akin/exports.dart';
import '../../../../app/services/theme_bloc.dart';

class AdminSide extends StatelessWidget {
  final HomeModelResponse homeDataModel;
  final DoctorInfoViewModelResponse doctorInfo;

  const AdminSide(
      {super.key, required this.homeDataModel, required this.doctorInfo});

  @override
  Widget build(BuildContext context) {
    DoctorInfoViewCubit cubit = DoctorInfoViewCubit.get(context);

    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        final isDarkMode = themeState is ThemeLoaded && themeState.isDarkMode;

        return homeDataModel.role == AppStrings.roleAdmin
            ? Stack(
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    margin: EdgeInsets.only(top: 12.h),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: isDarkMode
                            ? AppColors.darkPrimary
                            : AppColors.primary,
                      ),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              '${context.tr(AppStrings.age)}:',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14.sp,
                                color: isDarkMode
                                    ? AppColors.darkTitle
                                    : AppColors.title,
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 8.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(width: 60.w),
                            SelectableText(
                              doctorInfo.data!.age ??
                                  context.tr(AppStrings.noData),
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: isDarkMode
                                    ? AppColors.darkDescription
                                    : Colors.grey.shade600,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 15.h),
                        Row(
                          children: [
                            Text(
                              '${context.tr(AppStrings.id)}:',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14.sp,
                                color: isDarkMode
                                    ? AppColors.darkTitle
                                    : AppColors.title,
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 8.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(width: 60.w),
                            SelectableText(
                              doctorInfo.data!.id.toString(),
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: isDarkMode
                                    ? AppColors.darkDescription
                                    : Colors.grey.shade600,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 15.h),
                        Row(
                          children: [
                            Text(
                              '${context.tr(AppStrings.joinUs)}:',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14.sp,
                                color: isDarkMode
                                    ? AppColors.darkTitle
                                    : AppColors.title,
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 8.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(width: 60.w),
                            SelectableText(
                              TimeAgoService.instance.formatTimeAgoFromString(
                                  doctorInfo.data!.createdAt.toString(),
                                  context),
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: isDarkMode
                                    ? AppColors.darkDescription
                                    : Colors.grey.shade600,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 15.h),
                        Row(
                          children: [
                            Text(
                              '${context.tr(AppStrings.emailVerification)}:',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14.sp,
                                color: isDarkMode
                                    ? AppColors.darkTitle
                                    : AppColors.title,
                              ),
                            ),
                            const Spacer(),
                            Transform.scale(
                              scale: 0.8,
                              child: Switch(
                                value: cubit.doctorVerifiedEmail,
                                onChanged: (value) {
                                  cubit.verifyDoctorEmail(
                                      doctorInfo.data!.id.toString());
                                },
                                activeColor: isDarkMode
                                    ? AppColors.darkPrimary
                                    : AppColors.primary,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(width: 60.w),
                            SelectableText(
                              doctorInfo.data!.emailVerifiedAt == null
                                  ? context.tr(AppStrings.noData)
                                  : TimeAgoService.instance
                                      .formatTimeAgoFromString(
                                          doctorInfo.data!.emailVerifiedAt
                                              .toString(),
                                          context),
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: isDarkMode
                                    ? AppColors.darkDescription
                                    : Colors.grey.shade600,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 15.h),
                        Row(
                          children: [
                            Text(
                              '${context.tr(AppStrings.registrationNumber)}:',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14.sp,
                                color: isDarkMode
                                    ? AppColors.darkTitle
                                    : AppColors.title,
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 8.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(width: 60.w),
                            SelectableText(
                              doctorInfo.data!.registrationNumber ??
                                  context.tr(AppStrings.noData),
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: isDarkMode
                                      ? AppColors.darkDescription
                                      : Colors.grey.shade600),
                            ),
                          ],
                        ),
                        SizedBox(height: 15.h),
                        Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${context.tr(AppStrings.syndicateCardStatus)}:',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14
                                    .sp, // Adjust font size based on your responsiveness setup
                                color: isDarkMode
                                    ? AppColors.darkTitle
                                    : AppColors.title,
                              ),
                            ),
                            const Spacer(),
                            Transform.scale(
                              scale: 0.8,
                              child: Switch(
                                value: cubit.isSyndicateCardVerified,
                                onChanged: (value) {
                                  cubit.changeSyndicateCardStatus(
                                      doctorInfo.data!.id.toString());
                                },
                                activeColor: isDarkMode
                                    ? AppColors.darkPrimary
                                    : AppColors.primary,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(width: 60.w),
                            SelectableText(
                              doctorInfo.data!.isSyndicateCardRequired
                                  .toString(),
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: isDarkMode
                                    ? AppColors.darkDescription
                                    : Colors.grey.shade600,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 15.h),
                        Row(
                          children: [
                            Text(
                              '${context.tr(AppStrings.syndicateCard)}:',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14.sp,
                                color: isDarkMode
                                    ? AppColors.darkTitle
                                    : AppColors.title,
                              ),
                            ),
                            const Spacer(),
                            doctorInfo.data!.isSyndicateCardRequired ==
                                    'Pending'
                                ? InkWell(
                                    onTap: () {
                                      cubit.rejectSyndicateCard(
                                          doctorInfo.data!.id.toString());
                                    },
                                    splashColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    child: Container(
                                      padding: const EdgeInsets.all(10),
                                      child: Text(
                                        context.tr(AppStrings.reject),
                                        style: TextStyle(
                                            color: isDarkMode
                                                ? AppColors.darkPrimary
                                                : Colors.blue,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                  )
                                : const SizedBox.shrink(),
                          ],
                        ),
                        SizedBox(height: 8.h),
                        doctorInfo.data!.syndicateCard == null
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(width: 60.w),
                                  SelectableText(
                                    context.tr(AppStrings.noSyndicateCard),
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: isDarkMode
                                          ? AppColors.darkDescription
                                          : Colors.grey.shade600,
                                    ),
                                  ),
                                ],
                              )
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => FullScreenImage(
                                            imageUrl: doctorInfo
                                                .data!.syndicateCard
                                                .toString()
                                                .toString(),
                                          ),
                                        ),
                                      );
                                    },
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: CustomCachedNetworkImage(
                                        imageUrl: doctorInfo.data!.syndicateCard
                                            .toString(),
                                        height: 100.h,
                                        width: 260.w,
                                        fit: BoxFit.fitWidth,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                        SizedBox(height: 15.h),
                        Row(
                          children: [
                            Text(
                              '${context.tr(AppStrings.blocked)}:',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14.sp,
                                color: isDarkMode
                                    ? AppColors.darkTitle
                                    : AppColors.title,
                              ),
                            ),
                            const Spacer(),
                            Transform.scale(
                              scale: 0.8,
                              child: Switch(
                                value: cubit.doctorBlocked,
                                onChanged: (value) {
                                  cubit.changeBlockUserStatus(
                                      doctorInfo.data!.id.toString());
                                },
                                activeColor: isDarkMode
                                    ? AppColors.darkPrimary
                                    : AppColors.primary,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(width: 60.w),
                            SelectableText(
                              doctorInfo.data!.blocked.toString() == 'false'
                                  ? context.tr(AppStrings.no)
                                  : context.tr(AppStrings.yes),
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: isDarkMode
                                    ? AppColors.darkDescription
                                    : Colors.grey.shade600,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 15.h),
                      ],
                    ),
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    top: 0,
                    child: Center(
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        color: isDarkMode
                            ? AppColors.darkCardBG
                            : Colors.grey.shade100,
                        child: Text(
                          context.tr(AppStrings.adminSide),
                          style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.bold,
                              color: isDarkMode
                                  ? AppColors.darkTitle
                                  : AppColors.title),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            : const SizedBox.shrink();
      },
    );
  }
}
