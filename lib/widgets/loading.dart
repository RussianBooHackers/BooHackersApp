import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:boohack/generated/i18n.dart';
import 'package:boohack/res/res.dart';

/// Loading widget.
/// Display loading screen with loading Widget [widget] and Text [text]
/// default [widget] is
/// ```
/// SpinKitChasingDots(
///   size: 64,
///   color: ITColors.primary
/// )
/// ```
/// default [text] is
/// ```
/// const Text(
///   ITStrings.loading,
///   style: TextStyle(color: ITColors.greyText, fontSize: 12),
/// )
/// ```
/// {@category Widgets}
class ITLoading extends StatelessWidget {
  const ITLoading({Key key, this.text, this.widget}) : super(key: key);
  final Text text;
  final Widget widget;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Column(
              children: <Widget>[
                if (widget != null)
                  widget
                else
                  SpinKitChasingDots(
                    size: 64,
                    color: ITColors.primary,
                  ),
                Container(
                  margin: EdgeInsets.only(top: 24),
                  child: Text(
                    text ?? I18n.of(context).loading,
                    style: TextStyle(fontSize: 12),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
