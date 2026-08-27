import 'package:egy_akin/app/shared/functions/hightest_degree_list.dart';
import 'package:egy_akin/app/shared/widgets/admin_only_badge.dart';
import 'package:egy_akin/features/doctor_profile_view/presentation/cubit/doctor_profile_view_state.dart';
import 'package:egy_akin/features/home/presentation/widgets/dashboard/home_dashboard_shared.dart';

import '../../../../exports.dart';

class DoctorProfileViewScreen extends StatefulWidget {
  const DoctorProfileViewScreen({super.key});

  @override
  State<DoctorProfileViewScreen> createState() =>
      _DoctorProfileViewScreenState();
}

class _DoctorProfileViewScreenState extends State<DoctorProfileViewScreen> {
  late final ScrollController _scrollController;
  double _subtitleT = 1;
  static const double _subtitleCollapseRange = 48;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;
    final next =
        (1 - (_scrollController.offset / _subtitleCollapseRange)).clamp(0.0, 1.0);
    if ((next - _subtitleT).abs() > 0.008) {
      setState(() => _subtitleT = next);
    }
  }

  @override
  Widget build(BuildContext context) {
    final cubit = DoctorProfileViewCubit.get(context);

    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        final isDark = themeState is ThemeLoaded && themeState.isDarkMode;
        final scaffold = HomeDashboardColors.scaffold(isDark);
        final primary = HomeDashboardColors.primary(isDark);
        final titleColor = HomeDashboardColors.title(isDark);
        final muted = HomeDashboardColors.subtitle(isDark);
        final subtitleEase = Curves.easeOutCubic.transform(_subtitleT);

        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: isDark
              ? SystemUiOverlayStyle.light
                  .copyWith(statusBarColor: Colors.transparent)
              : SystemUiOverlayStyle.dark
                  .copyWith(statusBarColor: Colors.transparent),
          child: Scaffold(
            backgroundColor: scaffold,
            body: BlocConsumer<DoctorProfileViewCubit, DoctorProfileViewState>(
              listener: (context, state) {
                state.maybeWhen(
                  orElse: () {},
                  loaded: (currentDoctorModel, isProfileHasChanged, message,
                      isUpdating, isSubmit, isMedicalStatistics) async {
                    if (message.isNotEmpty) {
                      customSnackBar(
                        context: context,
                        message: context.tr(message),
                      );
                    }
                    if (isSubmit) {
                      // Sync role + land on Profile before nav shrinks to 3 tabs
                      // (avoids RangeError on index 4 and Community redirect).
                      final homeCubit = context.read<HomeCubit>();
                      await homeCubit.applyProfileUpdateAndOpenProfile();
                      final nav = navigatorKey.currentState;
                      if (nav != null && nav.canPop()) {
                        nav.pop();
                      } else {
                        nav?.pushReplacementNamed(
                          AppRoutes.home,
                          arguments: 4,
                        );
                      }
                    }
                  },
                );
              },
              builder: (context, state) {
                return state.maybeWhen(
                  orElse: () => _ProfileLoadingView(
                    isDark: isDark,
                    primary: primary,
                    message: context.tr(AppStrings.loadingProfile),
                  ),
                  loaded: (currentDoctorModel, isProfileHasChanged, message,
                      isUpdating, isSubmit, isMedicalStatistics) {
                    if (isUpdating) {
                      return _ProfileLoadingView(
                        isDark: isDark,
                        primary: primary,
                        message: context.tr(AppStrings.savingProfile),
                      );
                    }

                    return Column(
                      children: [
                        _ProfileHeader(
                          isDark: isDark,
                          scaffold: scaffold,
                          primary: primary,
                          titleColor: titleColor,
                          muted: muted,
                          subtitleEase: subtitleEase,
                          subtitleT: _subtitleT,
                          isMedicalStatistics: isMedicalStatistics,
                        ),
                        Expanded(
                          child: Form(
                            key: cubit.formKey,
                            child: ListView(
                              controller: _scrollController,
                              physics: const BouncingScrollPhysics(),
                              padding: EdgeInsets.fromLTRB(14.w, 8.h, 14.w, 24.h),
                              children: [
                                _RoleToggle(
                                  isDark: isDark,
                                  primary: primary,
                                  isMedicalStatistics: isMedicalStatistics,
                                  memberLabel: context.tr(AppStrings.member),
                                  researchLabel:
                                      context.tr(AppStrings.researchMember),
                                  onMember: () =>
                                      cubit.toggleMedicalStatistics(false),
                                  onResearch: () =>
                                      cubit.toggleMedicalStatistics(true),
                                ),
                                SizedBox(height: 14.h),
                                _SectionLabel(
                                  isDark: isDark,
                                  title: context
                                      .tr(AppStrings.basicInfo)
                                      .toUpperCase(),
                                ),
                                SizedBox(height: 8.h),
                                _FieldCard(
                                  isDark: isDark,
                                  primary: primary,
                                  step: 1,
                                  title: context.tr(AppStrings.firstName),
                                  required: true,
                                  child: CustomTextFormField(
                                    title: context.tr(AppStrings.firstName),
                                    initialValue:
                                        currentDoctorModel.firstName ?? '',
                                    textInputType: TextInputType.text,
                                    onChanged: (value) {
                                      cubit.firstName = value;
                                      cubit.checkForChanges();
                                    },
                                    enableSuggestions: true,
                                    validator: (value) =>
                                        AppValidators.firstAndLastNameValidation(
                                            value ?? '', context),
                                    textInputAction: TextInputAction.next,
                                  ),
                                ),
                                SizedBox(height: 10.h),
                                _FieldCard(
                                  isDark: isDark,
                                  primary: primary,
                                  step: 2,
                                  title: context.tr(AppStrings.lastName),
                                  required: true,
                                  child: CustomTextFormField(
                                    title: context.tr(AppStrings.lastName),
                                    initialValue:
                                        currentDoctorModel.lastName ?? '',
                                    onChanged: (value) {
                                      cubit.lastName = value;
                                      cubit.checkForChanges();
                                    },
                                    enableSuggestions: true,
                                    textInputType: TextInputType.text,
                                    validator: (value) =>
                                        AppValidators.firstAndLastNameValidation(
                                            value ?? '', context),
                                    textInputAction: TextInputAction.next,
                                  ),
                                ),
                                SizedBox(height: 10.h),
                                _FieldCard(
                                  isDark: isDark,
                                  primary: primary,
                                  step: 3,
                                  title: context.tr(AppStrings.email),
                                  required: true,
                                  child: CustomTextFormField(
                                    title: context.tr(AppStrings.email),
                                    initialValue:
                                        currentDoctorModel.email ?? '',
                                    enableSuggestions: true,
                                    textInputType: TextInputType.text,
                                    validator: (value) =>
                                        AppValidators.emailValidator(
                                            value ?? ''),
                                    onChanged: (value) {
                                      cubit.email = value;
                                      cubit.checkForChanges();
                                    },
                                    textInputAction: TextInputAction.next,
                                  ),
                                ),
                                if (isMedicalStatistics) ...[
                                  SizedBox(height: 18.h),
                                  _SectionLabel(
                                    isDark: isDark,
                                    title: context
                                        .tr(AppStrings.researchDetails)
                                        .toUpperCase(),
                                  ),
                                  SizedBox(height: 8.h),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: _FieldCard(
                                          isDark: isDark,
                                          primary: primary,
                                          step: 4,
                                          title: context.tr(AppStrings.phone),
                                          child: CustomTextFormField(
                                            title: context.tr(AppStrings.phone),
                                            initialValue:
                                                currentDoctorModel.phone ?? '',
                                            onChanged: (value) {
                                              cubit.phone = value;
                                              cubit.checkForChanges();
                                            },
                                            textInputType: TextInputType.phone,
                                            validator: (value) => null,
                                            textInputAction:
                                                TextInputAction.next,
                                            inputFormatters: [
                                              LengthLimitingTextInputFormatter(
                                                  11)
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 10.w),
                                      Expanded(
                                        child: _FieldCard(
                                          isDark: isDark,
                                          primary: primary,
                                          step: 5,
                                          title: context.tr(AppStrings.age),
                                          child: CustomTextFormField(
                                            title: context.tr(AppStrings.age),
                                            initialValue:
                                                currentDoctorModel.age ?? '',
                                            onChanged: (value) {
                                              cubit.age = value;
                                              cubit.checkForChanges();
                                            },
                                            textInputType: TextInputType.number,
                                            validator: (value) => null,
                                            textInputAction:
                                                TextInputAction.next,
                                            inputFormatters: [
                                              LengthLimitingTextInputFormatter(
                                                  2)
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10.h),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: _FieldCard(
                                          isDark: isDark,
                                          primary: primary,
                                          step: 6,
                                          title: context.tr(AppStrings.job),
                                          required: true,
                                          child: CustomTextFormField(
                                            title:
                                                '${context.tr(AppStrings.job)} *',
                                            initialValue:
                                                currentDoctorModel.job ?? '',
                                            textInputType: TextInputType.text,
                                            onChanged: (value) {
                                              cubit.job = value;
                                              cubit.checkForChanges();
                                            },
                                            validator: (value) => AppValidators
                                                .fieldsIsEmptyValidation(
                                                    value ?? ''),
                                            textInputAction:
                                                TextInputAction.next,
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 10.w),
                                      Expanded(
                                        child: _FieldCard(
                                          isDark: isDark,
                                          primary: primary,
                                          step: 7,
                                          title:
                                              context.tr(AppStrings.workplace),
                                          required: true,
                                          child: CustomTextFormField(
                                            title:
                                                '${context.tr(AppStrings.workplace)} *',
                                            initialValue: currentDoctorModel
                                                    .workingplace ??
                                                '',
                                            textInputType: TextInputType.text,
                                            validator: (value) => AppValidators
                                                .fieldsIsEmptyValidation(
                                                    value ?? ''),
                                            onChanged: (value) {
                                              cubit.workplace = value;
                                              cubit.checkForChanges();
                                            },
                                            textInputAction:
                                                TextInputAction.next,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10.h),
                                  _FieldCard(
                                    isDark: isDark,
                                    primary: primary,
                                    step: 8,
                                    title: context
                                        .tr(AppStrings.registrationNumber),
                                    required: true,
                                    child: CustomTextFormField(
                                      title:
                                          '${context.tr(AppStrings.registrationNumber)} *',
                                      enabled: true,
                                      onChanged: (value) {
                                        cubit.registrationNumber = value;
                                        cubit.checkForChanges();
                                      },
                                      initialValue: currentDoctorModel
                                              .registrationNumber ??
                                          '',
                                      textInputType: TextInputType.number,
                                      validator: (value) =>
                                          AppValidators.fieldsIsEmptyValidation(
                                              value ?? ''),
                                      textInputAction: TextInputAction.next,
                                    ),
                                  ),
                                  SizedBox(height: 10.h),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: _FieldCard(
                                          isDark: isDark,
                                          primary: primary,
                                          step: 9,
                                          title:
                                              context.tr(AppStrings.specialty),
                                          required: true,
                                          child: CustomTextFormField(
                                            title:
                                                '${context.tr(AppStrings.specialty)} *',
                                            initialValue: currentDoctorModel
                                                    .specialty ??
                                                '',
                                            textInputType: TextInputType.text,
                                            validator: (value) => AppValidators
                                                .fieldsIsEmptyValidation(
                                                    value ?? ''),
                                            onChanged: (value) {
                                              cubit.specialty = value;
                                              cubit.checkForChanges();
                                            },
                                            textInputAction:
                                                TextInputAction.next,
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 10.w),
                                      Expanded(
                                        child: _FieldCard(
                                          isDark: isDark,
                                          primary: primary,
                                          step: 10,
                                          title: context
                                              .tr(AppStrings.highestDegree),
                                          required: true,
                                          child: _HighestDegreeDropdown(
                                            isDark: isDark,
                                            primary: primary,
                                            currentValue: currentDoctorModel
                                                .highestdegree,
                                            isRequired: true,
                                            onChanged: (val) {
                                              cubit.highestDegree = val ?? '';
                                              cubit.checkForChanges();
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                                SizedBox(height: 20.h),
                                if (currentDoctorModel.email.toString() ==
                                    'moatz2163@gmail.com') ...[
                                  AdminOnlyBadge(
                                    badgeText:
                                        context.tr(AppStrings.forMoatzOnly),
                                    style: BadgeStyle.premium,
                                    glowEffect: true,
                                    pulseAnimation: true,
                                    fontSize: 8.sp,
                                    badgePadding: EdgeInsets.symmetric(
                                      horizontal: 5.w,
                                      vertical: 1.h,
                                    ),
                                    child: _DangerButton(
                                      isDark: isDark,
                                      label:
                                          context.tr(AppStrings.deleteAccount),
                                      onTap: () {
                                        customSnackBar(
                                          context: context,
                                          message: context.tr(
                                            AppStrings
                                                .thirtyDaysToDeleteYourAccount,
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  SizedBox(height: 12.h),
                                ],
                                SizedBox(height: 70.h),
                              ],
                            ),
                          ),
                        ),
                        _SaveFooter(
                          isDark: isDark,
                          enabled: isProfileHasChanged,
                          onSave: () {
                            if (cubit.formKey.currentState?.validate() ??
                                false) {
                              cubit.updateDoctorProfile();
                            }
                          },
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ),
        );
      },
    );
  }
}

class _ProfileHeader extends StatelessWidget {
  final bool isDark;
  final Color scaffold;
  final Color primary;
  final Color titleColor;
  final Color muted;
  final double subtitleEase;
  final double subtitleT;
  final bool isMedicalStatistics;

  const _ProfileHeader({
    required this.isDark,
    required this.scaffold,
    required this.primary,
    required this.titleColor,
    required this.muted,
    required this.subtitleEase,
    required this.subtitleT,
    required this.isMedicalStatistics,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration.zero,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            HomeDashboardColors.header(isDark),
            scaffold,
          ],
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: EdgeInsets.fromLTRB(14.w, 4.h, 14.w, 4.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  _RoundIconButton(
                    isDark: isDark,
                    icon: Icons.arrow_back_ios_new_rounded,
                    onTap: () => Navigator.of(context).maybePop(),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: Text(
                      context.tr(AppStrings.editProfile),
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w800,
                        color: titleColor,
                        letterSpacing: -0.2,
                      ),
                    ),
                  ),
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                    decoration: BoxDecoration(
                      color: isDark
                          ? Colors.white.withOpacity(0.1)
                          : Colors.white.withOpacity(0.75),
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: Text(
                      isMedicalStatistics
                          ? context.tr(AppStrings.research)
                          : context.tr(AppStrings.member),
                      style: TextStyle(
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w700,
                        color: isDark ? Colors.white70 : primary,
                      ),
                    ),
                  ),
                ],
              ),
              ClipRect(
                child: Align(
                  alignment: Alignment.topCenter,
                  heightFactor: subtitleEase,
                  child: Opacity(
                    opacity: Curves.easeOut.transform(subtitleT).clamp(0.0, 1.0),
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(8.w, 10.h, 8.w, 2.h),
                      child: Text(
                        context.tr(
                          AppStrings
                              .updateYourAccountDetailsAndProfessionalInformation,
                        ),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w500,
                          color: muted,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RoundIconButton extends StatelessWidget {
  final bool isDark;
  final IconData icon;
  final VoidCallback onTap;

  const _RoundIconButton({
    required this.isDark,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: isDark ? const Color(0xFF2A2733) : Colors.white,
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: Container(
          width: 36.w,
          height: 36.w,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: isDark
                  ? const Color(0xFF3A3645)
                  : HomeDashboardColors.border(isDark),
            ),
          ),
          child: Icon(
            icon,
            size: 16.sp,
            color: HomeDashboardColors.title(isDark),
            textDirection: Directionality.of(context),
          ),
        ),
      ),
    );
  }
}

class _RoleToggle extends StatelessWidget {
  final bool isDark;
  final Color primary;
  final bool isMedicalStatistics;
  final String memberLabel;
  final String researchLabel;
  final VoidCallback onMember;
  final VoidCallback onResearch;

  const _RoleToggle({
    required this.isDark,
    required this.primary,
    required this.isMedicalStatistics,
    required this.memberLabel,
    required this.researchLabel,
    required this.onMember,
    required this.onResearch,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: HomeDashboardDecor.card(isDark).copyWith(
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: Row(
        children: [
          Expanded(
            child: _RoleChip(
              isDark: isDark,
              primary: primary,
              label: memberLabel,
              icon: Icons.person_outline_rounded,
              selected: !isMedicalStatistics,
              onTap: onMember,
            ),
          ),
          SizedBox(width: 6.w),
          Expanded(
            child: _RoleChip(
              isDark: isDark,
              primary: primary,
              label: researchLabel,
              icon: Icons.analytics_outlined,
              selected: isMedicalStatistics,
              onTap: onResearch,
            ),
          ),
        ],
      ),
    );
  }
}

class _RoleChip extends StatelessWidget {
  final bool isDark;
  final Color primary;
  final String label;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  const _RoleChip({
    required this.isDark,
    required this.primary,
    required this.label,
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(11.r),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 8.w),
          decoration: BoxDecoration(
            color: selected
                ? primary.withOpacity(isDark ? 0.22 : 0.12)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(11.r),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 15.sp,
                color: selected
                    ? primary
                    : HomeDashboardColors.subtitle(isDark),
              ),
              SizedBox(width: 5.w),
              Flexible(
                child: Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 11.5.sp,
                    fontWeight: FontWeight.w700,
                    color: selected
                        ? (isDark ? Colors.white : primary)
                        : HomeDashboardColors.subtitle(isDark),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  final bool isDark;
  final String title;

  const _SectionLabel({required this.isDark, required this.title});

  @override
  Widget build(BuildContext context) {
    final color = HomeDashboardColors.subtitle(isDark);
    final line = HomeDashboardColors.border(isDark);

    return Row(
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 10.sp,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.7,
            color: color,
          ),
        ),
        SizedBox(width: 10.w),
        Expanded(child: Container(height: 1, color: line)),
      ],
    );
  }
}

class _FieldCard extends StatelessWidget {
  final bool isDark;
  final Color primary;
  final int step;
  final String title;
  final bool required;
  final Widget child;

  const _FieldCard({
    required this.isDark,
    required this.primary,
    required this.step,
    required this.title,
    required this.child,
    this.required = false,
  });

  @override
  Widget build(BuildContext context) {
    final titleColor = HomeDashboardColors.title(isDark);

    return Container(
      padding: EdgeInsets.fromLTRB(12.w, 12.h, 12.w, 10.h),
      decoration: HomeDashboardDecor.card(isDark),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 22.w,
                height: 22.w,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: primary.withOpacity(isDark ? 0.2 : 0.12),
                  borderRadius: BorderRadius.circular(7.r),
                ),
                child: Text(
                  '$step',
                  style: TextStyle(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w800,
                    color: primary,
                  ),
                ),
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      child: Text(
                        title,
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w700,
                          height: 1.2,
                          color: titleColor,
                        ),
                      ),
                    ),
                    if (required)
                      Text(
                        ' *',
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w700,
                          height: 1.2,
                          color: HomeDashboardColors.danger,
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          child,
        ],
      ),
    );
  }
}

class _HighestDegreeDropdown extends StatelessWidget {
  final bool isDark;
  final Color primary;
  final String? currentValue;
  final bool isRequired;
  final ValueChanged<String?> onChanged;

  const _HighestDegreeDropdown({
    required this.isDark,
    required this.primary,
    required this.currentValue,
    required this.isRequired,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final fill = isDark
        ? AppColors.darkSurface
        : HomeDashboardColors.surfaceBg(isDark);
    final border = HomeDashboardColors.border(isDark);
    final textColor = HomeDashboardColors.title(isDark);
    final muted = HomeDashboardColors.subtitle(isDark);

    return DropdownButtonFormField<String>(
      value: currentValue != null &&
              currentValue!.isNotEmpty &&
              highestDegreeList.contains(currentValue)
          ? currentValue
          : null,
      hint: Text(
        isRequired
            ? '${context.tr(AppStrings.choose)} *'
            : context.tr(AppStrings.choose),
        style: TextStyle(
          fontSize: 12.sp,
          color: muted,
        ),
      ),
      items: highestDegreeList.map((value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(
            value,
            style: TextStyle(
              fontSize: 12.sp,
              color: textColor,
            ),
          ),
        );
      }).toList(),
      onChanged: onChanged,
      validator: (value) => isRequired
          ? AppValidators.fieldsIsEmptyValidation(value ?? '')
          : null,
      decoration: InputDecoration(
        filled: true,
        fillColor: fill,
        border: OutlineInputBorder(
          borderSide: BorderSide(color: border),
          borderRadius: BorderRadius.circular(12.r),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: border),
          borderRadius: BorderRadius.circular(12.r),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: primary),
          borderRadius: BorderRadius.circular(12.r),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      ),
      icon: Icon(
        Icons.keyboard_arrow_down_rounded,
        color: muted,
      ),
      style: TextStyle(
        fontSize: 12.sp,
        color: textColor,
      ),
      dropdownColor: HomeDashboardColors.cardBg(isDark),
      menuMaxHeight: 200,
    );
  }
}

class _SaveFooter extends StatelessWidget {
  final bool isDark;
  final bool enabled;
  final VoidCallback onSave;

  const _SaveFooter({
    required this.isDark,
    required this.enabled,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    final barBg = isDark ? HomeDashboardColors.cardBg(isDark) : Colors.white;
    final topBorder = HomeDashboardColors.border(isDark);
    final primary = HomeDashboardColors.primary(isDark);

    return Container(
      decoration: BoxDecoration(
        color: barBg,
        borderRadius: BorderRadius.vertical(top: Radius.circular(22.r)),
        border: Border(top: BorderSide(color: topBorder, width: 0.8)),
        boxShadow: isDark
            ? null
            : [
                BoxShadow(
                  color: Colors.black.withOpacity(0.06),
                  blurRadius: 16,
                  offset: const Offset(0, -4),
                ),
              ],
      ),
      child: SafeArea(
        top: false,
        minimum: EdgeInsets.only(bottom: 8.h),
        child: Padding(
          padding: EdgeInsets.fromLTRB(14.w, 10.h, 14.w, 2.h),
          child: Opacity(
            opacity: enabled ? 1 : 0.45,
            child: Container(
              height: 48.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.r),
                gradient: LinearGradient(
                  colors: isDark
                      ? [primary, const Color(0xFF5B6CFF)]
                      : [primary, const Color(0xFF5B6CFF)],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                boxShadow: enabled
                    ? [
                        BoxShadow(
                          color: primary.withOpacity(isDark ? 0.45 : 0.28),
                          blurRadius: 14,
                          offset: const Offset(0, 5),
                        ),
                      ]
                    : null,
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: enabled ? onSave : null,
                  borderRadius: BorderRadius.circular(16.r),
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(14.w, 6.h, 8.w, 6.h),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                context.tr(AppStrings.save),
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(height: 2.h),
                              Text(
                                context.tr(AppStrings.saveChangesToYourProfile),
                                style: TextStyle(
                                  fontSize: 9.sp,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white.withOpacity(0.8),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 30.w,
                          height: 30.w,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.22),
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          child: Icon(
                            Icons.check_rounded,
                            color: Colors.white,
                            size: 16.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _DangerButton extends StatelessWidget {
  final bool isDark;
  final String label;
  final VoidCallback onTap;

  const _DangerButton({
    required this.isDark,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    const danger = HomeDashboardColors.danger;
    return Material(
      color: isDark ? const Color(0xFF2A1515) : const Color(0xFFFFF1F1),
      borderRadius: BorderRadius.circular(14.r),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14.r),
        child: Container(
          width: double.infinity,
          height: 44.h,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14.r),
            border: Border.all(
              color: isDark ? const Color(0xFF7F2D2D) : const Color(0xFFFECACA),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.delete_outline_rounded, size: 16.sp, color: danger),
              SizedBox(width: 6.w),
              Text(
                label,
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w700,
                  color: danger,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProfileLoadingView extends StatelessWidget {
  final bool isDark;
  final Color primary;
  final String message;

  const _ProfileLoadingView({
    required this.isDark,
    required this.primary,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 28.w,
            height: 28.w,
            child: CircularProgressIndicator(
              strokeWidth: 2.5,
              color: primary,
            ),
          ),
          SizedBox(height: 12.h),
          Text(
            message,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
              color: HomeDashboardColors.subtitle(isDark),
            ),
          ),
        ],
      ),
    );
  }
}
