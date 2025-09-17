import 'package:egy_akin/features/all_groups_in_community/presentation/cubit/all_groups_in_community_cubit.dart';
import 'package:egy_akin/features/all_groups_in_community/presentation/cubit/all_groups_in_community_state.dart';
import '../../../../exports.dart';
import '../../../../app/services/theme_bloc.dart';

class AllGroupsTab extends StatefulWidget {
  final DoctorModel currentDoctorModel;
  final HomeModelResponse homeDataModel;
  const AllGroupsTab(
      {super.key,
      required this.currentDoctorModel,
      required this.homeDataModel});

  @override
  State<AllGroupsTab> createState() => _AllGroupsTabState();
}

class _AllGroupsTabState extends State<AllGroupsTab> {
  @override
  void initState() {
    if (context.read<AllGroupsInCommunityCubit>().callAllGroups == 0) {
      context.read<AllGroupsInCommunityCubit>().getAllGroups();
      context.read<AllGroupsInCommunityCubit>().callAllGroups++;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AllGroupsInCommunityCubit cubit = AllGroupsInCommunityCubit.get(context);
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        final isDarkMode = themeState is ThemeLoaded && themeState.isDarkMode;

        return RefreshIndicator(
          onRefresh: () {
            return cubit.getAllGroups();
          },
          child:
              BlocBuilder<AllGroupsInCommunityCubit, AllGroupsInCommunityState>(
            builder: (context, state) {
              return state.maybeWhen(
                orElse: () {
                  return SingleChildScrollView(
                    child: Container(
                      color:
                          isDarkMode ? AppColors.darkScaffoldBG : Colors.white,
                      child: const Padding(
                        padding: EdgeInsets.only(
                          left: 20,
                          right: 20,
                          bottom: 10,
                          top: 20,
                        ),
                        child: LoadingForGroupRow(
                          count: 20,
                        ),
                      ),
                    ),
                  );
                },
                loaded: (
                  response,
                  snackBarMessage,
                  dialogMessage,
                  isSeeMore,
                ) {
                  if (response.data!.data!.isEmpty) {
                    return SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: Center(
                        child: Column(
                          children: [
                            SizedBox(height: 150.h),
                            Image.asset(
                              AppImages.notFound,
                              width: 150.w,
                              height: 150.h,
                            ),
                            SizedBox(height: 150.h),
                          ],
                        ),
                      ),
                    );
                  }
                  return ListView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    controller: cubit.scrollControllerForAllGroups,
                    padding: const EdgeInsets.only(
                      top: 20,
                      left: 20,
                      right: 20,
                      bottom: 10,
                    ),
                    children: [
                      ...response.data!.data!.map(
                        (groupModel) => Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: GroupRow(
                            currentDoctorModel: widget.currentDoctorModel,
                            homeDataModel: widget.homeDataModel,
                            groupModel: groupModel,
                            groupPosition: GroupPosition.allGroups,
                          ),
                        ),
                      ),
                      if (isSeeMore)
                        Padding(
                          padding: EdgeInsets.only(bottom: 20.h),
                          child: const Center(
                            child: SizedBox(
                              height: 15,
                              width: 15,
                              child: CircularProgressIndicator(
                                strokeWidth: 3,
                              ),
                            ),
                          ),
                        ),
                    ],
                  );
                },
              );
            },
          ),
        );
      },
    );
  }
}
