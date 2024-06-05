import '../../../../exports.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    WelcomeCubit cubit = WelcomeCubit.get(context);
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.transparent,
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Text(
                  AppStrings.welcomeTitle,
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.title,
                  ),
                ),
                SizedBox(height: 10.h),
                Text(
                  AppStrings.welcomeDescription,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: AppColors.description,
                  ),
                ),
              ],
            ),
            Image.asset(
              AppImages.welcomeImage,
              width: double.infinity,
              height: 230.h,
            ),
            Column(
              children: [
                WeclomeBotton(
                  cubit: cubit,
                ),
                SizedBox(height: 10.h),
                const YouCanStartRightAwayLine(),
                SizedBox(height: 50.h),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
