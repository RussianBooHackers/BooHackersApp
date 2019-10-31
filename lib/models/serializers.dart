import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';
import 'package:built_collection/built_collection.dart';
import 'package:boohack/utils/date_serializer_plugin.dart';
import 'package:boohack/utils/latlng_serializer.dart';

import './models.dart';

part 'serializers.g.dart';

/// Serializers
/// Used to serialize/deserialize JSON
/// Before using Serializers you must to:
/// fill your Serializers in [@SerializersFor]
///
/// Then you can use Serializers
/// Examples:
/// * deserialize JSON
/// ```
/// var json='your json';
/// serializers.deserializeWith(YourSerializer.serializer, json)
/// ```
///
/// {@category Network}
@SerializersFor(const [User, Bar, Event, Post])
final Serializers serializers = (_$serializers.toBuilder()
      ..add(DateTimeSerializer())
      ..add(LatLngSerializer())
      ..addPlugin(StandardJsonPlugin()))
    .build();
