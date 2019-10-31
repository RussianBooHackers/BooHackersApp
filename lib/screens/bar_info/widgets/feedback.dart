import 'package:boohack/generated/i18n.dart';
import 'package:boohack/res/res.dart';
import 'package:flutter/material.dart';

class FeedBackWidget extends StatelessWidget {
  const FeedBackWidget();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Material(
      elevation: 0.0,
      shadowColor: Colors.black,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(16),
        topRight: Radius.circular(16),
      ),
      color: Colors.white,
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 20.0),
              child: Text(
                I18n.of(context).reportProblem,
                style: TextStyle(fontSize: 20),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 30.0),
              child: TextField(
                decoration: InputDecoration(
                    hintText: I18n.of(context).describeYourProblem,
                    border: UnderlineInputBorder(borderSide: BorderSide.none)),
              ),
            ),
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                width: width * .9,
                height: 48,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: ITColors.primaryDark),
                child: Center(
                  child: Text(
                    I18n.of(context).send,
                    style: TextStyle(color: ITColors.bg),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              height: MediaQuery.of(context).viewInsets.bottom == 0
                  ? 0
                  : MediaQuery.of(context).size.width * .6,
            )
          ],
        ),
      ),
    );
  }
}
