part of './res.dart';

ThemeData darkTheme = ThemeData(
  canvasColor: Colors.transparent,
  brightness: Brightness.dark,
  primaryColor: ITColors.primaryDark,
  scaffoldBackgroundColor: ITColors.bgDark,
  cardColor: ITColors.bgDarkLight,
  toggleableActiveColor: ITColors.primaryDark,
  iconTheme: IconThemeData(color: ITColors.primaryDark),
  appBarTheme: AppBarTheme(
      actionsIconTheme: IconThemeData(color: ITColors.text),
      brightness: Brightness.dark,
      color: ITColors.bgDarkLight,
      iconTheme: IconThemeData(color: ITColors.textDark),
      textTheme: TextTheme(
        title: TextStyle(color: ITColors.textDark, fontSize: 16, fontWeight: FontWeight.bold),
      )),
  textTheme: TextTheme(
    title: TextStyle(color: ITColors.textDark),
  ),
  buttonTheme: ButtonThemeData(buttonColor: ITColors.primaryDark),
);
