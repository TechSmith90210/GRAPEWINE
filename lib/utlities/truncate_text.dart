String truncateText(String text, int maxLength) {
  if (text.isNotEmpty && text.length > maxLength) {
    return text.substring(0, maxLength) + '...';
  }
  return text;
}