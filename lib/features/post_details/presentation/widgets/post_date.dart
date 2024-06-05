import 'package:intl/intl.dart';
import '../../../../exports.dart';

class PostDate extends StatelessWidget {
  final String date;
  const PostDate({super.key, required this.date});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          DateFormat.yMMMEd().format(DateTime.parse(date)),
          style: TextStyle(
            color: AppColors.description,
            fontSize: 12.sp,
          ),
        ),
      ],
    );
  }
}
