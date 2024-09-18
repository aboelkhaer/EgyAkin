String convertTextToSymbols(String? text) {
  if (text == null) {
    return '';
  }
  return text.split(' ').map((word) {
    // Check if the word contains Arabic characters
    bool isArabic = RegExp(r'[\u0600-\u06FF]').hasMatch(word);

    if (isArabic || word.length > 1) {
      // Show only the first character for all words and obfuscate the rest
      return word[0] + List.filled(word.length - 1, '*').join();
    } else {
      return word; // For single-character words, return them as is
    }
  }).join(' ');
}
