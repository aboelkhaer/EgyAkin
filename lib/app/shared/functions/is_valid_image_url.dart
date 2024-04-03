bool isValidImageUrl(String url) {
  // Regular expression for URL pattern
  final RegExp urlRegex = RegExp(
    r'^(?:http|https):\/\/[^\s\.]+\.[^\s]{2,}$',
    caseSensitive: false,
  );

  // Check if the URL matches the pattern
  return urlRegex.hasMatch(url);
}
