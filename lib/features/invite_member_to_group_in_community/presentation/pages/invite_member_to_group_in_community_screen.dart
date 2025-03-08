import 'package:egy_akin/features/invite_member_to_group_in_community/presentation/cubit/invite_member_to_group_in_community_cubit.dart';

import '../../../../exports.dart';

class InviteMemberToGroupInCommunityScreen extends StatelessWidget {
  final DoctorModel currentDoctorModel;
  final HomeModelResponse homeDataModel;
  const InviteMemberToGroupInCommunityScreen(
      {super.key,
      required this.currentDoctorModel,
      required this.homeDataModel});

  @override
  Widget build(BuildContext context) {
    final InviteMemberToGroupInCommunityCubit cubit =
        InviteMemberToGroupInCommunityCubit.get(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Invite Member'),
      ),
    );
  }
}
