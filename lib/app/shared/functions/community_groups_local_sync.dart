import 'package:egy_akin/app/utilities/enums.dart';
import 'package:egy_akin/features/all_groups_in_community/presentation/cubit/all_groups_in_community_cubit.dart';
import 'package:egy_akin/features/all_groups_in_community/presentation/cubit/my_groups_cubit/my_groups_in_community_cubit.dart';
import 'package:egy_akin/features/community/data/models/get_groups_tab_model_response.dart';
import 'package:egy_akin/features/community/presentation/cubit/groups_cubit/groups_cubit.dart';
import 'package:egy_akin/injection_container.dart';

/// Pushes membership / group-card changes into already-loaded community lists
/// (Groups tab, My Groups, All Groups) without refetching.
class CommunityGroupsLocalSync {
  static bool isMember(GroupModel group) {
    final status = group.userStatus;
    return status == GroupInviteStatus.accepted.name ||
        status == GroupInviteStatus.joined.name;
  }

  static GroupModel asJoined(GroupModel group) {
    final isPrivate = group.privacy == GroupPrivacy.private.name ||
        group.privacy == GroupStatus.private.name;
    return group.copyWith(
      userStatus: isPrivate
          ? GroupInviteStatus.pending.name
          : GroupInviteStatus.joined.name,
      memberCount: isPrivate
          ? group.memberCount
          : (group.memberCount ?? 0) + 1,
    );
  }

  static GroupModel asLeft(GroupModel group) {
    return group.copyWith(
      userStatus: null,
      memberCount: ((group.memberCount ?? 1) - 1).clamp(0, 1 << 30),
    );
  }

  static void syncGroup(GroupModel group) {
    final id = group.id?.toString();
    if (id == null) return;

    final groups = _groups();
    if (groups != null) groups.applyGroupUpdate(group);

    final all = _all();
    if (all != null) all.applyGroupUpdate(group);

    final my = _my();
    if (my == null) return;
    if (isMember(group)) {
      my.upsertGroup(group);
    } else {
      my.removeGroupFromList(id);
    }
  }

  static void removeGroup(String groupId) {
    _groups()?.removeGroupFromList(groupId);
    _all()?.removeGroupFromList(groupId);
    _my()?.removeGroupFromList(groupId);
  }

  static GroupsCubit? _groups() {
    if (!sl.isRegistered<GroupsCubit>()) return null;
    final cubit = sl<GroupsCubit>();
    return cubit.isClosed ? null : cubit;
  }

  static MyGroupsInCommunityCubit? _my() {
    if (!sl.isRegistered<MyGroupsInCommunityCubit>()) return null;
    final cubit = resolveMyGroupsInCommunityCubit();
    return cubit.isClosed ? null : cubit;
  }

  static AllGroupsInCommunityCubit? _all() {
    if (!sl.isRegistered<AllGroupsInCommunityCubit>()) return null;
    final cubit = resolveAllGroupsInCommunityCubit();
    return cubit.isClosed ? null : cubit;
  }
}
