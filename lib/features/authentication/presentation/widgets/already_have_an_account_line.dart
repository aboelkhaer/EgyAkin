import '../../../../exports.dart';

class AlreadyHaveAnAccountLine extends StatelessWidget {
  const AlreadyHaveAnAccountLine({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          AppStrings.alreadyHaveAnAccount,
          style: TextStyle(
            color: Colors.grey.shade500,
            fontWeight: FontWeight.w500,
            fontSize: 10.sp,
          ),
        ),
        const SizedBox(width: 4),
        GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(AppRoutes.signIn);
          },
          child: Container(
            padding: const EdgeInsets.only(
              bottom: 1,
            ),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.blue,
                  width: 1.0,
                ),
              ),
            ),
            child: Text(
              AppStrings.signInNow,
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
