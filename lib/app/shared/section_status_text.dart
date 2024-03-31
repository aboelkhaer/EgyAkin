import '../../exports.dart';

class SectionStatusText extends StatelessWidget {
  final bool isSubmitStatus;
  const SectionStatusText({super.key, required this.isSubmitStatus});

  @override
  Widget build(BuildContext context) {
    return Text(
      isSubmitStatus ? 'Completed' : 'Binding...',
      style: TextStyle(
        color:
            isSubmitStatus ? AppColors.primary.withOpacity(0.7) : Colors.amber,
        fontSize: 13,
      ),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }
}
