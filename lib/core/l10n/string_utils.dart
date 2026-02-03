sealed class StringUtils {
  static String extractUrlFromString(String url) {
    if (url.isEmpty) {
      return "";
    }

    String cleanedIntput = url.replaceAll(RegExp(r'[\[\]\"]'), '');

    if (!cleanedIntput.startsWith("htts")) {
      return '';
    }

    return cleanedIntput;
  }
}
