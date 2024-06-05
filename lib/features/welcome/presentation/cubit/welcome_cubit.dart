import '../../../../exports.dart';

part 'welcome_state.dart';

class WelcomeCubit extends Cubit<WelcomeState> {
  WelcomeCubit() : super(WelcomeInitial());
  static WelcomeCubit get(context) => BlocProvider.of(context);

  getStartBotton(context) async {
    await sl<AppPreferences>().setBool(AppLocalStrings.isWelcomed, true);
    Navigator.of(context).pushReplacementNamed(AppRoutes.onboarding);
  }
}
