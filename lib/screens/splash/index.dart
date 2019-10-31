import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:boohack/generated/i18n.dart';
import 'package:boohack/widgets/loading.dart';

/// Splashscreen with loader
/// Displayed when app loading and prepare data
/// Consists of:
/// title from [ITStrings.title]
/// loader widget [ITLoader]
/// {@category Screens}
class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double get width => MediaQuery.of(context).size.width;
  double get height => MediaQuery.of(context).size.height;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(bottom: height * .2),
            child: Text(
              I18n.of(context).title,
              style:
                  TextStyle(fontWeight: FontWeight.bold, fontSize: width * .1),
            ),
          ),
          ITLoading()
        ],
      ),
    );
  }
}
