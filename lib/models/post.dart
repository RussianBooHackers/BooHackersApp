import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

part 'post.g.dart';

abstract class Post implements Built<Post, PostBuilder> {
  Post._();

  factory Post([updates(PostBuilder b)]) = _$Post;

  @nullable
  @BuiltValueField(wireName: 'type')
  String get type;

  @nullable
  @BuiltValueField(wireName: 'coordinates')
  LatLng get coordinates;

  static Serializer<Post> get serializer => _$postSerializer;
}
