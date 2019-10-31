# boohack

instruction:

`flutter packages get`

`flutter pub run build_runner build --delete-conflicting-outputs`

`flutter run`

## !!Important note

Since it was added source generation. please run `$ flutter pub run build_runner build --delete-conflicting-outputs` first or `$ flutter pub run build_runner watch --delete-conflicting-outputs` for continuous rebuilding. but be aware it can lock the flutter.

## To generate docs use

`dartdoc`

## Models

https://charafau.github.io/json2builtvalue/

You can generate base model class using this site. Just paste class from generated code on this site to your model class.
Then, remove jsonTo and Json from.
Model need to be look like
```
import 'dart:convert';

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'serializers.dart';

part 'location.g.dart';

abstract class Location implements Built<Location, LocationBuilder> {
  Location._();

  factory Location([updates(LocationBuilder b)]) = _$Location;

  @nullable
  @BuiltValueField(wireName: 'type')
  String get type;
  
  @nullable
  @BuiltValueField(wireName: 'coordinates')
  LatLng get coordinates;

  static Serializer<Location> get serializer => _$locationSerializer;
}
```

## I18n

- install `vscode-flutter-i18n-json` plugin for VSCode (https://marketplace.visualstudio.com/items?itemName=esskar.vscode-flutter-i18n-json)
- use `Ctrl+Shift+P` for palette
- add new locale if needed
- fill `/i18n/*.json` files with your localization strings
- **regenerate** Flutter files via Palette (`>Flutter I18n JSON: Update`)
- use strings

### Examples:
**Simple string**

`/i18n/en-US.json`
```json
{
    "title": "Itis template"
}
```
`/lib/screen.dart`
```dart
I18n.of(context).title // => Itis template
```

**String with parameter**

`/i18n/en-US.json`
```json
{
    "greetTo": "Hello, {name}"
}
```
`/lib/screen.dart`
```dart
I18n.of(context).greetTo("User name") // => Hello, User name
```
