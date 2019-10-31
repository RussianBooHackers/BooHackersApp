part of './res.dart';

/// Icons
/// This file contains all custom icons, provided in app
///
/// {@category Resources}
class ITIcons {
  static Image apple = Image.asset('assets/icons/apple.png', fit: BoxFit.cover);
  static Image battery = Image.asset('assets/icons/battery.png', fit: BoxFit.cover);
  static Image bottle = Image.asset('assets/icons/bottle.png', fit: BoxFit.cover);
  static Image glass = Image.asset('assets/icons/glass.png', fit: BoxFit.cover);
  static Image light = Image.asset('assets/icons/light.png', fit: BoxFit.cover);
  static Image metal = Image.asset('assets/icons/metal.png', fit: BoxFit.cover);
  static Image paper = Image.asset('assets/icons/paper.png', fit: BoxFit.cover);
  static Image tech = Image.asset('assets/icons/tech.png', fit: BoxFit.cover);
  static Image wear = Image.asset('assets/icons/wear.png', fit: BoxFit.cover);
  static Image dangerous = Image.asset('assets/icons/dangerous.png', fit: BoxFit.cover);
  static Image tetrapack = Image.asset('assets/icons/tetrapack.png', fit: BoxFit.cover);
  static Image boohack = Image.asset('assets/icons/logo.png', fit: BoxFit.cover);

  static Widget getIcons(String name) {
    switch (name.toLowerCase()) {
      case "иное":
        return apple;
        break;
      case "батарейки":
        return battery;
        break;
      case "пластик":
        return bottle;
        break;
      case "стекло":
        return glass;
        break;
      case "лампочки":
        return light;
        break;
      case "металл":
        return metal;
        break;
      case "бумага":
        return paper;
        break;
      case "бытовая техника":
        return tech;
        break;
      case "одежда":
        return wear;
        break;
      case "опасные отходы":
        return dangerous;
        break;
      case "тетра Пак":
        return tetrapack;
        break;
      case "о нас":
        return boohack;
        break;
      default:
        return battery;
        break;
    }
  }
}
