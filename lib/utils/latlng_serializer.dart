import 'dart:convert';

import 'package:built_collection/built_collection.dart';
import 'package:built_value/serializer.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LatLngSerializer implements PrimitiveSerializer<LatLng> {
  final bool structured = false;
  @override
  final Iterable<Type> types = new BuiltList<Type>([LatLng]);

  @override
  Object serialize(Serializers serializers, LatLng latLng, {FullType specifiedType: FullType.unspecified}) {
    return [latLng.latitude, latLng.longitude];
  }

  @override
  LatLng deserialize(Serializers serializers, Object serialized, {FullType specifiedType: FullType.unspecified}) {
    List<dynamic> toSerialize = serialized as List<dynamic>;
    return LatLng(toSerialize[1], toSerialize[3]);
  }

  @override
  String get wireName => 'coordinates';
}
