import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:boohack/models/models.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

part 'bar.g.dart';

abstract class Bar implements Built<Bar, BarBuilder> {
  Bar._();

  factory Bar([updates(BarBuilder b)]) = _$Bar;

  @nullable
  @BuiltValueField(wireName: 'position')
  LatLng get location;

  @nullable
  @BuiltValueField(wireName: 'marks')
  BuiltList<int> get marks;

  @nullable
  @BuiltValueField(wireName: '_id')
  String get id;

  @nullable
  @BuiltValueField(wireName: 'name')
  String get name;

  @nullable
  @BuiltValueField(wireName: 'address')
  String get address;

  @nullable
  @BuiltValueField(wireName: 'boohacks_count')
  int get boohacksCount;

  static Serializer<Bar> get serializer => _$barSerializer;
}
