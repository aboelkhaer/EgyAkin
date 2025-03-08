import 'package:egy_akin/features/all_groups_in_community/presentation/cubit/all_groups_in_community_cubit.dart';
import 'package:egy_akin/features/all_groups_in_community/presentation/cubit/cubit/my_groups_in_community_cubit.dart';
import 'package:egy_akin/features/all_groups_in_community/presentation/widgets/all_groups_tab.dart';
import 'package:egy_akin/features/all_groups_in_community/presentation/widgets/my_groups_tab.dart';

import '../../../../exports.dart';

class AllGroupsInCommunityScreen extends StatefulWidget {
  final DoctorModel currentDoctorModel;
  final HomeModelResponse homeDataModel;
  const AllGroupsInCommunityScreen(
      {super.key,
      required this.currentDoctorModel,
      required this.homeDataModel});

  @override
  State<AllGroupsInCommunityScreen> createState() =>
      _AllGroupsInCommunityScreenState();
}

class _AllGroupsInCommunityScreenState
    extends State<AllGroupsInCommunityScreen> {
  MyGroupsInCommunityCubit? _myGroupsCubit;
  AllGroupsInCommunityCubit? _allGroupsCubit;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _myGroupsCubit = context.read<MyGroupsInCommunityCubit>();
      _allGroupsCubit = context.read<AllGroupsInCommunityCubit>();
      if (!_myGroupsCubit!.isClosed) {
        _myGroupsCubit!.scrollControllerForMyGroups = ScrollController();
        _myGroupsCubit!.scrollControllerForMyGroups!
            .addListener(_onScrollForMyGroups);
      }
      if (!_allGroupsCubit!.isClosed) {
        _allGroupsCubit!.scrollControllerForAllGroups = ScrollController();
        _allGroupsCubit!.scrollControllerForAllGroups!
            .addListener(_onScrollForAllGroups);
      }
    });
  }

  @override
  void dispose() {
    if (_myGroupsCubit != null && !_myGroupsCubit!.isClosed) {
      _myGroupsCubit!.scrollControllerForMyGroups!.dispose();
    }
    if (_allGroupsCubit != null && !_allGroupsCubit!.isClosed) {
      _allGroupsCubit!.scrollControllerForAllGroups!.dispose();
    }
    super.dispose();
  }

  void _onScrollForMyGroups() {
    if (context.read<MyGroupsInCommunityCubit>().isLastPageForMyGroups) {
      return;
    } else {
      final maxScroll = context
          .read<MyGroupsInCommunityCubit>()
          .scrollControllerForMyGroups!
          .position
          .maxScrollExtent;
      final currentScroll = context
          .read<MyGroupsInCommunityCubit>()
          .scrollControllerForMyGroups!
          .position
          .pixels;
      const threshold = 200.0;
      if (context
                  .read<MyGroupsInCommunityCubit>()
                  .isLoadingMoreForScrollForMyGroups ==
              false &&
          maxScroll - currentScroll <= threshold) {
        context
            .read<MyGroupsInCommunityCubit>()
            .isLoadingMoreForScrollForMyGroups = true;

        context.read<MyGroupsInCommunityCubit>().loadMoreGroups();
      }
    }
  }

  void _onScrollForAllGroups() {
    if (context.read<AllGroupsInCommunityCubit>().isLastPageForAllGroups) {
      return;
    } else {
      final maxScroll = context
          .read<AllGroupsInCommunityCubit>()
          .scrollControllerForAllGroups!
          .position
          .maxScrollExtent;
      final currentScroll = context
          .read<AllGroupsInCommunityCubit>()
          .scrollControllerForAllGroups!
          .position
          .pixels;
      const threshold = 200.0;
      if (context
                  .read<AllGroupsInCommunityCubit>()
                  .isLoadingMoreForScrollForAllGroups ==
              false &&
          maxScroll - currentScroll <= threshold) {
        context
            .read<AllGroupsInCommunityCubit>()
            .isLoadingMoreForScrollForAllGroups = true;

        context.read<AllGroupsInCommunityCubit>().loadMoreGroups();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // AllGroupsInCommunityCubit cubit = AllGroupsInCommunityCubit.get(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('All Groups'),
        actions: [
          IconButton(
            onPressed: () {
              navigatorKey.currentState?.pushNamed(
                AppRoutes.createGroupInCommunity,
                arguments: AppRoutesArgs.createGroupInCommunityRouteArgs(
                  currentDoctorModel: widget.currentDoctorModel,
                  homeDataModel: widget.homeDataModel,
                  isCreateNewGroup: true,
                  groupModel: null,
                ),
              );
            },
            icon: const Icon(
              Icons.add,
              size: 33,
            ),
          ),
        ],
      ),
      body: DefaultTabController(
        length: 2, // Set tab count dynamically
        child: Column(
          children: [
            ColoredBox(
              color: AppColors.primary,
              child: TabBar(
                indicatorColor: Colors.white,
                labelColor: Colors.white,
                isScrollable: false,
                labelStyle: const TextStyle(fontWeight: FontWeight.bold),
                unselectedLabelColor: Colors.white.withOpacity(0.7),
                tabs: const [
                  Tab(text: 'My Groups'),
                  Tab(text: 'All Groups'),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  MyGroupsTab(
                    currentDoctorModel: widget.currentDoctorModel,
                    homeDataModel: widget.homeDataModel,
                  ),
                  AllGroupsTab(
                    currentDoctorModel: widget.currentDoctorModel,
                    homeDataModel: widget.homeDataModel,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
