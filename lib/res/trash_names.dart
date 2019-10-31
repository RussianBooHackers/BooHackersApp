part of './res.dart';

/// Colors
/// This file contains all colors, provided in app
///
/// {@category Resources}
class ITTrashNames {
  static String food = "пищевые отходы";
  static String battery ="батарейки";
  static String plastic = "пластик";
  static String glass = "стекло";
  static String light = "лампочки";
  static String metal = "металл";
  static String paper = "бумага";

  String getName(String name) {
    switch (name) {
      case "apple":
        return food;
        break;
      case "battery":
        return battery;
        break;
      case "bottle":
        return plastic;
        break;
      case "glass":
        return glass;
        break;
      case "light":
        return light;
        break;
      case "metal":
        return metal;
        break;
      case "paper":
        return paper;
        break;
      default:
        return battery;
        break;
    }
  }
}
