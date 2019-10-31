import 'package:auto_size_text/auto_size_text.dart';
import 'package:boohack/generated/i18n.dart';
import 'package:boohack/models/bar.dart';
import 'package:boohack/res/res.dart';
import 'package:flutter/material.dart';

class BarInfoView extends StatefulWidget {
  const BarInfoView({Key key, this.bar}) : super(key: key);
  final Bar bar;

  @override
  _BarInfoViewState createState() => _BarInfoViewState();
}

class _BarInfoViewState extends State<BarInfoView> {
  double get width => MediaQuery.of(context).size.width;
  double get height => MediaQuery.of(context).size.height;
  Bar get bar => widget.bar;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: EdgeInsets.symmetric(vertical: 24, horizontal: width * .05),
          child: Column(children: [
            Container(
              width: double.infinity,
              child: AutoSizeText(
                bar.name,
                textAlign: TextAlign.start,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 10),
            Container(
              width: double.infinity,
              child: AutoSizeText(
                bar.address,
                textAlign: TextAlign.start,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
              ),
            ),
          ]),
        ),
      ],
    );
  }
}
