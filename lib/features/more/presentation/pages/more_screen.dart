import 'package:egy_akin/features/more/presentation/cubit/more_state.dart';

import '../../../../exports.dart';

class MoreScreen extends StatefulWidget {
  final DoctorModel currentDoctorModel;
  final bool accountVerification;
  const MoreScreen(
      {super.key,
      required this.currentDoctorModel,
      required this.accountVerification});

  @override
  State<MoreScreen> createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {
  @override
  void initState() {
    context.read<MoreCubit>().getFcmTokenTest();
    super.initState();
  }

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
                title: const Text('GFR Calculator'),
                leading: Icon(
                  Icons.calculate,
                  color: Colors.grey.shade600,
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  size: 15.r,
                ),
                onTap: () {
                  navigatorKey.currentState?.pushNamed(AppRoutes.gfrCalculator);
                },
              ),
              SizedBox(height: 15.h),
              Text(
                'Privacy & Security',
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.grey.shade500),
              ),
              ListTile(
                title: const Text('Change password'),
                leading: Icon(
                  Icons.password,
                  color: Colors.grey.shade600,
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  size: 15.r,
                ),
                onTap: () {
                  navigatorKey.currentState
                      ?.pushNamed(AppRoutes.changePassword);
                },
              ),
              BlocBuilder<MoreCubit, MoreState>(
                builder: (context, state) {
                  if (widget.accountVerification) {
                    return const SizedBox.shrink();
                  }
                  return ListTile(
                    title: const Text('Email verification'),
                    leading: Icon(
                      Icons.verified,
                      color: Colors.grey.shade600,
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      size: 15.r,
                    ),
                    onTap: () {
                      navigatorKey.currentState?.pushNamed(
                          AppRoutes.emailVerification,
                          arguments: AppRoutesArgs.emailVerificationRouteArgs(
                              currentDoctorModel: widget.currentDoctorModel));
                    },
                  );
                },
              ),
              ListTile(
                title: const Text('Privacy Policy'),
                leading: Icon(
                  Icons.privacy_tip,
                  color: Colors.grey.shade600,
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  size: 15.r,
                ),
                onTap: () {
                  launchURL(
                    url: 'https://egyakin.com/policy',
                    onError: (error) {
                      showErrorDialog(context, error);
                    },
                  );
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
                leading: Icon(
                  Icons.contact_mail,
                  color: Colors.grey.shade600,
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  size: 15.r,
                ),
                onTap: () {
                  navigatorKey.currentState?.pushNamed(AppRoutes.contactUs);
                },
              ),
              ListTile(
                title: const Text('About us'),
                leading: Icon(
                  Icons.info,
                  color: Colors.grey.shade600,
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  size: 15.r,
                ),
                onTap: () {
                  navigatorKey.currentState?.pushNamed(AppRoutes.aboutUs);
                },
              ),
              // BlocBuilder<MoreCubit, MoreState>(
              //   builder: (context, state) {
              //     return state.maybeWhen(
              //       orElse: () {
              //         return SelectableText(cubit.fcmToken);
              //       },
              //     );
              //   },
              // )
            ],
          ),
        ),
      ),
    );
  }
}
