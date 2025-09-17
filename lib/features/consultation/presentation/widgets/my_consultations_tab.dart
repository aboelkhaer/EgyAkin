import 'package:egy_akin/features/consultation/presentation/widgets/consultation_list.dart';
import '../../../../app/services/theme_bloc.dart';

import '../../../../exports.dart';

class MyConsultationsTab extends StatefulWidget {
  final DoctorModel currentDoctorModel;
  final HomeModelResponse homeDataModel;

  const MyConsultationsTab({
    super.key,
    required this.currentDoctorModel,
    required this.homeDataModel,
  });

  @override
  State<MyConsultationsTab> createState() => _MyConsultationsTabState();
}

class _MyConsultationsTabState extends State<MyConsultationsTab> {
  @override
  void initState() {
    super.initState();
    context.read<ConsultationCubit>().getCurrentDoctorConsultations();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        final isDarkMode = themeState is ThemeLoaded && themeState.isDarkMode;

        return BlocConsumer<ConsultationCubit, ConsultationState>(
          listener: (context, state) {
            state.maybeWhen(
              orElse: () {},
              error: (message) {
                customSnackBar(context: context, message: message);
              },
            );
          },
          builder: (context, state) {
            return state.maybeWhen(
              orElse: () {
                return const SizedBox.shrink();
              },
              myConsultationsLoading: () {
                return Center(
                  child: CircularProgressIndicator(
                    color: isDarkMode ? AppColors.darkTitle : AppColors.primary,
                  ),
                );
              },
              myConsultationsLoaded: (consultations) {
                return RefreshIndicator(
                  color: isDarkMode ? AppColors.darkTitle : AppColors.primary,
                  onRefresh: () async {
                    context
                        .read<ConsultationCubit>()
                        .getCurrentDoctorConsultations();
                  },
                  child: ConsultationList(
                    consultations: consultations,
                    currentDoctorModel: widget.currentDoctorModel,
                    homeDataModel: widget.homeDataModel,
                    isReceivedConsultation: false,
                    isDarkMode: isDarkMode,
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
