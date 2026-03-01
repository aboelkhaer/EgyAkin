import '../../../../../exports.dart';

class VerifySyndicateCardForAdmin extends StatelessWidget {
  final HomeModelResponse homeDataModel;
  final DoctorInfoViewModelResponse doctorInfo;
  final bool isDarkMode;
  final DoctorInfoViewCubit cubit;
  const VerifySyndicateCardForAdmin(
      {super.key,
      required this.homeDataModel,
      required this.doctorInfo,
      required this.isDarkMode,
      required this.cubit});

  @override
  Widget build(BuildContext context) {
    return PermissionGuard(
        permission: AppPermissions.verifySyndicateCard,
        child: Column(
          children: [
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
                    color: isDarkMode ? AppColors.darkTitle : AppColors.title,
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
                    activeColor:
                        isDarkMode ? AppColors.darkPrimary : AppColors.primary,
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
                  doctorInfo.data!.isSyndicateCardRequired.toString(),
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
                    color: isDarkMode ? AppColors.darkTitle : AppColors.title,
                  ),
                ),
                const Spacer(),
                doctorInfo.data!.isSyndicateCardRequired == 'Pending'
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
                                imageUrl: doctorInfo.data!.syndicateCard
                                    .toString()
                                    .toString(),
                              ),
                            ),
                          );
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: CustomCachedNetworkImage(
                            imageUrl: doctorInfo.data!.syndicateCard.toString(),
                            height: 100.h,
                            width: 260.w,
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                      )
                    ],
                  ),
          ],
        ));
  }
}
