String capitalizeFirstText(String text) {
  if (text == 'null') {
    return 'No description';
  }
  if (text.isEmpty) {
    return text; // Return empty string if input is empty
  }
  // Capitalize first letter and concatenate with remaining characters
  return text[0].toUpperCase() + text.substring(1);
}
