import 'package:egy_akin/app/shared/functions/permissions_helper.dart';
import 'package:egy_akin/features/all_doctors_patients/presentation/cubit/all_doctors_patients_state.dart';
import 'package:egy_akin/features/all_doctors_patients/presentation/pages/widgets/build_filter_widget.dart';
import 'package:egy_akin/features/home/presentation/widgets/dashboard/home_dashboard_shared.dart';
import 'package:egy_akin/features/home/presentation/widgets/patients/home_patient_widgets.dart';
import 'package:egy_akin/features/home/presentation/widgets/patients/home_patients_loading.dart';

import '../../../../../exports.dart';

class HomePatientsTab extends StatefulWidget {
  final HomeCubit cubit;

  const HomePatientsTab({
    super.key,
    required this.cubit,
  });

  @override
  State<HomePatientsTab> createState() => _HomePatientsTabState();
}

class _HomePatientsTabState extends State<HomePatientsTab> {
  bool _showMyPatients = true;
  bool _usingFilteredResults = false;
  bool _preparingFilters = false;
  bool _allPatientsLoaded = false;
  bool _myPatientsLoaded = false;
  int _lastHandledWithoutOutcomeSignal = 0;
  int _lastHandledDraftsSignal = 0;
  late final AllDoctorsPatientsCubit _filterCubit;
  late final CurrentDoctorPatientsCubit _myPatientsCubit;
  late final ScrollController _myScrollController;
  late final ScrollController _allScrollController;

  static const String _finalSubmitFilterId = '9901';
  static const String _outcomeFilterId = '9902';

  bool get _canViewAllPatients =>
      PermissionHelper.canPermission(AppPermissions.viewAllPatients);

  bool get _showMyOnly => !_canViewAllPatients || _showMyPatients;

  ScrollController get _activeScrollController =>
      _showMyOnly ? _myScrollController : _allScrollController;

  @override
  void initState() {
    super.initState();
    _filterCubit = sl<AllDoctorsPatientsCubit>();
    _myPatientsCubit = sl<CurrentDoctorPatientsCubit>();
    _myScrollController = ScrollController()..addListener(_onScroll);
    _allScrollController = ScrollController()..addListener(_onScroll);
    widget.cubit.withoutOutcomeFilterSignal
        .addListener(_onWithoutOutcomeFilterRequested);
    widget.cubit.draftsFilterSignal.addListener(_onDraftsFilterRequested);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Prefer an explicit home-section filter request over a normal load.
      final draftsSignal = widget.cubit.draftsFilterSignal.value;
      final outcomeSignal = widget.cubit.withoutOutcomeFilterSignal.value;
      if (draftsSignal > 0 && draftsSignal != _lastHandledDraftsSignal) {
        _onDraftsFilterRequested();
      } else if (outcomeSignal > 0 &&
          outcomeSignal != _lastHandledWithoutOutcomeSignal) {
        _onWithoutOutcomeFilterRequested();
      } else {
        _loadMyPatients();
      }
    });
  }

  @override
  void dispose() {
    widget.cubit.withoutOutcomeFilterSignal
        .removeListener(_onWithoutOutcomeFilterRequested);
    widget.cubit.draftsFilterSignal.removeListener(_onDraftsFilterRequested);
    _myScrollController.removeListener(_onScroll);
    _allScrollController.removeListener(_onScroll);
    _myScrollController.dispose();
    _allScrollController.dispose();
    _filterCubit.close();
    _myPatientsCubit.close();
    super.dispose();
  }

  void _onWithoutOutcomeFilterRequested() {
    if (!mounted) return;
    final signal = widget.cubit.withoutOutcomeFilterSignal.value;
    if (signal <= 0 || signal == _lastHandledWithoutOutcomeSignal) return;
    _lastHandledWithoutOutcomeSignal = signal;
    _applyPendingOutcomeFilter();
  }

  void _onDraftsFilterRequested() {
    if (!mounted) return;
    final signal = widget.cubit.draftsFilterSignal.value;
    if (signal <= 0 || signal == _lastHandledDraftsSignal) return;
    _lastHandledDraftsSignal = signal;
    _applyDraftsFilter();
  }

  /// Body: {"9901":"Yes","9902":"No","only_my_patients":"true","page":"1"}
  Future<void> _applyPendingOutcomeFilter() async {
    if (_filterCubit.isClosed) return;

    _filterCubit.resetFormData();
    _filterCubit.isApplyFilterDone = false;
    _filterCubit.totalPatientInFilter = 0;
    _filterCubit.isLastPageFilter = false;
    _filterCubit.currentPageInFilter = 1;
    _filterCubit.isLoadingMoreForScrollForFilter = false;
    _filterCubit.formData[_finalSubmitFilterId] = 'Yes';
    _filterCubit.formData[_outcomeFilterId] = 'No';

    setState(() {
      _showMyPatients = true;
      _usingFilteredResults = true;
    });

    await _filterCubit.applyPatientFilters('true');
  }

  /// Body: {"9901":"No","only_my_patients":"true","page":"1"}
  /// Drafts = unfinished patients (final submit is No).
  Future<void> _applyDraftsFilter() async {
    if (_filterCubit.isClosed) return;

    _filterCubit.resetFormData();
    _filterCubit.isApplyFilterDone = false;
    _filterCubit.totalPatientInFilter = 0;
    _filterCubit.isLastPageFilter = false;
    _filterCubit.currentPageInFilter = 1;
    _filterCubit.isLoadingMoreForScrollForFilter = false;
    _filterCubit.formData[_finalSubmitFilterId] = 'No';

    setState(() {
      _showMyPatients = true;
      _usingFilteredResults = true;
    });

    await _filterCubit.applyPatientFilters('true');
  }

  void _onScroll() {
    final controller = _activeScrollController;
    if (!controller.hasClients) return;

    final position = controller.position;
    if (!position.hasContentDimensions) return;

    // Pull-to-refresh / top overscroll must not trigger pagination.
    if (position.pixels <= 0 || position.maxScrollExtent <= 0) return;

    const threshold = 200.0;
    if (position.maxScrollExtent - position.pixels > threshold) return;

    if (_usingFilteredResults) {
      if (_filterCubit.isClosed) return;
      if (_filterCubit.isLastPageFilter) return;
      if (_filterCubit.isLoadingMoreForScrollForFilter) return;
      _filterCubit.isLoadingMoreForScrollForFilter = true;
      _filterCubit.applyPatientFiltersLoadMore();
      return;
    }

    if (_showMyOnly) {
      if (_myPatientsCubit.isClosed) return;
      if (_myPatientsCubit.isLastPage) return;
      if (_myPatientsCubit.isLoadingMoreForScroll) return;
      _myPatientsCubit.isLoadingMoreForScroll = true;
      _myPatientsCubit.loadMorePatients();
      return;
    }

    if (_filterCubit.isClosed) return;
    if (_filterCubit.isLastPage) return;
    if (_filterCubit.isLoadingMoreForScroll) return;
    _filterCubit.isLoadingMoreForScroll = true;
    _filterCubit.loadMorePatients();
  }

  Future<void> _onRefreshMyPatients() async {
    if (_usingFilteredResults && _showMyOnly) {
      await _filterCubit.applyPatientFilters('true');
      if (mounted) setState(() {});
      return;
    }
    if (!_myPatientsCubit.isClosed) {
      _myPatientsCubit.isLoadingMoreForScroll = false;
    }
    await _loadMyPatients(force: true, showLoading: true);
    if (mounted) setState(() {});
  }

  Future<void> _onRefreshAllPatients() async {
    if (!_canViewAllPatients) {
      await _onRefreshMyPatients();
      return;
    }
    if (_usingFilteredResults && !_showMyOnly) {
      await _filterCubit.applyPatientFilters('false');
      if (mounted) setState(() {});
      return;
    }
    if (!_filterCubit.isClosed) {
      _filterCubit.isLoadingMoreForScroll = false;
    }
    await _loadAllPatients(force: true, showLoading: true);
    if (mounted) setState(() {});
  }

  void _resetFilterFlags() {
    _filterCubit.resetFormData();
    _filterCubit.isApplyFilterDone = false;
    _filterCubit.totalPatientInFilter = 0;
    _filterCubit.isLastPageFilter = false;
    _filterCubit.currentPageInFilter = 1;
    _filterCubit.isLoadingMoreForScrollForFilter = false;
  }

  Future<void> _loadAllPatients({
    bool force = false,
    bool showLoading = true,
  }) async {
    if (_filterCubit.isClosed) return;
    if (!force && _allPatientsLoaded) return;

    await _filterCubit.getCurrentDoctorPatients(showLoading: showLoading);
    if (!mounted || _filterCubit.isClosed) return;

    final ok = _filterCubit.state.maybeWhen(
      loaded: (_, __, ___, ____, _____, ______, _______, ________) => true,
      orElse: () => false,
    );
    if (ok) {
      setState(() => _allPatientsLoaded = true);
    }
  }

  Future<void> _loadMyPatients({
    bool force = false,
    bool showLoading = true,
  }) async {
    if (_myPatientsCubit.isClosed) return;
    if (!force && _myPatientsLoaded) return;

    await _myPatientsCubit.getCurrentDoctorPatients(showLoading: showLoading);
    if (!mounted || _myPatientsCubit.isClosed) return;

    final ok = _myPatientsCubit.state.maybeWhen(
      loaded: (_, __, ___, ____, _____, ______, _______, ________, _________,
              __________) =>
          true,
      orElse: () => false,
    );
    if (ok) {
      setState(() => _myPatientsLoaded = true);
    }
  }

  void _clearFilters() {
    final wasFiltered = _usingFilteredResults;
    _resetFilterFlags();
    setState(() {
      _usingFilteredResults = false;
    });
    if (!wasFiltered) return;
    if (_showMyOnly) {
      _loadMyPatients(force: true);
    } else {
      _loadAllPatients(force: true);
    }
  }

  void _onToggleChanged(bool showMyPatients) {
    if (!_canViewAllPatients) return;
    if (showMyPatients == _showMyPatients) return;
    final wasFiltered = _usingFilteredResults;
    _resetFilterFlags();
    setState(() {
      _usingFilteredResults = false;
      _showMyPatients = showMyPatients;
    });
    if (showMyPatients) {
      _loadMyPatients(force: wasFiltered || !_myPatientsLoaded);
    } else {
      _loadAllPatients(force: wasFiltered || !_allPatientsLoaded);
    }
  }

  void _openPatientSections(PatientHomeDataModel patient) {
    final homeData = widget.cubit.homeDataModel;
    final patientId = patient.id?.toString();
    if (patientId == null || patientId.isEmpty) return;

    navigatorKey.currentState?.pushNamed(
      AppRoutes.patientSections,
      arguments: AppRoutesArgs.patientSectionsRouteArguments(
        patientId: patientId,
        currentDoctorModel: widget.cubit.currentDoctorModel,
        currentDoctorPoints: int.tryParse(homeData.scoreValue ?? '0') ?? 0,
        currentDoctorRole: homeData.role.toString(),
        homeDataModel: homeData,
        isAllDataOpen: _canViewAllPatients && !_showMyOnly,
      ),
    );
  }

  void _openOutcome(PatientHomeDataModel patient) {
    final homeData = widget.cubit.homeDataModel;
    final patientId = patient.id?.toString();
    if (patientId == null || patientId.isEmpty) return;

    navigatorKey.currentState?.pushNamed(
      AppRoutes.outcome,
      arguments: AppRoutesArgs.outcomeRouteArgs(
        verified: homeData.verified ?? false,
        outcomeStatus: patient.sections?.outcomeStatus ?? false,
        patientName: patient.name?.toString() ?? '',
        patientId: patientId,
        currentDoctorModel: widget.cubit.currentDoctorModel,
        doctorId: patient.doctor?.id?.toString() ??
            widget.cubit.currentDoctorModel.id.toString(),
        isSyndicateCardRequired: homeData.isSyndicateCardRequired ?? '',
        homeDataModel: homeData,
        currentDoctorPoints: int.tryParse(homeData.scoreValue ?? '0') ?? 0,
        currentDoctorRole: homeData.role.toString(),
      ),
    );
  }

  void _openComments(PatientHomeDataModel patient) {
    final homeData = widget.cubit.homeDataModel;
    final patientId = patient.id?.toString();
    if (patientId == null || patientId.isEmpty) return;

    navigatorKey.currentState?.pushNamed(
      AppRoutes.comments,
      arguments: AppRoutesArgs.patientCommentsRouteArgs(
        patientId: patientId,
        currentDoctorModel: widget.cubit.currentDoctorModel,
        verified: homeData.verified ?? false,
        patientName: patient.name?.toString() ?? '',
        currentDoctorPoints: int.tryParse(homeData.scoreValue ?? '0') ?? 0,
        homeDataModel: homeData,
        isSyndicateCardRequired: homeData.isSyndicateCardRequired ?? '',
        currentDoctorRole: homeData.role.toString(),
      ),
    );
  }

  Future<void> _openDoctorProfile(PatientHomeDataModel patient) async {
    final doctorId = patient.doctor?.id?.toString();
    if (doctorId == null || doctorId.isEmpty) return;

    final homeData = widget.cubit.homeDataModel;
    final currentDoctor = widget.cubit.currentDoctorModel;
    final isOwnProfile = currentDoctor.id.toString() == doctorId;

    final hasPermission = await PermissionHelper.hasPermission(
      AppPermissions.viewDoctorProfile,
    );

    if (!mounted) return;

    if (!hasPermission && !isOwnProfile) {
      showCustomDialog(
        context: context,
        title: context.tr(AppStrings.attention),
        description: context.tr(
          AppStrings.youDontHavePermissionToViewDoctorProfiles,
        ),
        coloredButtonText: context.tr(AppStrings.ok),
        coloredButtonOnTap: () => navigatorKey.currentState?.pop(),
        isNoColorShow: false,
      );
      return;
    }

    navigatorKey.currentState?.pushNamed(
      AppRoutes.doctorInfoView,
      arguments: AppRoutesArgs.doctorInfoViewRouteArgs(
        doctorId: doctorId,
        currentDoctorModel: currentDoctor,
        isSyndicateCardRequired: homeData.isSyndicateCardRequired ?? '',
        accountVerification: homeData.verified ?? false,
        currentDoctorRole: homeData.role.toString(),
        currentDoctorPoints: int.tryParse(homeData.scoreValue ?? '0') ?? 0,
        homeDataModel: homeData,
        initialIndex: 0,
        isNavigateToTheButtonOfInformationTab: false,
      ),
    );
  }

  Future<void> _openFilter() async {
    if (_preparingFilters) return;

    final hasFilters = (_filterCubit.filtersOptions.data?.isNotEmpty ?? false) ||
        _filterCubit.state.maybeWhen(
          loaded: (response, _, __, ___, ____, _____, ______, _______) =>
              response.filters?.isNotEmpty ?? false,
          orElse: () => false,
        );

    if (!hasFilters) {
      setState(() => _preparingFilters = true);
      final ok = await _filterCubit.prefetchFilterOptions();
      if (!mounted) return;
      setState(() => _preparingFilters = false);

      if (!ok) {
        customSnackBar(
          context: context,
          message: context.tr(AppStrings.somethingWentWrong),
        );
        return;
      }
    }

    if (!mounted) return;

    final filters = _filterCubit.filtersOptions.data ??
        _filterCubit.state.maybeWhen(
          loaded: (response, _, __, ___, ____, _____, ______, _______) =>
              response.filters,
          orElse: () => null,
        );

    showCustomBottomSheet(
      context: context,
      isFilter: true,
      builder: (sheetContext) {
        return BlocProvider<AllDoctorsPatientsCubit>.value(
          value: _filterCubit,
          child: BuildFilterWidget(
            filters: filters,
            cubit: _filterCubit,
            isCurrentDoctor: _showMyOnly,
          ),
        );
      },
    );
  }

  Future<void> _openExportedFile(String fileUrl) async {
    try {
      final uri = Uri.parse(fileUrl);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else if (mounted) {
        customSnackBar(
          context: context,
          message: '${context.tr(AppStrings.cannotOpenUrl)}: $fileUrl',
        );
      }
    } catch (_) {
      if (mounted) {
        customSnackBar(
          context: context,
          message: context.tr(AppStrings.errorOpeningFile),
        );
      }
    } finally {
      if (!_filterCubit.isClosed) {
        _filterCubit.resetExportState();
      }
    }
  }

  void _downloadPatients() {
    if (_filterCubit.isClosed) return;
    _filterCubit.exportFilteredPatients(_showMyOnly);
  }

  bool get _canExport {
    return PermissionHelper.canPermission(
          AppPermissions.exportFilteredPatients,
        ) ||
        PermissionHelper.canPermission(
          AppPermissions.viewExportPatientsButtonInAllPatientsForAdmin,
        );
  }

  List<PatientHomeDataModel> _patientsFromFilterState() {
    return _filterCubit.state.maybeWhen(
      loaded: (response, _, __, ___, ____, _____, ______, _______) =>
          response.data?.data ?? const <PatientHomeDataModel>[],
      orElse: () => const <PatientHomeDataModel>[],
    );
  }

  List<PatientHomeDataModel> _patientsFromMyState() {
    return _myPatientsCubit.state.maybeWhen(
      loaded: (response, _, __, ___, ____, _____, ______, _______, ________,
              _________) =>
          response.data?.data ?? const <PatientHomeDataModel>[],
      orElse: () => const <PatientHomeDataModel>[],
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AllDoctorsPatientsCubit>.value(value: _filterCubit),
        BlocProvider<CurrentDoctorPatientsCubit>.value(value: _myPatientsCubit),
      ],
      child: BlocConsumer<AllDoctorsPatientsCubit, AllDoctorsPatientsState>(
        listener: (context, state) {
          state.maybeWhen(
            orElse: () {},
            error: (message) {
              if (message.isNotEmpty) {
                customSnackBar(context: context, message: message);
              }
            },
            loaded: (
              response,
              isSeeMore,
              message,
              isApplyFilterLoading,
              isApplyFilterLoaded,
              isExportLoading,
              isExportLoaded,
              fileUrl,
            ) {
              if (message.isNotEmpty) {
                customSnackBar(context: context, message: message);
              }
              if (isApplyFilterLoaded && _filterCubit.isApplyFilterDone) {
                setState(() {
                  _usingFilteredResults = true;
                });
              }
              if (!_showMyPatients && !_filterCubit.isApplyFilterDone) {
                _allPatientsLoaded = true;
              }
              if (isExportLoaded && fileUrl != null && fileUrl.isNotEmpty) {
                _openExportedFile(fileUrl);
              }
            },
          );
        },
        builder: (context, filterState) {
          return BlocConsumer<CurrentDoctorPatientsCubit,
              CurrentDoctorPatientsState>(
            listener: (context, state) {
              state.maybeWhen(
                orElse: () {},
                error: (message) {
                  if (message.isNotEmpty) {
                    customSnackBar(context: context, message: message);
                  }
                },
                loaded: (
                  response,
                  isSeeMore,
                  message,
                  isApplyFilterLoading,
                  isApplyFilterLoaded,
                  isExportLoading,
                  isExportLoaded,
                  fileUrl,
                  filters,
                  totalPatientInFilter,
                ) {
                  if (message.isNotEmpty) {
                    customSnackBar(context: context, message: message);
                  }
                  if (_showMyPatients && !_usingFilteredResults) {
                    _myPatientsLoaded = true;
                  }
                },
              );
            },
            builder: (context, myState) {
              return BlocBuilder<ThemeBloc, ThemeState>(
                builder: (context, themeState) {
                  final isDark =
                      themeState is ThemeLoaded && themeState.isDarkMode;
                  final primary = HomeDashboardColors.primary(isDark);

                  final isApplyFilterLoading = filterState.maybeWhen(
                    loading: () => true,
                    loaded:
                        (_, __, ___, loading, ____, _____, ______, _______) =>
                            loading,
                    orElse: () => false,
                  );

                  final isExportLoading = filterState.maybeWhen(
                    loaded:
                        (_, __, ___, ____, _____, loading, ______, _______) =>
                            loading,
                    orElse: () => false,
                  );

                  final filterSeeMore = filterState.maybeWhen(
                    loaded:
                        (_, seeMore, __, ___, ____, _____, ______, _______) =>
                            seeMore,
                    orElse: () => false,
                  );

                  final mySeeMore = myState.maybeWhen(
                    loaded: (_, seeMore, __, ___, ____, _____, ______, _______,
                            ________, _________) =>
                        seeMore,
                    orElse: () => false,
                  );

                  final isLoadingMyPatients = _showMyOnly &&
                      !_usingFilteredResults &&
                      myState.maybeWhen(
                        loading: () => true,
                        orElse: () => false,
                      );

                  final isLoadingFilteredMyPatients = _showMyOnly &&
                      _usingFilteredResults &&
                      isApplyFilterLoading;

                  final isLoadingAllPatients = _canViewAllPatients &&
                      !_showMyOnly &&
                      !_usingFilteredResults &&
                      filterState.maybeWhen(
                        loading: () => true,
                        orElse: () => false,
                      );

                  final filteredPatients = _patientsFromFilterState();
                  final myApiPatients = _patientsFromMyState();
                  final allApiPatients = filteredPatients;

                  final homeMyCount = int.tryParse(
                        widget.cubit.homeDataModel.doctorPatientCount ?? '',
                      ) ??
                      0;
                  final homeAllCount = int.tryParse(
                        widget.cubit.homeDataModel.allPatientCount ?? '',
                      ) ??
                      0;

                  final myApiTotal = myState.maybeWhen(
                    loaded: (response, _, __, ___, ____, _____, ______, _______,
                            ________, _________) =>
                        response.data?.total ??
                        int.tryParse(response.patientCount ?? ''),
                    orElse: () => null,
                  );
                  final allApiTotal = filterState.maybeWhen(
                    loaded:
                        (response, _, __, ___, ____, _____, ______, _______) =>
                            response.data?.total ??
                            int.tryParse(response.patientCount ?? ''),
                    orElse: () => null,
                  );

                  // Toggle badges prefer home totals; list header can use
                  // filter/API totals when a filter is active.
                  final myCount =
                      homeMyCount > 0 ? homeMyCount : (myApiTotal ?? myApiPatients.length);
                  final allCount = homeAllCount > 0
                      ? homeAllCount
                      : (allApiTotal ?? allApiPatients.length);

                  final patients = _usingFilteredResults
                      ? filteredPatients
                      : (_showMyOnly ? myApiPatients : allApiPatients);

                  final selectedLabel = _showMyOnly
                      ? context.tr(AppStrings.myPatients)
                      : context.tr(AppStrings.allPatients);

                  final showClearFilters = _usingFilteredResults;
                  final isPendingOutcomeFilter =
                      _usingFilteredResults &&
                      _filterCubit.formData[_finalSubmitFilterId] == 'Yes' &&
                      _filterCubit.formData[_outcomeFilterId] == 'No';
                  final isDraftsFilter = _usingFilteredResults &&
                      _filterCubit.formData[_finalSubmitFilterId] == 'No' &&
                      (_filterCubit.formData[_outcomeFilterId] == null ||
                          _filterCubit.formData[_outcomeFilterId]!
                              .toString()
                              .isEmpty);
                  final pendingOutcomeHomeCount = int.tryParse(
                        widget.cubit.homeDataModel.pendingOutcomeCount ?? '',
                      ) ??
                      0;
                  final draftsHomeCount = int.tryParse(
                        widget.cubit.homeDataModel.draftCount ?? '',
                      ) ??
                      0;

                  // Prefer filter total when ready. For pending-outcomes / drafts,
                  // use home counts until then — never flash page size.
                  final int? selectedCount;
                  if (_usingFilteredResults) {
                    if (_filterCubit.totalPatientInFilter > 0) {
                      selectedCount = _filterCubit.totalPatientInFilter;
                    } else if (isPendingOutcomeFilter &&
                        pendingOutcomeHomeCount > 0) {
                      selectedCount = pendingOutcomeHomeCount;
                    } else if (isDraftsFilter && draftsHomeCount > 0) {
                      selectedCount = draftsHomeCount;
                    } else if (isApplyFilterLoading) {
                      selectedCount = null;
                    } else {
                      selectedCount = filteredPatients.length;
                    }
                  } else {
                    selectedCount = _showMyOnly ? myCount : allCount;
                  }
                  final selectedCountLabel =
                      selectedCount == null ? '' : ' ($selectedCount)';

                  final showLoadMoreFooter = _usingFilteredResults
                      ? filterSeeMore
                      : (_showMyOnly ? mySeeMore : filterSeeMore);

                  return Material(
                    color: HomeDashboardColors.scaffold(isDark),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              _PatientsSearchField(isDark: isDark),
                              SizedBox(height: 12.h),
                              HomePatientsToggle(
                                isDark: isDark,
                                showMyPatients: _showMyOnly,
                                myPatientsCount: myCount,
                                allPatientsCount: allCount,
                                showAllPatientsTab: _canViewAllPatients,
                                onChanged: _onToggleChanged,
                              ),
                              SizedBox(height: 12.h),
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      showClearFilters
                                          ? (isPendingOutcomeFilter
                                              ? '${context.tr(AppStrings.pendingOutcomesLabel)} · $selectedLabel$selectedCountLabel'
                                              : '${context.tr(AppStrings.filteredLabel)} · $selectedLabel$selectedCountLabel')
                                          : '$selectedLabel$selectedCountLabel',
                                      style: TextStyle(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w700,
                                        color: HomeDashboardColors.title(
                                            isDark),
                                      ),
                                    ),
                                  ),
                                  if (showClearFilters) ...[
                                    GestureDetector(
                                      onTap: _clearFilters,
                                      child: Text(
                                        context.tr(AppStrings.clear),
                                        style: TextStyle(
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w600,
                                          color: HomeDashboardColors.subtitle(
                                              isDark),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 12.w),
                                  ],
                                  if (_usingFilteredResults &&
                                      _canExport &&
                                      patients.isNotEmpty) ...[
                                    GestureDetector(
                                      onTap: (isExportLoading ||
                                              isApplyFilterLoading ||
                                              patients.isEmpty)
                                          ? null
                                          : _downloadPatients,
                                      child: Row(
                                        children: [
                                          if (isExportLoading)
                                            SizedBox(
                                              width: 14.sp,
                                              height: 14.sp,
                                              child:
                                                  CircularProgressIndicator(
                                                strokeWidth: 2,
                                                color: primary,
                                              ),
                                            )
                                          else
                                            Icon(
                                              Icons.download_rounded,
                                              size: 16.sp,
                                              color: primary,
                                            ),
                                          SizedBox(width: 4.w),
                                          Text(
                                            context.tr(AppStrings.download),
                                            style: TextStyle(
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.w600,
                                              color: primary,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(width: 12.w),
                                  ],
                                  GestureDetector(
                                    onTap: (_preparingFilters ||
                                            isApplyFilterLoading)
                                        ? null
                                        : _openFilter,
                                    child: Row(
                                      children: [
                                        if (_preparingFilters ||
                                            isApplyFilterLoading)
                                          SizedBox(
                                            width: 14.sp,
                                            height: 14.sp,
                                            child: CircularProgressIndicator(
                                              strokeWidth: 2,
                                              color: primary,
                                            ),
                                          )
                                        else
                                          Icon(
                                            Icons.tune_rounded,
                                            size: 16.sp,
                                            color: primary,
                                          ),
                                        SizedBox(width: 4.w),
                                        Text(
                                          context.tr(AppStrings.filter),
                                          style: TextStyle(
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.w600,
                                            color: primary,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 12.h),
                            ],
                          ),
                        ),
                        Expanded(
                          child: _canViewAllPatients
                              ? IndexedStack(
                                  index: _showMyOnly ? 0 : 1,
                                  sizing: StackFit.expand,
                                  children: [
                                    _PatientsRefreshList(
                                      key: const PageStorageKey(
                                          'my_patients_list'),
                                      isDark: isDark,
                                      primary: primary,
                                      scrollController: _myScrollController,
                                      onRefresh: _onRefreshMyPatients,
                                      isInitialLoading: isLoadingMyPatients ||
                                          isLoadingFilteredMyPatients,
                                      patients: _showMyOnly
                                          ? patients
                                          : (_usingFilteredResults
                                              ? filteredPatients
                                              : myApiPatients),
                                      showLoadMoreFooter: _showMyOnly &&
                                          showLoadMoreFooter,
                                      showClearFilters: showClearFilters,
                                      onOpenPatient: _openPatientSections,
                                      onOpenOutcome: _openOutcome,
                                      onOpenComments: _openComments,
                                      onOpenDoctor: _openDoctorProfile,
                                    ),
                                    _PatientsRefreshList(
                                      key: const PageStorageKey(
                                          'all_patients_list'),
                                      isDark: isDark,
                                      primary: primary,
                                      scrollController: _allScrollController,
                                      onRefresh: _onRefreshAllPatients,
                                      isInitialLoading: isLoadingAllPatients,
                                      patients: !_showMyOnly
                                          ? patients
                                          : (_usingFilteredResults
                                              ? filteredPatients
                                              : allApiPatients),
                                      showLoadMoreFooter: !_showMyOnly &&
                                          showLoadMoreFooter,
                                      showClearFilters: showClearFilters,
                                      onOpenPatient: _openPatientSections,
                                      onOpenOutcome: _openOutcome,
                                      onOpenComments: _openComments,
                                      onOpenDoctor: _openDoctorProfile,
                                    ),
                                  ],
                                )
                              : _PatientsRefreshList(
                                  key: const PageStorageKey('my_patients_list'),
                                  isDark: isDark,
                                  primary: primary,
                                  scrollController: _myScrollController,
                                  onRefresh: _onRefreshMyPatients,
                                  isInitialLoading: isLoadingMyPatients ||
                                      isLoadingFilteredMyPatients,
                                  patients: patients,
                                  showLoadMoreFooter: showLoadMoreFooter,
                                  showClearFilters: showClearFilters,
                                  onOpenPatient: _openPatientSections,
                                  onOpenOutcome: _openOutcome,
                                  onOpenComments: _openComments,
                                  onOpenDoctor: _openDoctorProfile,
                                ),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}

class _PatientsRefreshList extends StatelessWidget {
  final bool isDark;
  final Color primary;
  final ScrollController scrollController;
  final Future<void> Function() onRefresh;
  final bool isInitialLoading;
  final List<PatientHomeDataModel> patients;
  final bool showLoadMoreFooter;
  final bool showClearFilters;
  final ValueChanged<PatientHomeDataModel> onOpenPatient;
  final ValueChanged<PatientHomeDataModel> onOpenOutcome;
  final ValueChanged<PatientHomeDataModel> onOpenComments;
  final ValueChanged<PatientHomeDataModel> onOpenDoctor;

  const _PatientsRefreshList({
    super.key,
    required this.isDark,
    required this.primary,
    required this.scrollController,
    required this.onRefresh,
    required this.isInitialLoading,
    required this.patients,
    required this.showLoadMoreFooter,
    required this.showClearFilters,
    required this.onOpenPatient,
    required this.onOpenOutcome,
    required this.onOpenComments,
    required this.onOpenDoctor,
  });

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh,
      color: primary,
      displacement: 40,
      child: ListView.builder(
        controller: scrollController,
        physics: const AlwaysScrollableScrollPhysics(
          parent: BouncingScrollPhysics(),
        ),
        padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 100.h),
        itemCount: (patients.isEmpty ? 1 : patients.length) +
            (showLoadMoreFooter ? 1 : 0),
        itemBuilder: (context, index) {
          if (patients.isEmpty && index == 0) {
            if (isInitialLoading) {
              return HomePatientsLoadingList(isDark: isDark);
            }
            return SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.5,
              child: Center(
                child: Text(
                  showClearFilters
                      ? context.tr(AppStrings.noPatientsMatchThisFilter)
                      : context.tr(AppStrings.noPatientsYet),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: HomeDashboardColors.subtitle(isDark),
                  ),
                ),
              ),
            );
          }

          if (index < patients.length) {
            final patient = patients[index];
            return Padding(
              padding: EdgeInsets.only(bottom: 12.h),
              child: HomePatientCard(
                isDark: isDark,
                patient: patient,
                onTap: () => onOpenPatient(patient),
                onOutcomeTap: () => onOpenOutcome(patient),
                onAddCommentTap: () => onOpenComments(patient),
                onDoctorTap: () => onOpenDoctor(patient),
              ),
            );
          }

          return HomePatientsLoadMoreFooter(isDark: isDark);
        },
      ),
    );
  }
}

class _PatientsSearchField extends StatelessWidget {
  final bool isDark;

  const _PatientsSearchField({required this.isDark});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return GestureDetector(
          onTap: () {
            state.maybeWhen(
              orElse: () {},
              loaded: (
                homeData,
                currentDoctorModel,
                _,
                __,
                ___,
                ____,
                _____,
                ______,
                _______,
                ________,
              ) {
                navigatorKey.currentState?.pushNamed(
                  AppRoutes.search,
                  arguments: AppRoutesArgs.searchRouteArgs(
                    currentDoctorModel: currentDoctorModel,
                    verified: homeData.verified ?? false,
                    isSyndicateCardRequired:
                        homeData.isSyndicateCardRequired ?? 'Required',
                    currentDoctorRole: homeData.role.toString(),
                    currentDoctorPoints:
                        int.parse(homeData.scoreValue ?? '0'),
                    homeDataModel: homeData,
                    patientsOnly: true,
                  ),
                );
              },
            );
          },
          child: Container(
            height: 40.h,
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            decoration: BoxDecoration(
              color: isDark
                  ? HomeDashboardColors.surfaceBg(isDark)
                  : Colors.white,
              borderRadius: BorderRadius.circular(14.r),
              border: Border.all(color: HomeDashboardColors.border(isDark)),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.search_rounded,
                  size: 18.sp,
                  color: HomeDashboardColors.subtitle(isDark),
                ),
                SizedBox(width: 8.w),
                Text(
                  context.tr(AppStrings.searchPatients),
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: HomeDashboardColors.subtitle(isDark),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
