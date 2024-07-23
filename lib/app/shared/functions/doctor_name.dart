import '../../../exports.dart';

String doctorName({
  required String? firstName,
  required String? lastName,
  required String role,
}) {
  // if (role == 'Admin') {
  //   return 'Admin';
  // }
  return 'Dr.${capitalizeFirstText(firstName ?? '')} ${firstName == lastName ? '' : capitalizeFirstText(lastName ?? '')}';
}
