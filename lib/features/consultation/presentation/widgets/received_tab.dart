import 'package:egy_akin/features/consultation/presentation/widgets/consultation_list.dart';
import 'package:egy_akin/features/home/presentation/widgets/dashboard/home_dashboard_shared.dart';

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
        final isDark = themeState is ThemeLoaded && themeState.isDarkMode;
        final primary = HomeDashboardColors.primary(isDark);

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
              orElse: () => const SizedBox.shrink(),
              receivedConsultationsLoading: () => Center(
                child: SizedBox(
                  width: 28.w,
                  height: 28.w,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.5,
                    color: primary,
                  ),
                ),
              ),
              receivedConsultationsLoaded: (consultations) {
                return RefreshIndicator(
                  color: primary,
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
                    isDarkMode: isDark,
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
