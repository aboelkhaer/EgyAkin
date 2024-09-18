String hideEmail(String email) {
  if (email.isEmpty) return '';

  // Split the email into local part and domain
  var parts = email.split('@');
  if (parts.length < 2) return email; // Invalid email format

  String localPart = parts[0];
  String domainPart = parts[1];

  // Show only the first character of the local part
  String hiddenLocalPart = localPart.length > 1
      ? localPart[0] + '*' * (localPart.length - 1)
      : localPart;

  return '$hiddenLocalPart@$domainPart';
}
