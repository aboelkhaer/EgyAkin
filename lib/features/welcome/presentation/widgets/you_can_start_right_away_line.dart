import 'package:egy_akin/features/home/presentation/widgets/dashboard/home_dashboard_shared.dart';

import '../../../../exports.dart';

class YouCanStartRightAwayLine extends StatelessWidget {
  final bool isDark;

  const YouCanStartRightAwayLine({
    super.key,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      'You can start right away',
      style: TextStyle(
        color: HomeDashboardColors.subtitle(isDark),
        fontSize: 11.sp,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
