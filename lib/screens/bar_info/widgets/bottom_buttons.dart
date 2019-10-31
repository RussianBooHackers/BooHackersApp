import 'package:boohack/generated/i18n.dart';
import 'package:boohack/res/res.dart';
import 'package:flutter/material.dart';

import 'feedback.dart';

class BottomButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Column(
      children: <Widget>[
        Container(
          width: width * .9,
          height: 48,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: ITColors.primaryDark),
          child: Center(
            child: Text(
              I18n.of(context).readQR,
              style: TextStyle(color: ITColors.bg),
            ),
          ),
        ),
        GestureDetector(
          onTap: () => showModalBottomSheet(builder: (BuildContext _context) => FeedBackWidget(), context: context),
          child: Container(
            margin: EdgeInsets.only(top: 12),
            width: width * .9,
            height: 48,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
            child: Center(
              child: Text(
                I18n.of(context).feedback,
                style: TextStyle(color: ITColors.primaryDark),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
