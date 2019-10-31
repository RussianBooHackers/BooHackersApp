import 'package:boohack/blocs/blocs.dart';
import 'package:boohack/generated/i18n.dart';
import 'package:boohack/models/models.dart';
import 'package:boohack/res/res.dart';
import 'package:boohack/res/text_style.dart';
import 'package:boohack/utils/utils.dart';
import 'package:boohack/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AboutView extends StatelessWidget {
  const AboutView({Key key, this.bar}) : super(key: key);
  final Bar bar;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            SizedBox(
              height: 12,
            ),
            Container(
              height: 100,
              width: width,
              child: Center(
                child: Image.asset('assets/images/logo.jpeg'),
              ),
            ),
            SizedBox(
              height: 24,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Что тут будет?',
                  style: ITTextStyle(fontFamily: 'Oswald', fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 12,
                ),
                Text(
                  'Профиль бухакера',
                  style: ITTextStyle(),
                ),
              ],
            ),
            SizedBox(
              height: 24,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Почему тут до сих пор нет профиля',
                  style: ITTextStyle(fontFamily: 'Oswald', fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 12,
                ),
                Text(
                  'Потому что пилится',
                  style: ITTextStyle(),
                ),
              ],
            ),
            SizedBox(
              height: 24,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Контакты (куда жаловаться и на кого)',
                  style: ITTextStyle(fontFamily: 'Oswald', fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 12,
                ),
                GestureDetector(
                  onTap: () => Utils.launchUrl('https://t.me/gicha1'),
                  child: Text(
                    '@gicha1',
                    style: ITTextStyle(),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 24,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Ресурсы',
                  style: ITTextStyle(fontFamily: 'Oswald', fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 12,
                ),
                Text(
                  'Иконки взяты с https://icons8.com',
                  style: ITTextStyle(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
