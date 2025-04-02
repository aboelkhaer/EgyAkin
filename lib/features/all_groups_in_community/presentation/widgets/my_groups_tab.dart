import 'package:egy_akin/features/all_groups_in_community/presentation/cubit/my_groups_cubit/my_groups_in_community_cubit.dart';
import 'package:egy_akin/features/all_groups_in_community/presentation/cubit/my_groups_cubit/my_groups_in_community_state.dart';
import '../../../../exports.dart';

class MyGroupsTab extends StatefulWidget {
  final DoctorModel currentDoctorModel;
  final HomeModelResponse homeDataModel;
  const MyGroupsTab({
    super.key,
    required this.currentDoctorModel,
    required this.homeDataModel,
  });

  @override
  State<MyGroupsTab> createState() => _MyGroupsTabState();
}

class _MyGroupsTabState extends State<MyGroupsTab> {
  @override
  void initState() {
    if (context.read<MyGroupsInCommunityCubit>().callMyGroups == 0) {
      context.read<MyGroupsInCommunityCubit>().getMyGroups();
      context.read<MyGroupsInCommunityCubit>().callMyGroups++;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    MyGroupsInCommunityCubit cubit = MyGroupsInCommunityCubit.get(context);
    return RefreshIndicator(
      onRefresh: () {
        return cubit.getMyGroups();
      },
      child: BlocBuilder<MyGroupsInCommunityCubit, MyGroupsInCommunityState>(
        builder: (context, state) {
          return state.maybeWhen(
            orElse: () {
              return const SingleChildScrollView(
                child: Padding(
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
              );
            },
            loaded: (
              response,
              snackBarMessage,
              dialogMessage,
              isSeeMore,
            ) {
              if (response.data!.data!.isEmpty) {
                return Center(
                  child: Image.asset(
                    AppImages.notFound,
                    width: 200,
                    height: 200,
                  ),
                );
              }
              return ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                controller: cubit.scrollControllerForMyGroups,
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
                        groupPosition: GroupPosition.myGroups,
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
  }
}
