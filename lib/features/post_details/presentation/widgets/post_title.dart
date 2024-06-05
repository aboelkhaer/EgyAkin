import '../../../../exports.dart';

class PostTitle extends StatelessWidget {
  final String title;
  const PostTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          child: Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: AppColors.title,
              height: 1.5,
              wordSpacing: 0.5,
              letterSpacing: 1,
              fontSize: 14.sp,
            ),
          ),
        ),
      ],
    );
  }
}
