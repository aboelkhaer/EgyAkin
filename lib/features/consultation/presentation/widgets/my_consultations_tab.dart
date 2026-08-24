import 'package:egy_akin/features/consultation/presentation/widgets/consultation_list.dart';
import 'package:egy_akin/features/home/presentation/widgets/dashboard/home_dashboard_shared.dart';

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
              myConsultationsLoading: () => Center(
                child: SizedBox(
                  width: 28.w,
                  height: 28.w,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.5,
                    color: primary,
                  ),
                ),
              ),
              myConsultationsLoaded: (consultations) {
                return RefreshIndicator(
                  color: primary,
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
