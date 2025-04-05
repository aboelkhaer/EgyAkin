String? capitalizeFirstText(String text, [bool isGroupRow = false]) {
  if (text == 'null' && isGroupRow == false) {
    return '';
  }
  if (text == 'null' && isGroupRow == true) {
    return null;
  }

  if (text.isEmpty) {
    return text; // Return empty string if input is empty
  }
  // Capitalize first letter and concatenate with remaining characters
  return text[0].toUpperCase() + text.substring(1);
}
