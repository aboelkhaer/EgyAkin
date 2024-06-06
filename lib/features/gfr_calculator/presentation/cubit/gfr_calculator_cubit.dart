import '../../../../exports.dart';

class GfrCalculatorCubit extends Cubit<GfrCalculatorState> {
  GfrCalculatorCubit() : super(const GfrCalculatorState.initial());
  static GfrCalculatorCubit get(context) => BlocProvider.of(context);
}
