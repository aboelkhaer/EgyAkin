String hideNationalId(String nationalID) {
  if (nationalID.isEmpty || nationalID.length < 3) {
    String maskedNationalID = '*' * nationalID.length;
    return maskedNationalID;
  } else {
    // Get the last three digits
    String lastThreeDigits = nationalID.substring(nationalID.length - 3);

    // Mask all other digits with asterisks
    String maskedNationalID = '*' * (nationalID.length - 3) + lastThreeDigits;
    return maskedNationalID;
  }
}
