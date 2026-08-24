import '../../../../exports.dart';

class SubmitButton extends StatelessWidget {
  final AddPatientCubit cubit;

  const SubmitButton({super.key, required this.cubit});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        final isDark = themeState is ThemeLoaded && themeState.isDarkMode;
        final buttonColor =
            isDark ? const Color(0xFF6D4CDB) : AppColors.primary;

        return Padding(
          padding: EdgeInsets.fromLTRB(14.w, 6.h, 14.w, 2.h),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: cubit.addPatientForFirstTime,
              borderRadius: BorderRadius.circular(18.r),
              child: Ink(
                height: 44.h,
                decoration: BoxDecoration(
                  color: buttonColor,
                  borderRadius: BorderRadius.circular(18.r),
                  boxShadow: [
                    BoxShadow(
                      color: buttonColor.withOpacity(0.35),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(14.w, 0, 8.w, 0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              context.tr(AppStrings.createPatient),
                              style: TextStyle(
                                fontSize: 12.5.sp,
                                fontWeight: FontWeight.w800,
                                color: Colors.white,
                                height: 1.05,
                              ),
                            ),
                            SizedBox(height: 1.h),
                            Text(
                              context.tr(
                                AppStrings.continueToComplaintSection,
                              ),
                              style: TextStyle(
                                fontSize: 9.sp,
                                fontWeight: FontWeight.w500,
                                color: Colors.white.withOpacity(0.88),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 30.r,
                        height: 30.r,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.18),
                          borderRadius: BorderRadius.circular(9.r),
                        ),
                        child: Icon(
                          Icons.arrow_forward_rounded,
                          size: 15.sp,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
