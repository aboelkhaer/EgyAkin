import 'package:egy_akin/features/invite_member_to_group_in_community/presentation/cubit/invite_member_to_group_in_community_state.dart';

import '../../../../exports.dart';

class InviteMemberToGroupInCommunityCubit
    extends Cubit<InviteMemberToGroupInCommunityState> {
  InviteMemberToGroupInCommunityCubit()
      : super(const InviteMemberToGroupInCommunityState.initial());
  static InviteMemberToGroupInCommunityCubit get(context) =>
      BlocProvider.of(context);
}
