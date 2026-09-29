import 'package:egy_akin/app/shared/functions/permissions_helper.dart';
import 'package:egy_akin/app/shared/permissions/app_permissions.dart';
import 'package:egy_akin/injection_container.dart';

import '../../../exports.dart';

/// Admin for community posts: role Admin and/or admin feed permission.
bool isCommunityFeedAdmin(HomeModelResponse homeData) {
  if (homeData.role == AppStrings.roleAdmin) return true;
  return PermissionHelper.canPermission(
    AppPermissions.viewEditAndDeletePostForAdmin,
  );
}

int? currentFeedDoctorId(DoctorModel currentDoctor) {
  if (currentDoctor.id != null) return currentDoctor.id;
  try {
    return resolveHomeCubit().currentDoctorModel.id;
  } catch (_) {
    return null;
  }
}

/// True when [currentDoctor] authored [feed].
bool isFeedPostOwner({
  required PostCommunityModel feed,
  required DoctorModel currentDoctor,
}) {
  final myId = currentFeedDoctorId(currentDoctor);
  final authorId = feed.doctor?.id;
  return myId != null && authorId != null && myId == authorId;
}

/// Owner can edit/delete own posts; admin can edit/delete any post.
bool canManageFeedPost({
  required PostCommunityModel feed,
  required DoctorModel currentDoctor,
  required HomeModelResponse homeData,
}) {
  return isCommunityFeedAdmin(homeData) ||
      isFeedPostOwner(feed: feed, currentDoctor: currentDoctor);
}

/// Show the admin-only badge when an admin manages someone else's post.
bool showAdminOnlyBadgeOnFeedPost({
  required PostCommunityModel feed,
  required DoctorModel currentDoctor,
  required HomeModelResponse homeData,
}) {
  return isCommunityFeedAdmin(homeData) &&
      !isFeedPostOwner(feed: feed, currentDoctor: currentDoctor);
}
