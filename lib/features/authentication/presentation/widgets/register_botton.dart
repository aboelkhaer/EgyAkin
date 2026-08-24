import 'package:egy_akin/features/home/presentation/widgets/dashboard/home_dashboard_shared.dart';

import '../../../../exports.dart';

class RegisterBotton extends StatelessWidget {
  final AuthenticationCubit cubit;
  final bool isDark;

  const RegisterBotton({
    super.key,
    required this.cubit,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    final primary = HomeDashboardColors.primary(isDark);

    return BlocConsumer<AuthenticationCubit, AuthenticationState>(
      builder: (context, state) {
        final isLoading = state.maybeWhen(
          loading: () => true,
          orElse: () => false,
        );

        return SizedBox(
          width: double.infinity,
          height: 46.h,
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: isLoading ? null : () async => await cubit.register(context),
              borderRadius: BorderRadius.circular(14.r),
              child: Ink(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14.r),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      primary,
                      Color.lerp(primary, const Color(0xFF1F2937), 0.22)!,
                    ],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: primary.withOpacity(isDark ? 0.35 : 0.28),
                      blurRadius: 14,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Center(
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 220),
                    child: isLoading
                        ? SizedBox(
                            key: const ValueKey('loading'),
                            width: 20.r,
                            height: 20.r,
                            child: const CircularProgressIndicator(
                              strokeWidth: 2.2,
                              color: Colors.white,
                            ),
                          )
                        : Row(
                            key: const ValueKey('label'),
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                context.tr(AppStrings.register),
                                style: TextStyle(
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(width: 8.w),
                              Container(
                                width: 22.r,
                                height: 22.r,
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.18),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.arrow_forward_rounded,
                                  size: 14.sp,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
      listener: (context, state) {
        state.maybeWhen(
          loaded: (doctorData, isSignInSuccess, isRegisterSuccess) {
            Navigator.of(context)
                .pushReplacementNamed(AppRoutes.home, arguments: 0);
          },
          error: (message) =>
              customSnackBar(message: message, context: context),
          orElse: () => null,
        );
      },
    );
  }
}
