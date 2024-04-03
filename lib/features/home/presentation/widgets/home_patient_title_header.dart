import '../../../../exports.dart';

class HomePatientTitleHeader extends StatelessWidget {
  final String title;
  final String leftArrow;
  final String rightArrow;
  final String patientCount;
  final Function()? onTap;
  const HomePatientTitleHeader({
    super.key,
    required this.title,
    required this.patientCount,
    required this.onTap,
    required this.leftArrow,
    required this.rightArrow,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade700,
              ),
            ),
            Text(
              leftArrow,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade700,
              ),
            ),
            Text(
              patientCount,
              style: TextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.w600,
                color: Colors.grey.shade600,
              ),
            ),
            Text(
              rightArrow,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade700,
              ),
            ),
          ],
        ),
        GestureDetector(
          onTap: onTap,
          child: Icon(
            Icons.arrow_forward,
            color: Colors.grey.shade700,
          ),
        ),
      ],
    );
  }
}
