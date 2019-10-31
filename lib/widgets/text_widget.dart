import 'package:auto_size_text/auto_size_text.dart';
import 'package:boohack/res/res.dart';
import 'package:flutter/material.dart';

class TextBlockWidget extends StatelessWidget {
  const TextBlockWidget(this.type, this.text,
      {this.withDivider = true, this.customIcon, this.height = 200});

  final String type;
  final String text;
  final bool withDivider;
  final Widget customIcon;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 24),
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                type,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Oswald'),
              ),
              SizedBox(
                width: 24,
              ),
              if (customIcon == null)
                Opacity(
                  opacity: .8,
                  child: Container(
                    height: 36,
                    child: ITIcons.getIcons(type),
                  ),
                )
              else
                Opacity(
                  opacity: .8,
                  child: Container(
                    height: 36,
                    child: customIcon,
                  ),
                ),
              if (customIcon == null)
                SizedBox(
                  width: 12,
                ),
            ],
          ),
          Container(
            margin: EdgeInsets.only(top: 24),
            width: MediaQuery.of(context).size.width * .9,
            child: AutoSizeText(
              text,
              style: TextStyle(color: ITColors.text, fontFamily: 'Circe'),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
