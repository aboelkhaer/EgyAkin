import '../../../exports.dart';

class VerificationIcon extends StatelessWidget {
  final int duration;
  const VerificationIcon({super.key, this.duration = 2000});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 3),
      child: FadeIn(
        duration: Duration(milliseconds: duration),
        child: Image.asset(
          AppImages.verified,
          height: 20,
          width: 20,
          color: Colors.green.shade600,
        ),
      ),
    );
  }
}
