import '../../../exports.dart';

String doctorName({
  required String? firstName,
  required String? lastName,
  required String role,
}) {
  final isVerifiedUserVar = isVerifiedUser(role);

  final first = (firstName ?? '').trim();
  final last = (lastName ?? '').trim();

  // Some payloads put the full name in `name` and leave `lname` empty.
  final firstCap = capitalizeFirstText(first) ?? '';
  final lastCap =
      (last.isEmpty || last == first) ? '' : (capitalizeFirstText(last) ?? '');

  if (isVerifiedUserVar) {
    final body = lastCap.isEmpty ? firstCap : '$firstCap $lastCap';
    if (body.isEmpty) return '';
    return body.startsWith('Dr.') || body.startsWith('Dr ')
        ? body
        : 'Dr.$body';
  }
  if (lastCap.isEmpty) return firstCap;
  return '$firstCap $lastCap';
}
