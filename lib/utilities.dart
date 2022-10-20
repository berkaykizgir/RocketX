class Utilities {
  static final Utilities _instance = Utilities._internal();
  factory Utilities() => _instance;
  Utilities._internal();
  String readableTimestamp(int timestamp) {
    final difference = DateTime.now().difference(DateTime.fromMillisecondsSinceEpoch(timestamp, isUtc: true));

    if (difference.inSeconds <= 10) {
      return "Just now";
    } else if (difference.inSeconds <= 60) {
      return "Few seconds ago";
    } else if (difference.inSeconds <= 120) {
      return "A minute ago";
    } else if (difference.inMinutes <= 60) {
      return "${difference.inMinutes} minutes ago";
    } else if (difference.inHours <= 24) {
      return "${difference.inHours}h";
    } else if (difference.inDays < 7) {
      return "${difference.inDays}d";
    } else if (difference.inDays < 14) {
      return "A week ago";
    } else if (difference.inDays < 21) {
      return "Two weeks ago";
    } else if (difference.inDays < 28) {
      return "Three weeks ago";
    } else if (difference.inDays <= 61) {
      return "A month ago";
    } else if (difference.inDays <= 91) {
      return "A two months ago";
    } else {
      return "${difference.inDays}d";
    }
  }
}
