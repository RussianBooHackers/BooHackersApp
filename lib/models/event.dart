import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

part 'event.g.dart';

abstract class Event implements Built<Event, EventBuilder> {
  Event._();

  factory Event([updates(EventBuilder b)]) = _$Event;

  @nullable
  @BuiltValueField(wireName: 'type')
  String get type;

  @nullable
  @BuiltValueField(wireName: 'coordinates')
  LatLng get coordinates;

  static Serializer<Event> get serializer => _$eventSerializer;
}
