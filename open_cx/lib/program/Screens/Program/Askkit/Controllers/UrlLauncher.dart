import 'package:url_launcher/url_launcher.dart';

class UrlLauncher {
  static void launchURL(String url) async {
    if (!url.startsWith("http://") && !url.startsWith("https://"))
      url = "http://" + url;
    if (await canLaunch(url)) {
      await launch(url);
    }
  }
}