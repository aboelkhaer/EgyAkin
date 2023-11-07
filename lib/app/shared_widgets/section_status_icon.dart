import '../../exports.dart';

class SectionStatusIcon extends StatelessWidget {
  final bool submitStatus;
  const SectionStatusIcon({super.key, required this.submitStatus});

  @override
  Widget build(BuildContext context) {
    return Icon(
      submitStatus ? AppIcons.isFinalSubmit : AppIcons.isFinalNotSubmit,
      color: submitStatus ? AppColors.primary.withOpacity(0.7) : Colors.amber,
    );
  }
}
