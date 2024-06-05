import '../../../exports.dart';

class CustomCircularProgressIndicator extends StatelessWidget {
  const CustomCircularProgressIndicator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 30,
      height: 40.h,
      child: const Column(
        children: [
          SizedBox(
            width: 30,
            height: 30,
            child: CircularProgressIndicator(
              color: AppColors.primary,
            ),
          ),
        ],
      ),
    );
  }
}
