import 'package:egy_akin/features/consultation/presentation/widgets/consultation_list.dart';
import '../../../../app/services/theme_bloc.dart';

import '../../../../exports.dart';

class ReceivedTab extends StatefulWidget {
  final DoctorModel currentDoctorModel;
  final HomeModelResponse homeDataModel;

  const ReceivedTab({
    super.key,
    required this.currentDoctorModel,
    required this.homeDataModel,
  });

  @override
  State<ReceivedTab> createState() => _ReceivedTabState();
}

class _ReceivedTabState extends State<ReceivedTab> {
  @override
  void initState() {
    super.initState();
    context.read<ConsultationCubit>().getReceivedConsultations();
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
              receivedConsultationsLoading: () {
                return Center(
                  child: CircularProgressIndicator(
                    color: isDarkMode ? AppColors.darkTitle : AppColors.primary,
                  ),
                );
              },
              receivedConsultationsLoaded: (consultations) {
                return RefreshIndicator(
                  color: isDarkMode ? AppColors.darkTitle : AppColors.primary,
                  onRefresh: () async {
                    context
                        .read<ConsultationCubit>()
                        .getReceivedConsultations();
                  },
                  child: ConsultationList(
                    consultations: consultations,
                    currentDoctorModel: widget.currentDoctorModel,
                    homeDataModel: widget.homeDataModel,
                    isReceivedConsultation: true,
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
