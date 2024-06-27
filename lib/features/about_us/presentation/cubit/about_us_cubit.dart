import 'package:egy_akin/features/about_us/presentation/cubit/about_us_state.dart';

import '../../../../exports.dart';

class AboutUsCubit extends Cubit<AboutUsState> {
  AboutUsCubit() : super(const AboutUsState.initial());
  static AboutUsCubit get(context) => BlocProvider.of(context);
}
