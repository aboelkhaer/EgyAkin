import 'package:egy_akin/app/shared/functions/animate_to_right_end_of_screen.dart';
import 'package:egy_akin/features/home/presentation/widgets/dashboard/home_dashboard_shared.dart';
import 'package:egy_akin/features/send_consultation/data/models/get_members_for_consultation_model_response.dart';
import 'package:egy_akin/features/send_consultation/presentation/cubit/send_consultation_state.dart';
import 'package:egy_akin/features/send_consultation/presentation/widgets/consultation_doctor_card.dart';
import 'package:egy_akin/features/send_consultation/presentation/widgets/selected_doctors_strip.dart';
import 'package:egy_akin/features/send_consultation/presentation/widgets/send_consultation_bottom_cta.dart';
import 'package:egy_akin/features/send_consultation/presentation/widgets/send_consultation_confirm_dialog.dart';
import 'package:egy_akin/features/send_consultation/presentation/widgets/send_consultation_header.dart';
import 'package:egy_akin/features/send_consultation/presentation/widgets/send_consultation_loading.dart';
import 'package:egy_akin/features/send_consultation/presentation/widgets/send_consultation_search_field.dart';

import '../../../../exports.dart';

class SendConsultationScreen extends StatefulWidget {
  final HomeModelResponse homeDataModel;
  final DoctorModel currentDoctorModel;
  final String patientId;
  final bool isSendConsultation;
  final String groupId;
  final bool isForAddNewDoctors;
  final String consultationId;
  final String ownerOfConsultationId;

  const SendConsultationScreen({
    super.key,
    required this.homeDataModel,
    required this.currentDoctorModel,
    required this.patientId,
    required this.isSendConsultation,
    required this.groupId,
    required this.isForAddNewDoctors,
    required this.consultationId,
    required this.ownerOfConsultationId,
  });

  @override
  State<SendConsultationScreen> createState() => _SendConsultationScreenState();
}

class _SendConsultationScreenState extends State<SendConsultationScreen> {
  @override
  void initState() {
    super.initState();
    if (widget.isForAddNewDoctors) {
      context
          .read<SendConsultationCubit>()
          .getMembersForConsultation(widget.consultationId);
    } else {
      context.read<SendConsultationCubit>().emitLoadedIfNotForMembers();
    }
  }

  bool get _isInviteeViewOnly =>
      widget.isSendConsultation &&
      widget.isForAddNewDoctors &&
      widget.ownerOfConsultationId != widget.currentDoctorModel.id.toString();

  bool get _isOwner =>
      widget.ownerOfConsultationId == widget.currentDoctorModel.id.toString();

  String _title(BuildContext context) {
    if (widget.isSendConsultation) {
      if (widget.isForAddNewDoctors) {
        return _isInviteeViewOnly
            ? context.tr(AppStrings.invitedDoctors)
            : context.tr(AppStrings.addDoctorsToConsultation);
      }
      return context.tr(AppStrings.sendConsultation);
    }
    return context.tr(AppStrings.inviteMembers);
  }

  String _subtitle(BuildContext context) {
    if (_isInviteeViewOnly) {
      return context.tr(AppStrings.doctorsAlreadyInvitedToThisConsultation);
    }
    if (widget.isSendConsultation) {
      if (widget.isForAddNewDoctors) {
        return context.tr(AppStrings.searchAndAddDoctorsToThisConsultation);
      }
      return context.tr(AppStrings.selectDoctorsToConsultOnThisPatient);
    }
    return context.tr(AppStrings.selectDoctorsToInviteIntoThisGroup);
  }

  String _ctaLabel(BuildContext context) {
    if (widget.isSendConsultation) {
      return widget.isForAddNewDoctors
          ? context.tr(AppStrings.add)
          : context.tr(AppStrings.apply);
    }
    return context.tr(AppStrings.invite);
  }

  String _ctaReadyTitle(BuildContext context) {
    if (widget.isSendConsultation) {
      return widget.isForAddNewDoctors
          ? context.tr(AppStrings.readyToAdd)
          : context.tr(AppStrings.readyToApply);
    }
    return context.tr(AppStrings.readyToInvite);
  }

  List<DoctorModelInConsultationModelResponse> _mergedSelected(
    SendConsultationCubit cubit,
    GetMembersForConsultationModelResponse? membersForConsultation,
  ) {
    final allDoctors = <DoctorModelInConsultationModelResponse>[
      ...cubit.doctorsChecked,
    ];

    if (widget.isForAddNewDoctors && membersForConsultation?.data != null) {
      for (final member in membersForConsultation!.data!) {
        if (!allDoctors.any((d) => d.id == member.id)) {
          allDoctors.add(member);
        }
      }
    }
    return allDoctors;
  }

  bool _isExistingMember(
    DoctorModelInConsultationModelResponse doctor,
    GetMembersForConsultationModelResponse? membersForConsultation,
  ) {
    return widget.isForAddNewDoctors &&
        (membersForConsultation?.data?.any((m) => m.id == doctor.id) ?? false);
  }

  void _openDoctorProfile(DoctorModelInConsultationModelResponse doctor) {
    navigatorKey.currentState?.pushNamed(
      AppRoutes.doctorInfoView,
      arguments: AppRoutesArgs.doctorInfoViewRouteArgs(
        doctorId: doctor.id.toString(),
        initialIndex: 0,
        currentDoctorModel: widget.currentDoctorModel,
        isSyndicateCardRequired:
            widget.homeDataModel.isSyndicateCardRequired.toString(),
        accountVerification: widget.homeDataModel.verified!,
        currentDoctorRole: widget.homeDataModel.role.toString(),
        currentDoctorPoints: int.parse(widget.homeDataModel.scoreValue!),
        homeDataModel: widget.homeDataModel,
        isNavigateToTheButtonOfInformationTab: false,
      ),
    );
  }

  void _onToggleDoctor({
    required SendConsultationCubit cubit,
    required DoctorModelInConsultationModelResponse doctor,
    required bool value,
    required GetMembersForConsultationModelResponse? membersForConsultation,
  }) {
    if (doctor.id.toString() == widget.currentDoctorModel.id.toString()) {
      return;
    }

    final existing = _isExistingMember(doctor, membersForConsultation);

    if (value) {
      if (!existing && !cubit.isDoctorChecked(doctor)) {
        cubit.doctorsChecked.add(doctor);
      }
    } else if (existing) {
      cubit.removeMemberFromConsultation(
        widget.consultationId,
        doctor.id.toString(),
      );
    } else {
      cubit.doctorsChecked.removeWhere((d) => d.id == doctor.id);
    }

    animateToRightEndOfScreen(cubit.horizontalScrollController);
    cubit.updateScreen();
  }

  void _onRemoveFromStrip({
    required SendConsultationCubit cubit,
    required DoctorModelInConsultationModelResponse doctor,
    required GetMembersForConsultationModelResponse? membersForConsultation,
  }) {
    if (_isExistingMember(doctor, membersForConsultation)) {
      cubit.removeMemberFromConsultation(
        widget.consultationId,
        doctor.id.toString(),
      );
    } else {
      cubit.doctorsChecked.removeWhere((d) => d.id == doctor.id);
      cubit.updateScreen();
    }
  }

  void _showSendDialog(BuildContext context, SendConsultationCubit cubit) {
    if (cubit.doctorsChecked.isEmpty) {
      customSnackBar(
        context: context,
        message: context.tr(AppStrings.pleaseSelectAtLeastOneDoctorToProceed),
      );
      return;
    }

    final themeState = context.read<ThemeBloc>().state;
    final isDark = themeState is ThemeLoaded && themeState.isDarkMode;

    showSendConsultationConfirmDialog(
      context: context,
      isDark: isDark,
      isConsultation: widget.isSendConsultation,
      selectedCount: cubit.doctorsChecked.length,
      confirmLabel: widget.isSendConsultation
          ? (widget.isForAddNewDoctors
              ? context.tr(AppStrings.add)
              : context.tr(AppStrings.send))
          : context.tr(AppStrings.invite),
      onNoteChanged: (value) {
        cubit.consultMessage = value;
      },
      onConfirm: () {
        if (widget.isSendConsultation) {
          if (widget.isForAddNewDoctors) {
            cubit.addDoctorsForConsultation(
              widget.consultationId,
              cubit.doctorsChecked.map((e) => e.id.toString()).toList(),
            );
          } else {
            cubit.sendConsultation(widget.patientId);
          }
        } else {
          cubit.sendGroupInvitation(widget.groupId);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final cubit = SendConsultationCubit.get(context);

    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        final isDark = themeState is ThemeLoaded && themeState.isDarkMode;

        return Scaffold(
          backgroundColor: HomeDashboardColors.scaffold(isDark),
          body: BlocConsumer<SendConsultationCubit, SendConsultationState>(
            listener: (context, state) {
              state.maybeWhen(
                orElse: () {},
                error: (message) {
                  if (message.isNotEmpty) {
                    customSnackBar(context: context, message: message);
                  }
                },
                loaded: (
                  isSearching,
                  isSearched,
                  message,
                  response,
                  counterChanges,
                  isSendingConsultation,
                  isSendedConsultation,
                  membersForConsultation,
                  isRemoveMemberFromConsultationLoading,
                  isRemoveMemberFromConsultationLoaded,
                ) {
                  if (message.isNotEmpty) {
                    customSnackBar(context: context, message: message);
                  }
                },
              );
            },
            builder: (context, state) {
              final selectedCount = cubit.doctorsChecked.length;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SendConsultationHeader(
                    isDark: isDark,
                    title: _title(context),
                    subtitle: _subtitle(context),
                    selectedCount: selectedCount,
                    onBack: () => Navigator.of(context).maybePop(),
                  ),
                  Expanded(
                    child: state.maybeWhen(
                      orElse: () => SendConsultationLoadingList(isDark: isDark),
                      error: (message) => SendConsultationEmptyState(
                        isDark: isDark,
                        icon: Icons.error_outline_rounded,
                        title: context.tr(AppStrings.somethingWentWrong),
                        subtitle: message,
                      ),
                      loaded: (
                        isSearching,
                        isSearched,
                        message,
                        response,
                        counterChanges,
                        isSendingConsultation,
                        isSendedConsultation,
                        membersForConsultation,
                        isRemoveMemberFromConsultationLoading,
                        isRemoveMemberFromConsultationLoaded,
                      ) {
                        if (isSendingConsultation) {
                          return SendConsultationSendingOverlay(
                            isDark: isDark,
                            label: widget.isSendConsultation
                                ? context.tr(AppStrings.sendingConsultation)
                                : context.tr(AppStrings.sendingInvitations),
                          );
                        }

                        final merged = _mergedSelected(
                          cubit,
                          membersForConsultation,
                        );

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            if (!_isInviteeViewOnly)
                              Padding(
                                padding:
                                    EdgeInsets.fromLTRB(16.w, 0, 16.w, 10.h),
                                child: SendConsultationSearchField(
                                  isDark: isDark,
                                  controller: cubit.searchController,
                                  onSubmit: () => cubit.getConsultationSearch(),
                                  onClear: () {
                                    cubit.searchController.clear();
                                    cubit.updateScreen();
                                  },
                                ),
                              ),
                            if (merged.isNotEmpty)
                              Padding(
                                padding:
                                    EdgeInsets.fromLTRB(16.w, 0, 16.w, 12.h),
                                child: SelectedDoctorsStrip(
                                  isDark: isDark,
                                  doctors: merged,
                                  scrollController:
                                      cubit.horizontalScrollController,
                                  canRemove: (doctor) {
                                    if (doctor.id.toString() ==
                                        widget.currentDoctorModel.id
                                            .toString()) {
                                      return false;
                                    }
                                    if (_isInviteeViewOnly) return false;
                                    if (_isExistingMember(
                                        doctor, membersForConsultation)) {
                                      return _isOwner;
                                    }
                                    return true;
                                  },
                                  onRemove: (doctor) => _onRemoveFromStrip(
                                    cubit: cubit,
                                    doctor: doctor,
                                    membersForConsultation:
                                        membersForConsultation,
                                  ),
                                  onTap: _openDoctorProfile,
                                ),
                              ),
                            Expanded(
                              child: _buildBody(
                                context: context,
                                cubit: cubit,
                                isDark: isDark,
                                isSearching: isSearching,
                                isSearched: isSearched,
                                response: response,
                                membersForConsultation: membersForConsultation,
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  if (!_isInviteeViewOnly)
                    state.maybeWhen(
                      loaded: (
                        _,
                        __,
                        ___,
                        ____,
                        _____,
                        isSendingConsultation,
                        ______,
                        _______,
                        ________,
                        _________,
                      ) {
                        if (isSendingConsultation) {
                          return const SizedBox.shrink();
                        }
                        return SendConsultationBottomCta(
                          isDark: isDark,
                          selectedCount: selectedCount,
                          label: _ctaLabel(context),
                          readyTitle: _ctaReadyTitle(context),
                          onPressed: () => _showSendDialog(context, cubit),
                        );
                      },
                      orElse: () => const SizedBox.shrink(),
                    ),
                ],
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildBody({
    required BuildContext context,
    required SendConsultationCubit cubit,
    required bool isDark,
    required bool isSearching,
    required bool isSearched,
    required GetConsultationSearchModelResponse? response,
    required GetMembersForConsultationModelResponse? membersForConsultation,
  }) {
    if (isSearching) {
      return SendConsultationLoadingList(isDark: isDark);
    }

    // Invitee / add-doctors: show members list when not searching results
    if (widget.isForAddNewDoctors &&
        !isSearched &&
        (membersForConsultation?.data?.isNotEmpty ?? false)) {
      final members = membersForConsultation!.data!;
      return ListView.separated(
        padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 100.h),
        itemCount: members.length,
        separatorBuilder: (_, __) => SizedBox(height: 10.h),
        itemBuilder: (context, index) {
          final doctor = members[index];
          final isSelf =
              doctor.id.toString() == widget.currentDoctorModel.id.toString();
          return ConsultationDoctorCard(
            isDark: isDark,
            doctor: doctor,
            isSelected: cubit.isDoctorChecked(doctor),
            isExistingMember: true,
            isCurrentUser: isSelf,
            selectionEnabled: _isOwner && !isSelf,
            onOpenProfile: () => _openDoctorProfile(doctor),
            onSelectionChanged: (_isOwner && !isSelf)
                ? (value) => _onToggleDoctor(
                      cubit: cubit,
                      doctor: doctor,
                      value: value,
                      membersForConsultation: membersForConsultation,
                    )
                : null,
          );
        },
      );
    }

    if (isSearched) {
      final doctors = response?.data ?? const [];
      if (doctors.isEmpty) {
        return SendConsultationEmptyState(
          isDark: isDark,
          icon: Icons.person_search_rounded,
          title: context.tr(AppStrings.noDoctorsFound),
          subtitle: context.tr(AppStrings.tryAnotherNameOrEmail),
        );
      }

      return ListView.separated(
        padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 100.h),
        itemCount: doctors.length,
        separatorBuilder: (_, __) => SizedBox(height: 10.h),
        itemBuilder: (context, index) {
          final doctor = doctors[index];
          final isSelf =
              doctor.id.toString() == widget.currentDoctorModel.id.toString();
          final existing = _isExistingMember(doctor, membersForConsultation);

          return ConsultationDoctorCard(
            isDark: isDark,
            doctor: doctor,
            isSelected: cubit.isDoctorChecked(doctor),
            isExistingMember: existing,
            isCurrentUser: isSelf,
            selectionEnabled: !isSelf,
            onOpenProfile: () => _openDoctorProfile(doctor),
            onSelectionChanged: isSelf
                ? null
                : (value) => _onToggleDoctor(
                      cubit: cubit,
                      doctor: doctor,
                      value: value,
                      membersForConsultation: membersForConsultation,
                    ),
          );
        },
      );
    }

    if (_isInviteeViewOnly && (membersForConsultation?.data?.isEmpty ?? true)) {
      return SendConsultationEmptyState(
        isDark: isDark,
        icon: Icons.groups_outlined,
        title: context.tr(AppStrings.noInvitedDoctorsYet),
        subtitle: context.tr(AppStrings.invitedDoctorsWillAppearHere),
      );
    }

    return SendConsultationEmptyState(
      isDark: isDark,
      icon: Icons.search_rounded,
      title: context.tr(AppStrings.findDoctors),
      subtitle: widget.isSendConsultation
          ? context.tr(AppStrings.searchByNameOrEmailToStartConsultation)
          : context.tr(AppStrings.searchByNameOrEmailToInviteMembers),
    );
  }
}
