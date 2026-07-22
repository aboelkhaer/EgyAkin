import 'package:egy_akin/features/contact_us/presentation/cubit/contact_us_state.dart';
import 'package:egy_akin/features/contact_us/presentation/widgets/contact_us_ui.dart';

import '../../../../exports.dart';

class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({super.key});

  void _openUrl(BuildContext context, String url) {
    launchURL(
      url: url,
      onError: (error) => showErrorDialog(context, error),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cubit = ContactUsCubit.get(context);

    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        final isDarkMode = themeState is ThemeLoaded && themeState.isDarkMode;
        final scaffoldBg =
            isDarkMode ? AppColors.darkScaffoldBG : AppColors.scaffoldBG;
        final appBarForeground =
            isDarkMode ? AppColors.darkTitle : AppColors.title;

        return Scaffold(
          backgroundColor: scaffoldBg,
          appBar: AppBar(
            elevation: 0,
            scrolledUnderElevation: 0,
            backgroundColor: scaffoldBg,
            foregroundColor: appBarForeground,
            iconTheme: IconThemeData(color: appBarForeground),
            title: Text(
              context.tr(AppStrings.contactUs),
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 17.sp,
                color: appBarForeground,
              ),
            ),
          ),
          body: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 32.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const ContactHeroBanner(),
                  SizedBox(height: 16.h),
                  ContactSectionCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        ContactSectionHeader(
                          icon: Icons.support_agent_outlined,
                          title: context.tr(AppStrings.support),
                          subtitle: context.tr(AppStrings.contactUsText),
                        ),
                        SizedBox(height: 14.h),
                        ContactInfoTile(
                          icon: Icons.email_outlined,
                          label: context.tr(AppStrings.contactUsEmailSupport),
                          value: context.tr(AppStrings.contactUsSupportEmail),
                          onTap: () => _openUrl(
                            context,
                            'mailto:${AppStrings.contactUsSupportEmail}',
                          ),
                        ),
                        SizedBox(height: 10.h),
                        ContactInfoTile(
                          icon: Icons.language_outlined,
                          label: context.tr(AppStrings.contactUsVisitWebsite),
                          value: 'egyakin.com',
                          onTap: () => _openUrl(
                            context,
                            AppStrings.contactUsWebsiteUrl,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 12.h),
                  ContactSectionCard(
                    child: Form(
                      key: cubit.formKey,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          ContactSectionHeader(
                            icon: Icons.rate_review_outlined,
                            title: context.tr(AppStrings.contactUsSendFeedback),
                            subtitle:
                                context.tr(AppStrings.contactUsFeedbackHint),
                          ),
                          SizedBox(height: 14.h),
                          CustomTextFormField(
                            title: context.tr(AppStrings.content),
                            textInputType: TextInputType.multiline,
                            textInputAction: TextInputAction.newline,
                            maxLines: 8,
                            onChanged: (val) => cubit.feedback = val,
                            validator: (value) =>
                                AppValidators.fieldsIsEmptyValidation(value!),
                          ),
                          SizedBox(height: 16.h),
                          BlocConsumer<ContactUsCubit, ContactUsState>(
                            listener: (context, state) {
                              state.maybeWhen(
                                orElse: () {},
                                loaded: (message) {
                                  navigatorKey.currentState?.pop();
                                  customSnackBar(
                                    context: context,
                                    message: message,
                                  );
                                },
                                error: (message) {
                                  customSnackBar(
                                    context: context,
                                    message: message,
                                  );
                                },
                              );
                            },
                            builder: (context, state) {
                              return state.maybeWhen(
                                loading: () => Center(
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                      vertical: 8.h,
                                    ),
                                    child: const CircularProgressIndicator(),
                                  ),
                                ),
                                orElse: () => CustomElevatedButton(
                                  onPressed: cubit.addContactUs,
                                  title: context.tr(AppStrings.send),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    context.tr(AppStrings.disclaimerText),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 10.sp,
                      height: 1.4,
                      color: isDarkMode
                          ? AppColors.darkDescription
                          : Colors.grey.shade500,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
