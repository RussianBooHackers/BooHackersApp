import 'package:boohack/generated/i18n.dart';
import 'package:boohack/res/text_style.dart';
import 'package:flutter/material.dart';

import 'view/index.dart';

/// About Screen
/// {@category Screens}
class AboutScreen extends StatefulWidget {
  @override
  _AboutScreenState createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'О приложении',
          style: ITTextStyle(fontFamily: 'Oswald'),
        ),
        centerTitle: true,
      ),
      body: AboutView(),
    );
  }
}
