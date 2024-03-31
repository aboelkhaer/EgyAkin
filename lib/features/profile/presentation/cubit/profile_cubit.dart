import 'package:egy_akin/features/profile/presentation/cubit/profile_state.dart';

import '../../../../exports.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(const ProfileState.initial());
  static ProfileCubit get(context) => BlocProvider.of(context);
}
