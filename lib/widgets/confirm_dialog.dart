import 'package:flutter/material.dart';

Widget confirmDialog(context, {Function confirm, String text}) {
  return Column(
    children: <Widget>[
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(text ?? 'Вы желаете подтвердить действие?'),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 32),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            FlatButton(
              onPressed: () {
                confirm();
                Navigator.pop(context);
              },
              child: Text(
                'Подтвердить',
                style: TextStyle(color: Theme.of(context).primaryColor),
              ),
            ),
            FlatButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Отменить'),
            ),
          ],
        ),
      )
    ],
  );
}
