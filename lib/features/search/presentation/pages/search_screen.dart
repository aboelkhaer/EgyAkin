import '../../../../exports.dart';
import '../../../../app/services/theme_bloc.dart';
import '../../../../app/shared/functions/permissions_helper.dart';
import '../../../../app/shared/permissions/app_permissions.dart';

class SearchScreen extends StatefulWidget {
  final DoctorModel currentDoctorModel;
  final bool accountVerification;
  final String isSyndicateCardRequired;
  final int currentDoctorPoints;
  final String currentDoctorRole;
  final HomeModelResponse homeDataModel;

  const SearchScreen({
    super.key,
    required this.currentDoctorModel,
    required this.accountVerification,
    required this.isSyndicateCardRequired,
    required this.currentDoctorRole,
    required this.currentDoctorPoints,
    required this.homeDataModel,
  });

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  SearchCubit? cubit;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    cubit = context.read<SearchCubit>();
    if (!cubit!.isClosed) {
      cubit!.searchScrollController = ScrollController();
    }
  }

  @override
  void dispose() {
    if (cubit != null && !cubit!.isClosed) {
      cubit!.searchScrollController!.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SearchCubit cubit = SearchCubit.get(context);
    Size size = MediaQuery.of(context).size;
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        final isDarkMode = themeState is ThemeLoaded && themeState.isDarkMode;

        return Scaffold(
          backgroundColor: isDarkMode ? AppColors.darkScaffoldBG : Colors.white,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: AppColors.transparent,
            iconTheme: IconThemeData(
                color: isDarkMode ? AppColors.darkTitle : Colors.black),
            systemOverlayStyle: isDarkMode
                ? SystemUiOverlayStyle.light
                : SystemUiOverlayStyle.dark,
          ),
          floatingActionButton: SizedBox(
            height: 50.w,
            width: 50.w,
            child: FloatingActionButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50.0),
              ),
              onPressed: () async {
                // Check if searching for doses and search text is not empty
                if (cubit.dose &&
                    cubit.searchController.text.trim().isNotEmpty) {
                  final hasPermission = await PermissionHelper.hasPermission(
                    AppPermissions.searchDoses,
                  );

                  if (!mounted) return;

                  if (!hasPermission) {
                    // User doesn't have permission - show permission denied dialog
                    showCustomDialog(
                      context: context,
                      title: context.tr(AppStrings.attention),
                      description: context
                          .tr(AppStrings.youDontHavePermissionToSearchDoses),
                      coloredButtonText: context.tr(AppStrings.ok),
                      coloredButtonOnTap: () => Navigator.of(context).pop(),
                      isNoColorShow: false,
                    );
                    return;
                  }
                }

                // Proceed with search
                cubit.getSearchHome(
                    isVerifiedUser(widget.isSyndicateCardRequired));
              },
              child: Icon(
                Icons.search,
                color: Colors.white,
                size: 25.r,
              ),
            ),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: 55,
                      child: TextFormField(
                        controller: cubit.searchController,
                        cursorColor: AppColors.primary,
                        onTapOutside: (event) =>
                            FocusManager.instance.primaryFocus?.unfocus(),
                        onFieldSubmitted: (value) async {
                          // Check if searching for doses and search text is not empty
                          if (cubit.dose &&
                              cubit.searchController.text.trim().isNotEmpty) {
                            final hasPermission =
                                await PermissionHelper.hasPermission(
                              AppPermissions.searchDoses,
                            );

                            if (!mounted) return;

                            if (!hasPermission) {
                              // User doesn't have permission - show permission denied dialog
                              showCustomDialog(
                                context: context,
                                title: context.tr(AppStrings.attention),
                                description: context.tr(AppStrings
                                    .youDontHavePermissionToSearchDoses),
                                coloredButtonText: context.tr(AppStrings.ok),
                                coloredButtonOnTap: () =>
                                    Navigator.of(context).pop(),
                                isNoColorShow: false,
                              );
                              return;
                            }
                          }

                          // Proceed with search
                          cubit.getSearchHome(
                              isVerifiedUser(widget.isSyndicateCardRequired));
                        },
                        decoration: InputDecoration(
                          hintText:
                              '${isVerifiedUser(widget.isSyndicateCardRequired) ? context.tr(AppStrings.search) : context.tr(AppStrings.searchForDoses)}...',
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () => cubit.searchController.clear(),
                          ),
                          prefixIcon: const Icon(
                            Icons.search,
                          ),
                          prefixIconColor: WidgetStateColor.resolveWith(
                              (states) => states.contains(WidgetState.focused)
                                  ? AppColors.primary
                                  : Colors.grey),
                          suffixIconColor: WidgetStateColor.resolveWith(
                              (states) => states.contains(WidgetState.focused)
                                  ? AppColors.primary
                                  : Colors.grey),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide:
                                const BorderSide(color: AppColors.primary),
                          ),
                        ),
                        autofocus: true,
                      ),
                    ),
                  ],
                ),
              ),
              (!PermissionHelper.canPermission(
                          AppPermissions.viewPatientOptionInHomeSearch) ||
                      !isVerifiedUser(widget.isSyndicateCardRequired))
                  ? const SizedBox.shrink()
                  : Column(
                      children: [
                        Container(
                          alignment: Alignment.center,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Row(
                                children: [
                                  Checkbox(
                                    value: cubit.patientOrDoctorOrHospital,
                                    onChanged: (value) {
                                      setState(() {
                                        cubit.patientOrDoctorOrHospital =
                                            value ?? false;
                                      });
                                    },
                                    activeColor: AppColors.primary,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    context.tr(AppStrings.patient),
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Container(
                                    margin:
                                        context.currentLocale?.languageCode ==
                                                'ar'
                                            ? const EdgeInsets.only(right: 10)
                                            : const EdgeInsets.only(left: 10),
                                    child:
                                        BlocBuilder<SearchCubit, SearchState>(
                                      builder: (context, state) {
                                        return state.maybeWhen(
                                          orElse: () {
                                            return const Text(
                                              '0',
                                              style: TextStyle(
                                                color: AppColors.description,
                                              ),
                                            );
                                          },
                                          loaded: (patients, doses) {
                                            return Text(
                                              patients!.length.toString(),
                                              style: TextStyle(
                                                color: patients.isEmpty
                                                    ? AppColors.description
                                                    : Colors.green,
                                              ),
                                            );
                                          },
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(width: 16),
                              Row(
                                children: [
                                  Checkbox(
                                    value: cubit.dose,
                                    onChanged: (value) {
                                      setState(() {
                                        cubit.dose = value ?? false;
                                      });
                                    },
                                    activeColor: AppColors.primary,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    context.tr(AppStrings.dose),
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Container(
                                    margin:
                                        context.currentLocale?.languageCode ==
                                                'ar'
                                            ? const EdgeInsets.only(right: 10)
                                            : const EdgeInsets.only(left: 10),
                                    child:
                                        BlocBuilder<SearchCubit, SearchState>(
                                      builder: (context, state) {
                                        return state.maybeWhen(
                                          orElse: () {
                                            return const Text(
                                              '0',
                                              style: TextStyle(
                                                color: AppColors.description,
                                              ),
                                            );
                                          },
                                          loaded: (patients, doses) {
                                            return Text(
                                              doses!.length.toString(),
                                              style: TextStyle(
                                                color: doses.isEmpty
                                                    ? AppColors.description
                                                    : Colors.green,
                                              ),
                                            );
                                          },
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const Row(
                          children: [
                            Expanded(child: Divider()),
                          ],
                        ),
                        SizedBox(height: size.height * 0.01),
                      ],
                    ),
              Expanded(
                child: BlocBuilder<SearchCubit, SearchState>(
                  builder: (context, state) {
                    return state.maybeWhen(
                      orElse: () {
                        return Container(
                          alignment: Alignment.center,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                AppImages.notFound,
                                height: 150,
                                width: 150,
                              ),
                              SizedBox(
                                height: size.height * 0.2,
                              )
                            ],
                          ),
                        );
                      },
                      loading: () {
                        return const ShimmerLoadingPatientsCards(
                            ishorizontal: false);
                      },
                      loaded: (patients, doses) {
                        return patients!.isEmpty && doses!.isEmpty
                            ? Container(
                                alignment: Alignment.center,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      AppImages.notFound,
                                      height: 150,
                                      width: 150,
                                    ),
                                    SizedBox(
                                      height: size.height * 0.2,
                                    )
                                  ],
                                ),
                              )
                            : SingleChildScrollView(
                                physics: const BouncingScrollPhysics(),
                                child: Column(
                                  children: [
                                    ListView.builder(
                                      controller: cubit.searchScrollController,
                                      itemCount: patients.length,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      scrollDirection: Axis.vertical,
                                      padding: EdgeInsets.only(
                                        left: 30,
                                        top: 8,
                                        right: size.width * 0.09,
                                        bottom: 40,
                                      ),
                                      itemBuilder: (context, index) {
                                        PatientHomeDataModel patient =
                                            patients[index];

                                        return Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 8),
                                          child: PatientCard(
                                            patientName: patient.name ??
                                                AppStrings.empty,
                                            updatedAt: patient.updatedAt ??
                                                AppStrings.empty,
                                            doctorId:
                                                patient.doctor!.id.toString(),
                                            homeDataModel: widget.homeDataModel,
                                            isAllDataOpen: false,
                                            width: 300.w,
                                            drFirstName:
                                                patient.doctor!.firstName ??
                                                    AppStrings.empty,
                                            accountVerification:
                                                widget.accountVerification,
                                            currentDoctorPoints:
                                                widget.currentDoctorPoints,
                                            drLastName:
                                                patient.doctor!.lastName ??
                                                    AppStrings.empty,
                                            isSyndicateCardRequired: patient
                                                .doctor!
                                                .isSyndicateCardRequired!,
                                            currentDoctorRole:
                                                widget.currentDoctorRole,
                                            currentDoctorModel:
                                                widget.currentDoctorModel,
                                            hospital: patient.hospital ??
                                                AppStrings.empty,
                                            doctorImage: patient.doctor!.image,
                                            submitStatus:
                                                patient.sections == null
                                                    ? false
                                                    : patient.sections!
                                                            .submitStatus ??
                                                        false,
                                            isOutcomeStatus: patient
                                                .sections!.outcomeStatus!,
                                            onOutcomeTap: () {
                                              navigatorKey.currentState
                                                  ?.pushNamed(
                                                AppRoutes.outcome,
                                                arguments: AppRoutesArgs
                                                    .outcomeRouteArgs(
                                                  verified: widget
                                                      .accountVerification,
                                                  outcomeStatus: patient
                                                      .sections!.outcomeStatus!,
                                                  patientName:
                                                      patient.name.toString(),
                                                  patientId:
                                                      patient.id.toString(),
                                                  currentDoctorModel:
                                                      widget.currentDoctorModel,
                                                  doctorId: patient.doctor!.id
                                                      .toString(),
                                                  isSyndicateCardRequired: widget
                                                      .isSyndicateCardRequired,
                                                  currentDoctorRole:
                                                      widget.currentDoctorRole,
                                                  currentDoctorPoints: widget
                                                      .currentDoctorPoints,
                                                  homeDataModel:
                                                      widget.homeDataModel,
                                                ),
                                              );
                                            },
                                            onAddCommentTap: () {
                                              navigatorKey.currentState
                                                  ?.pushNamed(
                                                AppRoutes.comments,
                                                arguments: AppRoutesArgs
                                                    .patientCommentsRouteArgs(
                                                  patientId:
                                                      patient.id.toString(),
                                                  currentDoctorModel:
                                                      widget.currentDoctorModel,
                                                  currentDoctorRole:
                                                      widget.currentDoctorRole,
                                                  homeDataModel:
                                                      widget.homeDataModel,
                                                  verified: widget
                                                      .accountVerification,
                                                  patientName:
                                                      patient.name.toString(),
                                                  currentDoctorPoints: widget
                                                      .currentDoctorPoints,
                                                  isSyndicateCardRequired: widget
                                                      .isSyndicateCardRequired,
                                                ),
                                              );
                                            },
                                            onTap: () {
                                              navigatorKey.currentState
                                                  ?.pushNamed(
                                                AppRoutes.patientSections,
                                                arguments: AppRoutesArgs
                                                    .patientSectionsRouteArguments(
                                                  patientId:
                                                      patient.id.toString(),
                                                  currentDoctorModel:
                                                      widget.currentDoctorModel,
                                                  currentDoctorPoints: widget
                                                      .currentDoctorPoints,
                                                  currentDoctorRole: widget
                                                      .homeDataModel.role
                                                      .toString(),
                                                  homeDataModel:
                                                      widget.homeDataModel,
                                                  isAllDataOpen: false,
                                                ),
                                              );
                                            },
                                          ),
                                        );
                                      },
                                    ),
                                    patients.isNotEmpty && doses!.isNotEmpty
                                        ? Container(
                                            margin: const EdgeInsets.only(
                                                bottom: 20),
                                            child: Row(
                                              children: [
                                                const Expanded(
                                                    child: Divider()),
                                                Container(
                                                  margin: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 10),
                                                  child: const Text(
                                                    'Doses',
                                                    style: TextStyle(
                                                        color: Colors.green,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                                const Expanded(
                                                    child: Divider()),
                                              ],
                                            ),
                                          )
                                        : const SizedBox.shrink(),
                                    ListView.builder(
                                      controller: cubit.searchScrollController,
                                      itemCount: doses!.length,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      scrollDirection: Axis.vertical,
                                      padding: EdgeInsets.only(
                                        left: 30,
                                        right: size.width * 0.09,
                                        bottom: 50,
                                      ),
                                      itemBuilder: (context, index) {
                                        SearchDataForDosesModelResponse dose =
                                            doses[index];
                                        return Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 8),
                                          child: Card(
                                            color: Colors.white,
                                            elevation: 0.8,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 16.w,
                                                  vertical: 12.h),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: AppColors.primary
                                                    .withOpacity(0.8),
                                              ),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Flexible(
                                                        child: Text(
                                                          dose.title.toString(),
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 14.sp,
                                                            color:
                                                                AppColors.white,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(height: 5.h),
                                                  const Divider(
                                                    color: AppColors.white,
                                                  ),
                                                  SizedBox(height: 5.h),
                                                  dose.description == null
                                                      ? const SizedBox.shrink()
                                                      : Column(
                                                          children: [
                                                            Row(
                                                              children: [
                                                                Flexible(
                                                                  child:
                                                                      HtmlWidget(
                                                                    dose.description
                                                                        .toString(),
                                                                    textStyle:
                                                                        TextStyle(
                                                                      color: AppColors
                                                                          .white,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                      fontSize:
                                                                          12.sp,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            SizedBox(
                                                                height: 10.h),
                                                          ],
                                                        ),
                                                  Row(
                                                    children: [
                                                      Flexible(
                                                        child: HtmlWidget(
                                                          dose.dose.toString(),
                                                          textStyle: TextStyle(
                                                            color:
                                                                AppColors.white,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontSize: 12.sp,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              );
                      },
                    );
                  },
                ),
              ),
              SizedBox(height: 10.h),
            ],
          ),
        );
      },
    );
  }
}
