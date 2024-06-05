import '../../../../exports.dart';

class YouCanStartRightAwayLine extends StatelessWidget {
  const YouCanStartRightAwayLine({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      'You can start right away',
      style: TextStyle(
        color: AppColors.description,
        fontSize: 12.sp,
      ),
    );
  }
}
