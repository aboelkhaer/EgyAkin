import 'package:egy_akin/exports.dart';

bool isVerifiedUser(String? isSyndicateCardRequired) {
  switch (isSyndicateCardRequired) {
    case 'Verified':
      return true;
    case 'true':
      return true;
    case 'True':
      return true;

    default:
      return false;
  }
}

bool isAdmin(String? role) {
  switch (role) {
    case AppStrings.roleAdmin:
      return true;

    default:
      return false;
  }
}
