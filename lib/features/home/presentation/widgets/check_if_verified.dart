import '../../../../exports.dart';

class CheckIfVerified extends StatelessWidget {
  final bool verified;
  const CheckIfVerified({super.key, required this.verified});

  @override
  Widget build(BuildContext context) {
    if (verified) {
      return const SizedBox.shrink();
    } else {
      return GestureDetector(
        onTap: () {
          navigatorKey.currentState?.pushNamed(AppRoutes.emailVerification,
              arguments: context.read<HomeCubit>().currentDoctorModel);
        },
        child: Container(
          width: double.infinity,
          height: 50,
          alignment: Alignment.center,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 7,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.error_outline,
                color: Colors.blue.shade600,
                size: 16,
              ),
              const SizedBox(width: 2),
              Text(
                'To add patients, you must verify your email address',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Colors.blue.shade600,
                ),
              ),
              Icon(
                Icons.arrow_forward,
                size: 18,
                color: Colors.blue.shade600,
              )
            ],
          ),
        ),
      );
    }
  }
}
