import 'package:egy_akin/features/gfr_calculator/presentation/cubit/gfr_calculator_cubit.dart';
import 'package:egy_akin/features/gfr_calculator/presentation/widgets/gfr_calculator_theme.dart';
import 'package:egy_akin/features/gfr_calculator/presentation/widgets/gfr_calculator_ui.dart';
import 'package:egy_akin/features/gfr_calculator/presentation/widgets/gfr_history_section.dart';

import '../../../../exports.dart';

class GfrCalculatorScreen extends StatelessWidget {
  final HomeModelResponse homeDataModel;
  const GfrCalculatorScreen({super.key, required this.homeDataModel});

  @override
  Widget build(BuildContext context) {
    final cubit = GfrCalculatorCubit.get(context);

    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        final theme = GfrCalculatorTheme(
          themeState is ThemeLoaded && themeState.isDarkMode,
        );

        return Scaffold(
          backgroundColor: theme.scaffoldBg,
          appBar: AppBar(
            elevation: 0,
            iconTheme: IconThemeData(color: theme.title),
            scrolledUnderElevation: 0,
            backgroundColor: theme.scaffoldBg,
            foregroundColor: theme.title,
            title: Text(
              context.tr(AppStrings.gfrCalculator),
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 17.sp,
                color: theme.title,
              ),
            ),
          ),
          body: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 24.h),
              child: Form(
                key: cubit.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const GfrCalculatorHeroBanner(),
                    SizedBox(height: 16.h),
                    _EquationSection(cubit: cubit),
                    BlocBuilder<GfrCalculatorCubit, GfrCalculatorState>(
                      builder: (context, state) {
                        if (cubit.equationType !=
                            GfrCalculatorCubit.equationNkfEgfr) {
                          return const SizedBox.shrink();
                        }
                        return Padding(
                          padding: EdgeInsets.only(top: 12.h),
                          child: _NkfBiomarkerSection(cubit: cubit),
                        );
                      },
                    ),
                    BlocBuilder<GfrCalculatorCubit, GfrCalculatorState>(
                      builder: (context, state) {
                        if (cubit.equationType != 'Sobh Equation') {
                          return const SizedBox.shrink();
                        }
                        return Padding(
                          padding: EdgeInsets.only(top: 12.h),
                          child: _SobhFieldsSection(cubit: cubit),
                        );
                      },
                    ),
                    BlocBuilder<GfrCalculatorCubit, GfrCalculatorState>(
                      builder: (context, state) {
                        if (cubit.equationType != 'MDRD') {
                          return const SizedBox.shrink();
                        }
                        return Padding(
                          padding: EdgeInsets.only(top: 12.h),
                          child: _MdrdRaceSection(cubit: cubit),
                        );
                      },
                    ),
                    SizedBox(height: 12.h),
                    _PatientInputsSection(cubit: cubit),
                    SizedBox(height: 20.h),
                    CustomElevatedButton(
                      onPressed: () => cubit.calculateGFR(context),
                      title: context.tr(AppStrings.calculate),
                    ),
                    SizedBox(height: 24.h),
                    BlocBuilder<GfrCalculatorCubit, GfrCalculatorState>(
                      builder: (context, state) {
                        return GfrHistorySection(history: cubit.gfrHistory);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _EquationSection extends StatelessWidget {
  final GfrCalculatorCubit cubit;

  const _EquationSection({required this.cubit});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GfrCalculatorCubit, GfrCalculatorState>(
      builder: (context, state) {
        return GfrSectionCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              GfrSectionHeader(
                icon: Icons.functions_outlined,
                title: context.tr(AppStrings.equationType),
              ),
              SizedBox(height: 14.h),
              GfrSelectOption(
                label: context.tr(AppStrings.nkfEgfrCalculator),
                subtitle: 'Primary race-free equation (2021)',
                icon: Icons.medical_services_outlined,
                selected:
                    cubit.equationType == GfrCalculatorCubit.equationNkfEgfr,
                onTap: () => cubit.changeEquationTypeValue(
                  GfrCalculatorCubit.equationNkfEgfr,
                ),
              ),
              SizedBox(height: 8.h),
              GfrSelectOption(
                label: 'Sobh Equation',
                icon: Icons.straighten_outlined,
                selected: cubit.equationType == 'Sobh Equation',
                onTap: () => cubit.changeEquationTypeValue('Sobh Equation'),
              ),
              SizedBox(height: 8.h),
              GfrSelectOption(
                label: 'MDRD (2006)',
                subtitle: '4-variable IDMS equation',
                icon: Icons.calculate_outlined,
                selected: cubit.equationType == 'MDRD',
                onTap: () => cubit.changeEquationTypeValue('MDRD'),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _NkfBiomarkerSection extends StatelessWidget {
  final GfrCalculatorCubit cubit;

  const _NkfBiomarkerSection({required this.cubit});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GfrCalculatorCubit, GfrCalculatorState>(
      builder: (context, state) {
        return GfrSectionCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              GfrSectionHeader(
                icon: Icons.biotech_outlined,
                title: context.tr(AppStrings.nkfBiomarker),
                subtitle:
                    context.tr(AppStrings.pleaseEnterCreatinineOrCystatin),
              ),
              SizedBox(height: 12.h),
              Row(
                children: [
                  Expanded(
                    child: GfrChoiceChip(
                      label: context.tr(AppStrings.nkfUseCreatinine),
                      selected: cubit.nkfBiomarkerMode ==
                          GfrCalculatorCubit.nkfBiomarkerCreatinine,
                      onTap: () => cubit.changeNkfBiomarkerMode(
                        GfrCalculatorCubit.nkfBiomarkerCreatinine,
                      ),
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: GfrChoiceChip(
                      label: context.tr(AppStrings.nkfUseCystatin),
                      selected: cubit.nkfBiomarkerMode ==
                          GfrCalculatorCubit.nkfBiomarkerCystatin,
                      onTap: () => cubit.changeNkfBiomarkerMode(
                        GfrCalculatorCubit.nkfBiomarkerCystatin,
                      ),
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: GfrChoiceChip(
                      label: context.tr(AppStrings.nkfUseBoth),
                      selected: cubit.nkfBiomarkerMode ==
                          GfrCalculatorCubit.nkfBiomarkerBoth,
                      onTap: () => cubit.changeNkfBiomarkerMode(
                        GfrCalculatorCubit.nkfBiomarkerBoth,
                      ),
                    ),
                  ),
                ],
              ),
              if (cubit.showNkfCreatinineField ||
                  cubit.showNkfCystatinField) ...[
                SizedBox(height: 14.h),
                if (cubit.showNkfCreatinineField && cubit.showNkfCystatinField)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: CustomTextFormField(
                          fillColor: GfrCalculatorTheme.of(context).inputFill,
                          title: context.tr(AppStrings.creatinineMgDl),
                          textInputType: const TextInputType.numberWithOptions(
                            decimal: true,
                          ),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return context.tr(
                                AppStrings.pleaseEnterCreatinineLevel,
                              );
                            }
                            return null;
                          },
                          onChanged: (value) => cubit.creatinineForm = value,
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: CustomTextFormField(
                          fillColor: GfrCalculatorTheme.of(context).inputFill,
                          title: context.tr(AppStrings.cystatinCMgL),
                          textInputType: const TextInputType.numberWithOptions(
                            decimal: true,
                          ),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return context.tr(
                                AppStrings.pleaseEnterCystatinLevel,
                              );
                            }
                            return null;
                          },
                          onChanged: cubit.changeCystatinValue,
                        ),
                      ),
                    ],
                  )
                else if (cubit.showNkfCreatinineField)
                  CustomTextFormField(
                    fillColor: GfrCalculatorTheme.of(context).inputFill,
                    title: context.tr(AppStrings.creatinineMgDl),
                    textInputType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return context.tr(
                          AppStrings.pleaseEnterCreatinineLevel,
                        );
                      }
                      return null;
                    },
                    onChanged: (value) => cubit.creatinineForm = value,
                  )
                else
                  CustomTextFormField(
                    fillColor: GfrCalculatorTheme.of(context).inputFill,
                    title: context.tr(AppStrings.cystatinCMgL),
                    textInputType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return context.tr(
                          AppStrings.pleaseEnterCystatinLevel,
                        );
                      }
                      return null;
                    },
                    onChanged: cubit.changeCystatinValue,
                  ),
              ],
            ],
          ),
        );
      },
    );
  }
}

class _SobhFieldsSection extends StatelessWidget {
  final GfrCalculatorCubit cubit;

  const _SobhFieldsSection({required this.cubit});

  @override
  Widget build(BuildContext context) {
    return GfrSectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          GfrSectionHeader(
            icon: Icons.height_outlined,
            title:
                '${context.tr(AppStrings.height)} & ${context.tr(AppStrings.weight)}',
          ),
          SizedBox(height: 12.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: CustomTextFormField(
                  fillColor: GfrCalculatorTheme.of(context).inputFill,
                  title: context.tr(AppStrings.heightCm),
                  textInputType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return context.tr(AppStrings.pleaseEnterHeight);
                    }
                    return null;
                  },
                  onChanged: (value) => cubit.heightForm = value,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: CustomTextFormField(
                  fillColor: GfrCalculatorTheme.of(context).inputFill,
                  title: context.tr(AppStrings.weightKg),
                  textInputType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return context.tr(AppStrings.pleaseEnterWeight);
                    }
                    return null;
                  },
                  onChanged: (value) => cubit.weightForm = value,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _MdrdRaceSection extends StatelessWidget {
  final GfrCalculatorCubit cubit;

  const _MdrdRaceSection({required this.cubit});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GfrCalculatorCubit, GfrCalculatorState>(
      builder: (context, state) {
        return GfrSectionCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              GfrSectionHeader(
                icon: Icons.groups_outlined,
                title: context.tr(AppStrings.blackRace),
              ),
              SizedBox(height: 12.h),
              Row(
                children: [
                  Expanded(
                    child: GfrChoiceChip(
                      label: context.tr(AppStrings.yes),
                      selected: cubit.isBlackForm == 'Yes',
                      onTap: () => cubit.changeBlackRaceValue('Yes'),
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: GfrChoiceChip(
                      label: context.tr(AppStrings.no),
                      selected: cubit.isBlackForm == 'No',
                      onTap: () => cubit.changeBlackRaceValue('No'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class _PatientInputsSection extends StatelessWidget {
  final GfrCalculatorCubit cubit;

  const _PatientInputsSection({required this.cubit});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GfrCalculatorCubit, GfrCalculatorState>(
      builder: (context, state) {
        final isNkf = cubit.equationType == GfrCalculatorCubit.equationNkfEgfr;
        final showCreatinine = !isNkf;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            GfrSectionCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  GfrSectionHeader(
                    icon: Icons.person_outline,
                    title:
                        '${context.tr(AppStrings.gender)} & ${context.tr(AppStrings.age)}',
                  ),
                  SizedBox(height: 12.h),
                  Row(
                    children: [
                      Expanded(
                        child: GfrChoiceChip(
                          label: context.tr(AppStrings.male),
                          selected: cubit.genderForm == 'Male',
                          onTap: () => cubit.changeGenderValue('Male'),
                        ),
                      ),
                      SizedBox(width: 10.w),
                      Expanded(
                        child: GfrChoiceChip(
                          label: context.tr(AppStrings.female),
                          selected: cubit.genderForm == 'Female',
                          onTap: () => cubit.changeGenderValue('Female'),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 14.h),
                  CustomTextFormField(
                    fillColor: GfrCalculatorTheme.of(context).inputFill,
                    title: context.tr(AppStrings.age),
                    textInputType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return context.tr(AppStrings.pleaseEnterAge);
                      }
                      return null;
                    },
                    onChanged: (value) => cubit.ageForm = value,
                  ),
                ],
              ),
            ),
            if (showCreatinine) ...[
              SizedBox(height: 12.h),
              GfrSectionCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    GfrSectionHeader(
                      icon: Icons.science_outlined,
                      title: context.tr(AppStrings.creatinineMgDl),
                    ),
                    SizedBox(height: 12.h),
                    CustomTextFormField(
                      fillColor: GfrCalculatorTheme.of(context).inputFill,
                      title: context.tr(AppStrings.creatinineMgDl),
                      textInputType: const TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return context.tr(
                            AppStrings.pleaseEnterCreatinineLevel,
                          );
                        }
                        return null;
                      },
                      onChanged: (value) => cubit.creatinineForm = value,
                    ),
                  ],
                ),
              ),
            ],
          ],
        );
      },
    );
  }
}
