import '../../../../exports.dart';

class WeclomeBotton extends StatelessWidget {
  final WelcomeCubit cubit;
  const WeclomeBotton({
    super.key,
    required this.cubit,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: SizedBox(
        width: double.infinity,
        child: CustomElevatedButton(
          onPressed: () => cubit.getStartBotton(context),
          title: AppStrings.getStarted,
        ),
      ),
    );
  }
}
