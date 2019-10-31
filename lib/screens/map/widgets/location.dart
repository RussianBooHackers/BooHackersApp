import 'package:boohack/res/res.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class LocationWidget extends StatelessWidget {
  const LocationWidget({Key key, this.onTap}) : super(key: key);
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap != null ? onTap() : () => {},
      child: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: ITColors.bgLight,
            boxShadow: [
              BoxShadow(
                color: ITColors.secondaryText.withOpacity(.6),
                blurRadius: 5.0,
              ),
            ]),
        child: Center(
          child: Icon(
            LineIcons.map_marker,
            color: ITColors.primary,
          ),
        ),
      ),
    );
  }
}
