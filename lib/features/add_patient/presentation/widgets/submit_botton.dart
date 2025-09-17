import '../../../../exports.dart';
import '../../../../app/services/theme_bloc.dart';

class SubmitButton extends StatelessWidget {
  final AddPatientCubit cubit;
  const SubmitButton({super.key, required this.cubit});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        final isDarkMode = themeState is ThemeLoaded && themeState.isDarkMode;

        return Container(
          color: isDarkMode ? AppColors.darkCardBG : Colors.white,
          width: double.infinity,
          height: 50,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: CustomElevatedButton(
              onPressed: () {
                cubit.addPatientForFirstTime();
              },
              title: context.tr(AppStrings.submit),
            ),
          ),
        );
      },
    );
  }
}
