import 'package:built_collection/built_collection.dart';
import 'package:built_value/serializer.dart';

///A Serializer which does basically "nothing".
/// It is used, as a DateTime returned by Firestore is ALREADY a DateTime Object
/// and not just "data" which has to be deserialized into a DateTime.
class DateTimeSerializer implements PrimitiveSerializer<DateTime> {
  final bool structured = false;
  @override
  final Iterable<Type> types = new BuiltList<Type>([DateTime]);

  @override
  Object serialize(Serializers serializers, DateTime dateTime, {FullType specifiedType: FullType.unspecified}) {
    return dateTime.toIso8601String();
  }

  @override
  DateTime deserialize(Serializers serializers, Object serialized, {FullType specifiedType: FullType.unspecified}) {
    return DateTime.parse(serialized);
  }

  @override
  String get wireName => 'expire';
}
