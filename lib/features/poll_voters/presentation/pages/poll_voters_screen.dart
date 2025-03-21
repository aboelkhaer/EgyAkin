import 'package:egy_akin/features/poll_voters/presentation/cubit/poll_voters_cubit.dart';
import 'package:egy_akin/features/poll_voters/presentation/cubit/poll_voters_state.dart';

import '../../../../exports.dart';

class PollVotersScreen extends StatefulWidget {
  final String pollId;
  final String optionId;
  final DoctorModel currentDoctorModel;
  final HomeModelResponse homeDataModel;
  const PollVotersScreen(
      {super.key,
      required this.pollId,
      required this.optionId,
      required this.currentDoctorModel,
      required this.homeDataModel});

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
        // _cubit!.scrollController!.addListener(_onScroll);
      }
    });
  }

  @override
  void dispose() {
    if (_cubit != null && !_cubit!.isClosed) {
      _cubit!.scrollController!.dispose();
    }
    super.dispose();
  }

  // void _onScroll() {
  //   if (context.read<PollVotersCubit>().isLastPage) {
  //     return;
  //   } else {
  //     final maxScroll = context
  //         .read<PollVotersCubit>()
  //         .scrollController!
  //         .position
  //         .maxScrollExtent;
  //     final currentScroll =
  //         context.read<PollVotersCubit>().scrollController!.position.pixels;
  //     const threshold = 200.0;
  //     if (context.read<PollVotersCubit>().isLoadingMoreForScroll == false &&
  //         maxScroll - currentScroll <= threshold) {
  //       context.read<PollVotersCubit>().isLoadingMoreForScroll = true;

  //         // context.read<PollVotersCubit>().loadMoreMembers(widget.groupId);

  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SizedBox(height: 5.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 5.h,
                width: 60.w,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(40),
                ),
              ),
            ],
          ),
          Padding(
            padding:
                const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 10),
            child: Row(
              children: [
                Text(
                  'Voters:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14.sp,
                    color: Colors.grey.shade800,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: BlocConsumer<PollVotersCubit, PollVotersState>(
              listener: (context, state) {},
              builder: (context, state) {
                return state.maybeWhen(
                  orElse: () {
                    return const Center(child: CircularProgressIndicator());
                  },
                  loaded: (
                    response,
                    snackBarMessage,
                    dialogMessage,
                    isSeeMore,
                    changeCounter,
                  ) {
                    return response.data!.isEmpty
                        ? Center(
                            child: Image.asset(
                              AppImages.notFound,
                              width: 100.h,
                              height: 150.h,
                            ),
                          )
                        : ListView.builder(
                            itemCount: response.data!.length,
                            controller: _cubit!.scrollController,
                            itemBuilder: (context, index) {
                              DoctorModel doctorModel = response.data![index];
                              return Padding(
                                padding: const EdgeInsets.only(
                                    left: 20, right: 20, bottom: 8),
                                child: Card(
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(10),
                                    splashColor: AppColors.subBG,
                                    onTap: () {
                                      navigatorKey.currentState?.pushNamed(
                                        AppRoutes.doctorInfoView,
                                        arguments: AppRoutesArgs
                                            .doctorInfoViewRouteArgs(
                                          doctorId: doctorModel.id.toString(),
                                          currentDoctorModel:
                                              widget.currentDoctorModel,
                                          isSyndicateCardRequired: widget
                                              .homeDataModel
                                              .isSyndicateCardRequired
                                              .toString(),
                                          initialIndex: 0,
                                          accountVerification:
                                              widget.homeDataModel.verified!,
                                          currentDoctorRole: widget
                                              .homeDataModel.role
                                              .toString(),
                                          currentDoctorPoints: int.parse(
                                              widget.homeDataModel.scoreValue!),
                                          homeDataModel: widget.homeDataModel,
                                          isNavigateToTheButtonOfInformationTab:
                                              false,
                                        ),
                                      );
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                        left: 20,
                                        right: 20,
                                        top: 10,
                                        bottom: 10,
                                      ),
                                      child: Row(
                                        children: [
                                          Column(
                                            children: [
                                              Row(
                                                children: [
                                                  Container(
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: Colors.grey
                                                              .withOpacity(0.4),
                                                          spreadRadius: 2,
                                                          blurRadius: 9,
                                                          offset: const Offset(
                                                              0, 3),
                                                        ),
                                                      ],
                                                    ),
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              80.r),
                                                      child: GestureDetector(
                                                        onTap: () {
                                                          navigatorKey
                                                              .currentState
                                                              ?.pushNamed(
                                                            AppRoutes
                                                                .doctorInfoView,
                                                            arguments: AppRoutesArgs
                                                                .doctorInfoViewRouteArgs(
                                                              doctorId:
                                                                  doctorModel.id
                                                                      .toString(),
                                                              initialIndex: 0,
                                                              currentDoctorModel:
                                                                  widget
                                                                      .currentDoctorModel,
                                                              isSyndicateCardRequired: widget
                                                                  .homeDataModel
                                                                  .isSyndicateCardRequired!,
                                                              homeDataModel: widget
                                                                  .homeDataModel,
                                                              accountVerification:
                                                                  widget.homeDataModel
                                                                          .verified ??
                                                                      true,
                                                              currentDoctorRole:
                                                                  widget
                                                                      .homeDataModel
                                                                      .role!,
                                                              isNavigateToTheButtonOfInformationTab:
                                                                  false,
                                                              currentDoctorPoints:
                                                                  int.parse(widget
                                                                      .homeDataModel
                                                                      .scoreValue!),
                                                            ),
                                                          );
                                                        },
                                                        child: CircleAvatar(
                                                          radius: 20.r,
                                                          backgroundColor:
                                                              AppColors
                                                                  .primary
                                                                  .withOpacity(
                                                                      0.8),
                                                          child: doctorModel
                                                                      .image ==
                                                                  null
                                                              ? Text(
                                                                  doctorModel
                                                                      .firstName![
                                                                          0]
                                                                      .toUpperCase(),
                                                                  style: TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontSize:
                                                                          16.sp),
                                                                )
                                                              : CustomCachedNetworkImage(
                                                                  imageUrl:
                                                                      doctorModel
                                                                          .image
                                                                          .toString(),
                                                                  height: 100.h,
                                                                  width: 100.w,
                                                                ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(width: 8.w),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Text(
                                                            doctorName(
                                                              firstName:
                                                                  doctorModel
                                                                      .firstName,
                                                              lastName:
                                                                  doctorModel
                                                                      .lastName,
                                                              role: '',
                                                            ),
                                                            style: TextStyle(
                                                              fontSize: 12.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                          doctorModel.isSyndicateCardRequired
                                                                      .toString() ==
                                                                  'Verified'
                                                              ? const VerificationIcon()
                                                              : const SizedBox
                                                                  .shrink()
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ],
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
          // SizedBox(height: 10.h),
          // BlocBuilder<GroupMembersCubit, GroupMembersState>(
          //   builder: (context, state) {
          //     return state.maybeWhen(
          //       orElse: () {
          //         return const SizedBox.shrink();
          //       },
          //       loaded: (
          //         snackBarMessage,
          //         dialogMessage,
          //         response,
          //         isSeeMore,
          //         isRemoveMemberFromGroupLoading,
          //         isRemoveMemberFromGroupLoaded,
          //       ) {
          //         return Row(
          //           mainAxisAlignment: MainAxisAlignment.center,
          //           children: [
          //             isSeeMore
          //                 ? Column(
          //                     children: [
          //                       const SizedBox(
          //                         height: 15,
          //                         width: 15,
          //                         child: CircularProgressIndicator(
          //                           strokeWidth: 3,
          //                         ),
          //                       ),
          //                       SizedBox(height: 20.h),
          //                     ],
          //                   )
          //                 : GestureDetector(
          //                     onTap: () {
          //                       cubit.loadMoreMembers(widget.groupId);
          //                     },
          //                     child: const Text(
          //                       '',
          //                     ),
          //                   ),
          //           ],
          //         );
          //       },
          //     );
          //   },
          // ),
        ],
      ),
    );
  }
}
