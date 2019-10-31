import 'dart:async';
import 'dart:ui' as UI;

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:math';

class Utils {
  static String twoDigits(int n) {
    if (n >= 10) return "$n";
    return "0$n";
  }

  static DateTime dayOnly(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }

  static String fourDigits(int n) {
    int absN = n.abs();
    String sign = n < 0 ? "-" : "";
    if (absN >= 1000) return "$n";
    if (absN >= 100) return "${sign}0$absN";
    if (absN >= 10) return "${sign}00$absN";
    return "${sign}000$absN";
  }

  static String getDateTimeNow([DateTime dateTime]) {
    DateTime now = dateTime ?? DateTime.now();
    return "${fourDigits(now.year)}"
        "-${twoDigits(now.month)}"
        "-${twoDigits(now.day)}"
        " "
        "${twoDigits(now.hour)}"
        ":${twoDigits(now.minute)}"
        ":${twoDigits(now.second)}"
        "+00:00";
  }

//  2018-03-28 20:24:00+00:00
  static String getDateTime({DateTime dateTime, String stringTime}) {
    DateTime time = dateTime ?? DateTime.parse(stringTime);
    return "${twoDigits(time.day)}"
        ".${twoDigits(time.month)}"
        ".${fourDigits(time.year)}";
  }

  static String getHourMinuteString({DateTime dateTime, String stringTime}) {
    DateTime time = dateTime ?? DateTime.parse(stringTime);
    return "${twoDigits(time.hour)}:${twoDigits(time.minute)}";
  }

  static showInSnackBar(GlobalKey<ScaffoldState> key, String value) {
    if (key == null || key.currentState == null) return;
    key.currentState.showSnackBar(SnackBar(content: Text(value)));
  }

  static showTextInDialog(GlobalKey<ScaffoldState> key, String text) {
    showInDialog(
        key,
        Text(
          text,
          textAlign: TextAlign.center,
        ));
  }

  static Future<T> showInDialog<T>(
      GlobalKey<ScaffoldState> key, Widget content) {
    if (key == null || key.currentState == null) return null;
    return showDialog<T>(
      context: key.currentState.context,
      builder: (BuildContext context) => Dialog(
        child: Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
          ),
          constraints: BoxConstraints(maxWidth: 300),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 24),
                child: content,
              ),
            ],
          ),
        ),
      ),
    );
  }

  static Stack buildBlurredContainer(Widget backgroundWidget,
      {BoxConstraints constraints = const BoxConstraints.expand(),
      double sigma = 10.0}) {
    return Stack(
      children: <Widget>[
        Container(constraints: constraints, child: backgroundWidget),
        ClipRect(
          child: BackdropFilter(
            filter: UI.ImageFilter.blur(sigmaX: sigma, sigmaY: sigma),
            child: Stack(
              children: <Widget>[
                Container(
                  constraints: constraints,
                  decoration: BoxDecoration(
                      color: Colors.grey.shade200.withOpacity(0.1)),
                )
              ],
            ),
          ),
        )
      ],
    );
  }

  static launchUrl(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  static launchMapsUrl(double lat, double lon) async {
    final url = 'https://www.google.com/maps/search/?api=1&query=$lat,$lon';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  static getNoun(int number, String one, String two, String five) {
    number = number.abs();
    number %= 100;
    if (number >= 5 && number <= 20) {
      return five;
    }
    number %= 10;
    if (number == 1) {
      return one;
    }
    if (number >= 2 && number <= 4) {
      return two;
    }
    return five;
  }

  static getPan(String panString) {
    if (panString == "") return "";
    List<String> pan = panString.split("*");
    List<String> endPan = List<String>();
    endPan.add(pan[0][0] + pan[0][1] + pan[0][2] + pan[0][3]);
    endPan.add(pan[0][0] + pan[0][1] + "XXXXXX");
    endPan.add(pan.last[0] + pan.last[1] + pan.last[2] + pan.last[3]);
    return endPan.join("");
  }

  static formatPhoneNumber(String phone) {
    return phone.substring(0, 2) +
        " (" +
        phone.substring(2, 5) +
        ") " +
        phone.substring(5, 8) +
        "-" +
        phone.substring(8, 10) +
        "-" +
        phone.substring(10);
  }

  static getNormalPrice(double price) {
    price = (price * 10).truncate() / 10;
    RegExp regex = RegExp(r"([.]*0)(?!.*\d)");
    return price.toString().replaceAll(regex, "");
  }

  static bool isValidMd5(String md5) {
    return RegExp(r"(^[a-f0-9]{32}$)").hasMatch(md5);
  }

  static double calculateDistance(LatLng from, LatLng to) {
    double a = pow(sin((to.latitude - from.latitude) * pi / 360), 2) +
        cos(from.latitude * pi / 180) *
            cos(to.latitude * pi / 180) *
            pow(sin((to.longitude - from.longitude) * pi / 360), 2);
    return 6367 * 2 * atan2(sqrt(a), sqrt(1 - a));
  }
}
