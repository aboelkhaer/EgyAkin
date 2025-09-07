import '../../../../exports.dart';

class ConsultationButtonsRow extends StatelessWidget {
  final VoidCallback onDoctorConsultationTap;
  final VoidCallback onAiConsultationTap;

  const ConsultationButtonsRow({
    super.key,
    required this.onDoctorConsultationTap,
    required this.onAiConsultationTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton(
              onPressed: onDoctorConsultationTap,
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: AppColors.primary),
              ),
              child:  Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.person, color: AppColors.primary),
                    SizedBox(width: 8),
                    Text(
                      context.tr(AppStrings.fromDoctor),
                      style: TextStyle(color: AppColors.primary),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(width: 10), // Space between the buttons
          Expanded(
            child: OutlinedButton(
              onPressed: onAiConsultationTap,
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: AppColors.primary),
              ),
              child:  Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.memory, color: AppColors.primary),
                    SizedBox(width: 8),
                    Text(
                      context.tr(AppStrings.fromAi),
                      style: TextStyle(color: AppColors.primary),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
