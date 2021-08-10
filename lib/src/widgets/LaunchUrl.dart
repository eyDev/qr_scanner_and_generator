import 'package:url_launcher/url_launcher.dart';

launchURL(String text) async {
  if (await canLaunch(text)) {
    await launch(text);
  } else {
    await launch('https://www.google.com/search?q=$text');
  }
}
