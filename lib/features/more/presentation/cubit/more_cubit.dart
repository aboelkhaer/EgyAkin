import 'package:egy_akin/features/more/presentation/cubit/more_state.dart';

import '../../../../exports.dart';

class MoreCubit extends Cubit<MoreState> {
  MoreCubit() : super(const MoreState.initial());
  static MoreCubit get(context) => BlocProvider.of(context);
}
