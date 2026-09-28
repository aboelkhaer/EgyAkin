import 'package:egy_akin/features/home/presentation/widgets/dashboard/home_dashboard_shared.dart';
import 'package:egy_akin/features/poll_voters/presentation/cubit/poll_voters_cubit.dart';
import 'package:egy_akin/features/poll_voters/presentation/cubit/poll_voters_state.dart';

import '../../../../exports.dart';

class PollVotersScreen extends StatefulWidget {
  final String pollId;
  final String optionId;
  final DoctorModel currentDoctorModel;
  final HomeModelResponse homeDataModel;
  const PollVotersScreen({
    super.key,
    required this.pollId,
    required this.optionId,
    required this.currentDoctorModel,
    required this.homeDataModel,
  });

  @override
  State<PollVotersScreen> createState() => _PollVotersScreenState();
}

class _PollVotersScreenState extends State<PollVotersScreen> {
  PollVotersCubit? _cubit;

  @override
  void initState() {
    super.initState();
    context
        .read<PollVotersCubit>()
        .getPollVoters(widget.pollId, widget.optionId);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _cubit = context.read<PollVotersCubit>();
      if (!_cubit!.isClosed) {
        _cubit!.scrollController = ScrollController();
      }
    });
  }

  @override
  void dispose() {
    if (_cubit != null && !_cubit!.isClosed) {
      _cubit!.scrollController?.dispose();
    }
    super.dispose();
  }

  void _openDoctor(DoctorModel doctorModel) {
    navigatorKey.currentState?.pushNamed(
      AppRoutes.doctorInfoView,
      arguments: AppRoutesArgs.doctorInfoViewRouteArgs(
        doctorId: doctorModel.id.toString(),
        currentDoctorModel: widget.currentDoctorModel,
        isSyndicateCardRequired:
            widget.homeDataModel.isSyndicateCardRequired.toString(),
        initialIndex: 0,
        accountVerification: widget.homeDataModel.verified ?? true,
        currentDoctorRole: widget.homeDataModel.role.toString(),
        currentDoctorPoints:
            int.parse(widget.homeDataModel.scoreValue ?? '0'),
        homeDataModel: widget.homeDataModel,
        isNavigateToTheButtonOfInformationTab: false,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        final isDark = themeState is ThemeLoaded && themeState.isDarkMode;
        final primary = HomeDashboardColors.primary(isDark);
        final titleColor = HomeDashboardColors.title(isDark);
        final subtitleColor = HomeDashboardColors.subtitle(isDark);
        final scaffold = HomeDashboardColors.scaffold(isDark);
        final cardBg = HomeDashboardColors.cardBg(isDark);
        final border = HomeDashboardColors.border(isDark);

        return Scaffold(
          backgroundColor: scaffold,
          body: Column(
            children: [
              SizedBox(height: 8.h),
              Center(
                child: Container(
                  height: 4.h,
                  width: 40.w,
                  decoration: BoxDecoration(
                    color: isDark
                        ? Colors.white.withOpacity(0.22)
                        : Colors.black.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(99),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(20.w, 18.h, 20.w, 10.h),
                child: Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Text(
                    '${context.tr(AppStrings.voters)} :',
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 15.sp,
                      color: titleColor,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: BlocBuilder<PollVotersCubit, PollVotersState>(
                  builder: (context, state) {
                    return state.maybeWhen(
                      orElse: () => Center(
                        child: CircularProgressIndicator(color: primary),
                      ),
                      loaded: (
                        response,
                        snackBarMessage,
                        dialogMessage,
                        isSeeMore,
                        changeCounter,
                      ) {
                        final voters = response.data ?? const <DoctorModel>[];
                        if (voters.isEmpty) {
                          return DashboardEmptyState(
                            isDark: isDark,
                            icon: Icons.how_to_vote_outlined,
                            title: context.tr(AppStrings.noVotesYet),
                            subtitle: context.tr(
                              AppStrings.nobodyHasVotedForThisOption,
                            ),
                            hint: context.tr(
                              AppStrings.checkBackAfterMoreColleaguesVote,
                            ),
                            hintIcon: Icons.groups_outlined,
                          );
                        }

                        return ListView.builder(
                          itemCount: voters.length,
                          controller: _cubit?.scrollController,
                          padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 20.h),
                          itemBuilder: (context, index) {
                            final doctorModel = voters[index];
                            return Padding(
                              padding: EdgeInsets.only(bottom: 8.h),
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(14.r),
                                  onTap: () => _openDoctor(doctorModel),
                                  child: Ink(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 12.w,
                                      vertical: 10.h,
                                    ),
                                    decoration: BoxDecoration(
                                      color: cardBg,
                                      borderRadius: BorderRadius.circular(14.r),
                                      border: Border.all(
                                        color: border.withOpacity(
                                          isDark ? 0.9 : 0.85,
                                        ),
                                      ),
                                    ),
                                    child: Row(
                                      children: [
                                        DoctorCircleAvatar(
                                          doctor: doctorModel,
                                          primary: primary,
                                          size: 40.r,
                                        ),
                                        SizedBox(width: 10.w),
                                        Expanded(
                                          child: Row(
                                            children: [
                                              Flexible(
                                                child: Text(
                                                  doctorDisplayName(
                                                    doctorModel,
                                                  ),
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                    fontSize: 13.sp,
                                                    fontWeight: FontWeight.w700,
                                                    color: titleColor,
                                                  ),
                                                ),
                                              ),
                                              if (doctorIsVerified(doctorModel))
                                                const Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .only(start: 4),
                                                  child: VerificationIcon(
                                                    isSmaller: true,
                                                  ),
                                                ),
                                            ],
                                          ),
                                        ),
                                        Icon(
                                          Icons.chevron_right_rounded,
                                          size: 18.sp,
                                          color: subtitleColor,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
