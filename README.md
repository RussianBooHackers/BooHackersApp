# boohack

## commit from Grizzly bar SPB

instruction:

`flutter packages get`

`flutter pub run build_runner build --delete-conflicting-outputs`

`flutter run`

## Before first running

add files:

- android/app/google-services.json
- android/app/key.jks
- android/boohackapp.properties
- android/key.properties

#### google-services.json
we can download this file in the firebase console. Needed for firebase to work

#### key.jks
application signature. Google it!

#### boohackapp.properties
paste this to file and YOUR_MAP_KEY to your map token from google console:

```
mapKey=<YOUR_MAP_KEY>
```

#### key.properties

properties for signature. If it’s not clear what to shove, google it
```
storePassword=YOUR_STORE_PASSWORD

keyPassword=YOUR_KEY_PASSWORD

keyAlias=YOUR_KEY_ALIAS

storeFile=./key.jks
```
After adding the files, open the android folder in Android Studio and "build gradle"

If you didn’t succeed in starting the application after my explanations, have a drink and start reading readme first

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
