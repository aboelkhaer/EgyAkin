import '../../../exports.dart';

class VerificationIcon extends StatelessWidget {
  final int duration;
  final bool isPatientCard;
  final bool isSmaller;
  const VerificationIcon({
    super.key,
    this.duration = 500,
    this.isPatientCard = false,
    this.isSmaller = false,
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: 'Verified',
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: FadeIn(
          duration: Duration(milliseconds: duration),
          child: Image.asset(
            AppImages.verified,
            height: isSmaller
                ? 14.r
                : isPatientCard
                    ? 14.r
                    : 16.r,
            width: isSmaller
                ? 14.r
                : isPatientCard
                    ? 14.r
                    : 16.r,
            color: isPatientCard ? Colors.grey.shade400 : Colors.green.shade600,
          ),
        ),
      ),
    );
  }
}
