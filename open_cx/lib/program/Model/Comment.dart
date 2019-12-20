import 'User.dart';

class Comment {
  User user;
  String content;
  DateTime date;
  bool edited = false;

  Comment(this.user, this.content, this.date);

  void setEdited() {
    this.edited = true;
  }

  String getAgeString() {
    Duration diff = DateTime.now().difference(date);
    if (diff.inSeconds < 60)
      return "<1 minute ago";

    int inMinutes = diff.inMinutes;
    if (inMinutes == 1)
      return "1 minute ago";
    if (inMinutes < 60)
      return inMinutes.toString() + " minutes ago";

    int inHours = diff.inHours;
    if (inHours == 1)
      return "1 hour ago";
    if (inHours < 24)
      return inHours.toString() + " hours ago";

    int inDays = diff.inDays;
    if (inDays == 1)
      return "Yesterday";
    if (inDays < 30)
      return inDays.toString() + " days ago";
    if (inDays < 60)
      return "A month ago";
    if (inDays < 365)
      return (inDays ~/ 30).toString() + " months ago";
    return "Over a year ago";
  }
}