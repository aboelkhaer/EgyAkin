// Utility function to check if a string is a valid date
bool isValidDate(String input) {
  try {
    DateTime.parse(input);
    return true;
  } catch (e) {
    return false;
  }
}
