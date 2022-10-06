import 'dart:io';

import 'package:url_launcher/url_launcher.dart';

class Helper {
  static Future<void> openMap(double latitude, double longitude) async {
    String googleUrl =
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    if (await canLaunch(googleUrl)) {
      await launch(googleUrl);
    } else {
      throw 'Could not open the map.';
    }
  }

  static void makingPhoneCall(String phone) async {
    String url = 'tel:$phone';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  static void launchWhatsApp(String phone) async {
    String url() {
      if (Platform.isIOS) {
        return "whatsapp://wa.me/+254${phone.substring(phone.length - 9)}/?text=${Uri.parse("")}";
      } else {
        return "whatsapp://send?phone=+254${phone.substring(phone.length - 9)}&text=${Uri.parse("")}";
      }
    }

    if (await canLaunch(url())) {
      await launch(url());
    } else {
      throw 'Could not launch ${url()}';
    }
  }

  static void launchEmail(String email) async {
    final Uri params = Uri(
      scheme: 'mailto',
      path: email,
      query: 'subject=HELP REQUEST', //add subject and body here
    );
    var url = params.toString();
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  static void launchSMS(String phone, String name) async {
    // Android
    String uri =
        'sms:+254${phone.substring(phone.length - 9)}?body=Hello $name.';
    if (await canLaunch(uri)) {
      await launch(uri);
    } else {
      // iOS
      String uri =
          'sms:254${phone.substring(phone.length - 9)}?body=Hello $name.';
      if (await canLaunch(uri)) {
        await launch(uri);
      } else {
        throw 'Could not launch $uri';
      }
    }
  }
}
