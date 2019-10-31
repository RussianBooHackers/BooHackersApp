part of './res.dart';

ThemeData lightTheme = ThemeData(
  canvasColor: Colors.transparent,
  brightness: Brightness.light,
  primaryColor: ITColors.primary,
  scaffoldBackgroundColor: ITColors.bg,
  backgroundColor: ITColors.bg,
  cardColor: ITColors.bgLight,
  toggleableActiveColor: ITColors.primary,
  iconTheme: IconThemeData(color: ITColors.primary),
  appBarTheme: AppBarTheme(
      actionsIconTheme: IconThemeData(color: ITColors.text),
      brightness: Brightness.light,
      color: ITColors.bgLight,
      iconTheme: IconThemeData(color: ITColors.text),
      textTheme: TextTheme(title: TextStyle(color: ITColors.text, fontSize: 16, fontWeight: FontWeight.bold))),
  textTheme: TextTheme(title: TextStyle(color: ITColors.text)),
  buttonTheme: ButtonThemeData(buttonColor: ITColors.primaryDark, textTheme: ButtonTextTheme.accent),
);
