import 'package:egy_akin/features/more/presentation/cubit/more_state.dart';
import 'package:egy_akin/app/services/theme_bloc.dart';
import 'package:flutter/cupertino.dart';

import '../../../../exports.dart';

class MoreScreen extends StatefulWidget {
  final DoctorModel currentDoctorModel;
  final bool accountVerification;
  final HomeModelResponse homeDataModel;
  const MoreScreen({
    super.key,
    required this.currentDoctorModel,
    required this.accountVerification,
    required this.homeDataModel,
  });

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
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        final isDarkMode = themeState is ThemeLoaded && themeState.isDarkMode;
        return BlocBuilder<LocalizationBloc, LocalizationState>(
          builder: (context, localizationState) {
            return Scaffold(
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        context.tr(AppStrings.general),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey.shade500,
                          fontSize: 13.sp,
                        ),
                      ),
                      ListTile(
                        title: Text(
                          context.tr(AppStrings.gfrCalculator),
                          style: TextStyle(fontSize: 13.5.sp),
                        ),
                        leading: Icon(
                          Icons.calculate,
                          color: Colors.grey.shade600,
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          size: 15.r,
                        ),
                        onTap: () {
                          navigatorKey.currentState?.pushNamed(
                            AppRoutes.gfrCalculator,
                            arguments: AppRoutesArgs.gfrCalculatorRouteArgs(
                              homeDataModel: widget.homeDataModel,
                            ),
                          );
                        },
                      ),
                      ListTile(
                        title: Text(
                          context.tr(AppStrings.analytics),
                          style: TextStyle(fontSize: 13.5.sp),
                        ),
                        leading: Icon(
                          Icons.analytics,
                          color: Colors.grey.shade600,
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          size: 15.r,
                        ),
                        onTap: () {
                          navigatorKey.currentState?.pushNamed(
                            AppRoutes.webview,
                            arguments: AppRoutesArgs.webViewRouteArgs(
                              url:
                                  'https://test.egyakin.com/analytics?dark=${isDarkMode ? 'true' : 'false'}',
                              title: context.tr(AppStrings.analytics),
                            ),
                          );
                        },
                      ),
                      SizedBox(height: 15.h),
                      Text(
                        context.tr(AppStrings.privacySecurity),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey.shade500,
                          fontSize: 13.sp,
                        ),
                      ),
                      ListTile(
                        title: Text(
                          context.tr(AppStrings.changePassword),
                          style: TextStyle(fontSize: 13.5.sp),
                        ),
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
                            title: Text(
                              context.tr(AppStrings.emailVerification),
                              style: TextStyle(fontSize: 13.5.sp),
                            ),
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
                                arguments:
                                    AppRoutesArgs.emailVerificationRouteArgs(
                                  currentDoctorModel: widget.currentDoctorModel,
                                ),
                              );
                            },
                          );
                        },
                      ),
                      BlocBuilder<MoreCubit, MoreState>(
                        builder: (context, state) {
                          if (isVerifiedUser(
                              widget.homeDataModel.isSyndicateCardRequired)) {
                            return const SizedBox.shrink();
                          }
                          if (widget.homeDataModel.verified == false) {
                            return const SizedBox.shrink();
                          }

                          return ListTile(
                            title: Text(
                              widget.homeDataModel.isSyndicateCardRequired ==
                                      VerificationBySyndicateCard.Pending.name
                                  ? context.tr(AppStrings.waitingForApproval)
                                  : context
                                      .tr(AppStrings.syndicateCardVerification),
                              style: TextStyle(fontSize: 13.5.sp),
                            ),
                            leading: Icon(
                              Icons.verified,
                              color: Colors.grey.shade600,
                            ),
                            trailing:
                                widget.homeDataModel.isSyndicateCardRequired ==
                                        VerificationBySyndicateCard.Pending.name
                                    ? const SizedBox.shrink()
                                    : BlocBuilder<HomeCubit, HomeState>(
                                        builder: (context, state) {
                                          return state.maybeWhen(
                                            orElse: () {
                                              return Icon(
                                                Icons.verified,
                                                color: Colors.grey.shade600,
                                              );
                                            },
                                            loaded: (homeData,
                                                currentDoctorModel,
                                                dotsPosition,
                                                homeIndex,
                                                isUploadingSyndicateCard,
                                                isUploadedSyndicateCard,
                                                message,
                                                checkUpdateMessageCounter,
                                                isUserBlocked,
                                                changesCounter) {
                                              if (isUploadingSyndicateCard) {
                                                return const SizedBox(
                                                  height: 15,
                                                  width: 15,
                                                  child:
                                                      CircularProgressIndicator(),
                                                );
                                              }
                                              return Icon(
                                                Icons.arrow_forward_ios,
                                                size: 15.r,
                                              );
                                            },
                                          );
                                        },
                                      ),
                            onTap: () {
                              if (widget
                                      .homeDataModel.isSyndicateCardRequired ==
                                  VerificationBySyndicateCard.Pending.name) {
                              } else {
                                context.read<HomeCubit>().uploadSyndicateCard();
                              }
                            },
                          );
                        },
                      ),
                      ListTile(
                        title: Text(
                          context.tr(AppStrings.privacyPolicy),
                          style: TextStyle(fontSize: 13.5.sp),
                        ),
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
                        context.tr(AppStrings.support),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey.shade500,
                          fontSize: 13.sp,
                        ),
                      ),
                      ListTile(
                        title: Text(
                          context.tr(AppStrings.contactUs),
                          style: TextStyle(fontSize: 13.5.sp),
                        ),
                        leading: Icon(
                          Icons.contact_mail,
                          color: Colors.grey.shade600,
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          size: 15.r,
                        ),
                        onTap: () {
                          navigatorKey.currentState
                              ?.pushNamed(AppRoutes.contactUs);
                        },
                      ),
                      ListTile(
                        title: Text(
                          context.tr(AppStrings.aboutUs),
                          style: TextStyle(fontSize: 13.5.sp),
                        ),
                        leading: Icon(
                          Icons.info,
                          color: Colors.grey.shade600,
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          size: 15.r,
                        ),
                        onTap: () {
                          navigatorKey.currentState
                              ?.pushNamed(AppRoutes.aboutUs);
                        },
                      ),
                      // Language Selector
                      LanguageSelector(moreCubit: cubit),

                      // Dark Mode Toggle
                      BlocBuilder<ThemeBloc, ThemeState>(
                        builder: (context, themeState) {
                          return ListTile(
                            title: Text(
                              themeState is ThemeLoaded && themeState.isDarkMode
                                  ? context.tr('Dark Mode')
                                  : context.tr('Light Mode'),
                              style: TextStyle(fontSize: 13.5.sp),
                            ),
                            leading: Icon(
                              themeState is ThemeLoaded && themeState.isDarkMode
                                  ? Icons.dark_mode
                                  : Icons.light_mode,
                              color: Colors.grey.shade600,
                            ),
                            trailing: AnimatedSwitcher(
                              duration: const Duration(milliseconds: 300),
                              transitionBuilder: (child, animation) {
                                return ScaleTransition(
                                  scale: animation,
                                  child: child,
                                );
                              },
                              child: Transform.scale(
                                scale: 0.8,
                                child: CupertinoSwitch(
                                  key: ValueKey(themeState is ThemeLoaded
                                      ? themeState.isDarkMode
                                      : false),
                                  value: themeState is ThemeLoaded
                                      ? themeState.isDarkMode
                                      : false,
                                  onChanged: (value) {
                                    context
                                        .read<ThemeBloc>()
                                        .add(ToggleTheme());
                                  },
                                  activeColor: themeState is ThemeLoaded &&
                                          themeState.isDarkMode
                                      ? AppColors.darkPrimary
                                      : AppColors.primary,
                                  trackColor: themeState is ThemeLoaded &&
                                          themeState.isDarkMode
                                      ? Colors.grey.shade700
                                      : Colors.grey.shade300,
                                  thumbColor: themeState is ThemeLoaded &&
                                          themeState.isDarkMode
                                      ? Colors.grey.shade600
                                      : Colors.grey.shade400,
                                ),
                              ),
                            ),
                            onTap: () {
                              context.read<ThemeBloc>().add(ToggleTheme());
                            },
                          );
                        },
                      ),

                      BlocBuilder<MoreCubit, MoreState>(
                        builder: (context, state) {
                          return state.maybeWhen(
                            orElse: () {
                              return const SizedBox.shrink();
                            },
                            loaded: () {
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 10,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'v${context.read<HomeCubit>().currentUserVersion} ${ApiEndPoint.baseUrl == 'https://test.egyakin.com' ? 'T' : 'P'}',
                                      style: TextStyle(
                                        color: Colors.grey.shade500,
                                        fontSize: 12.sp,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        },
                      ),
                      BlocBuilder<MoreCubit, MoreState>(
                        builder: (context, state) {
                          return state.maybeWhen(
                            orElse: () {
                              return const SizedBox.shrink();
                            },
                            loaded: () {
                              return widget.homeDataModel.role == 'Admin'
                                  ? SelectableText(
                                      cubit.fcmToken,
                                      style: const TextStyle(
                                        color: Colors.transparent,
                                      ),
                                    )
                                  : const SizedBox.shrink();
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
