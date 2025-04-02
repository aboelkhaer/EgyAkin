import '../../../exports.dart';

String doctorName({
  required String? firstName,
  required String? lastName,
  required String role,
}) {
  bool isVerifiedUserVar = isVerifiedUser(role);

  if (isVerifiedUserVar) {
    return 'Dr.${capitalizeFirstText(firstName ?? '')} ${firstName == lastName ? '' : capitalizeFirstText(lastName ?? '')}';
  }
  return '${capitalizeFirstText(firstName ?? '')} ${firstName == lastName ? '' : capitalizeFirstText(lastName ?? '')}';
}
