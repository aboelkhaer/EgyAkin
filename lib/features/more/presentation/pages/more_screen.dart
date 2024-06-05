import 'package:egy_akin/features/more/presentation/cubit/more_cubit.dart';

import '../../../../exports.dart';

class MoreScreen extends StatelessWidget {
  final DoctorModel currentDoctorModel;
  const MoreScreen({super.key, required this.currentDoctorModel});

  @override
  Widget build(BuildContext context) {
    MoreCubit cubit = MoreCubit.get(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'General',
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.grey.shade500),
              ),
              ListTile(
                title: const Text('Test'),
                leading: const Icon(
                  Icons.support,
                  color: AppColors.primary,
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  size: 15.r,
                ),
                onTap: () {},
              ),
              SizedBox(height: 15.h),
              Text(
                'Privacy & Security',
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.grey.shade500),
              ),
              ListTile(
                title: const Text('Change password'),
                leading: const Icon(
                  Icons.support,
                  color: AppColors.primary,
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  size: 15.r,
                ),
                onTap: () {},
              ),
              ListTile(
                title: const Text('Email verification'),
                leading: const Icon(
                  Icons.support,
                  color: AppColors.primary,
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  size: 15.r,
                ),
                onTap: () {
                  navigatorKey.currentState?.pushNamed(
                      AppRoutes.emailVerification,
                      arguments: AppRoutesArgs.emailVerificationRouteArgs(
                          currentDoctorModel: currentDoctorModel));
                },
              ),
              SizedBox(height: 15.h),
              Text(
                'Support',
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.grey.shade500),
              ),
              ListTile(
                title: const Text('Contact Us'),
                leading: const Icon(
                  Icons.message_rounded,
                  color: AppColors.primary,
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  size: 15.r,
                ),
                onTap: () {
                  navigatorKey.currentState?.pushNamed(AppRoutes.contactUs);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
