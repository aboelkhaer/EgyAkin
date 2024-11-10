import 'package:egy_akin/features/consultation_from_ai/presentation/cubit/consultation_from_ai_state.dart';

import '../../../../exports.dart';

class ConsultationFromAICubit extends Cubit<ConsultationFromAIState> {
  ConsultationFromAICubit() : super(const ConsultationFromAIState.initial());
  static ConsultationFromAICubit get(context) => BlocProvider.of(context);
  String newConsultation = '';
}
