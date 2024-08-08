import '../../../../exports.dart';

class DontHaveAnAccountLine extends StatelessWidget {
  const DontHaveAnAccountLine({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          AppStrings.dontHaveAnAccount,
          style: TextStyle(
            color: Colors.grey.shade500,
            fontWeight: FontWeight.w500,
            fontSize: 10.sp,
          ),
        ),
        const SizedBox(width: 4),
        GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(AppRoutes.register);
          },
          child: Container(
            padding: const EdgeInsets.only(
              bottom: 1, // Space between underline and text
            ),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.blue,
                  width: 1.0, // Underline thickness
                ),
              ),
            ),
            child: Text(
              AppStrings.registerNow,
              style: TextStyle(
                color: Colors.blue,
                fontSize: 10.sp,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
