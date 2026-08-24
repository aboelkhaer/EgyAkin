import 'package:egy_akin/features/home/presentation/widgets/dashboard/home_dashboard_shared.dart';

import '../../../../exports.dart';

class DontHaveAnAccountLine extends StatelessWidget {
  final bool isDark;

  const DontHaveAnAccountLine({
    super.key,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    final primary = HomeDashboardColors.primary(isDark);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          context.tr(AppStrings.dontHaveAnAccount),
          style: TextStyle(
            color: HomeDashboardColors.subtitle(isDark),
            fontWeight: FontWeight.w500,
            fontSize: 11.sp,
          ),
        ),
        SizedBox(width: 4.w),
        GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(AppRoutes.register);
          },
          child: Text(
            context.tr(AppStrings.registerNow),
            style: TextStyle(
              color: primary,
              fontSize: 11.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }
}
