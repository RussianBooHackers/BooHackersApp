// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bar.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<Bar> _$barSerializer = new _$BarSerializer();

class _$BarSerializer implements StructuredSerializer<Bar> {
  @override
  final Iterable<Type> types = const [Bar, _$Bar];
  @override
  final String wireName = 'Bar';

  @override
  Iterable<Object> serialize(Serializers serializers, Bar object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[];
    if (object.location != null) {
      result
        ..add('position')
        ..add(serializers.serialize(object.location,
            specifiedType: const FullType(LatLng)));
    }
    if (object.marks != null) {
      result
        ..add('marks')
        ..add(serializers.serialize(object.marks,
            specifiedType:
                const FullType(BuiltList, const [const FullType(int)])));
    }
    if (object.id != null) {
      result
        ..add('_id')
        ..add(serializers.serialize(object.id,
            specifiedType: const FullType(String)));
    }
    if (object.name != null) {
      result
        ..add('name')
        ..add(serializers.serialize(object.name,
            specifiedType: const FullType(String)));
    }
    if (object.address != null) {
      result
        ..add('address')
        ..add(serializers.serialize(object.address,
            specifiedType: const FullType(String)));
    }
    if (object.boohacksCount != null) {
      result
        ..add('boohacks_count')
        ..add(serializers.serialize(object.boohacksCount,
            specifiedType: const FullType(int)));
    }
    return result;
  }

  @override
  Bar deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new BarBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'position':
          result.location = serializers.deserialize(value,
              specifiedType: const FullType(LatLng)) as LatLng;
          break;
        case 'marks':
          result.marks.replace(serializers.deserialize(value,
                  specifiedType:
                      const FullType(BuiltList, const [const FullType(int)]))
              as BuiltList<dynamic>);
          break;
        case '_id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'name':
          result.name = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'address':
          result.address = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'boohacks_count':
          result.boohacksCount = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
      }
    }

    return result.build();
  }
}

class _$Bar extends Bar {
  @override
  final LatLng location;
  @override
  final BuiltList<int> marks;
  @override
  final String id;
  @override
  final String name;
  @override
  final String address;
  @override
  final int boohacksCount;

  factory _$Bar([void Function(BarBuilder) updates]) =>
      (new BarBuilder()..update(updates)).build();

  _$Bar._(
      {this.location,
      this.marks,
      this.id,
      this.name,
      this.address,
      this.boohacksCount})
      : super._();

  @override
  Bar rebuild(void Function(BarBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  BarBuilder toBuilder() => new BarBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Bar &&
        location == other.location &&
        marks == other.marks &&
        id == other.id &&
        name == other.name &&
        address == other.address &&
        boohacksCount == other.boohacksCount;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc($jc($jc(0, location.hashCode), marks.hashCode),
                    id.hashCode),
                name.hashCode),
            address.hashCode),
        boohacksCount.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Bar')
          ..add('location', location)
          ..add('marks', marks)
          ..add('id', id)
          ..add('name', name)
          ..add('address', address)
          ..add('boohacksCount', boohacksCount))
        .toString();
  }
}

class BarBuilder implements Builder<Bar, BarBuilder> {
  _$Bar _$v;

  LatLng _location;
  LatLng get location => _$this._location;
  set location(LatLng location) => _$this._location = location;

  ListBuilder<int> _marks;
  ListBuilder<int> get marks => _$this._marks ??= new ListBuilder<int>();
  set marks(ListBuilder<int> marks) => _$this._marks = marks;

  String _id;
  String get id => _$this._id;
  set id(String id) => _$this._id = id;

  String _name;
  String get name => _$this._name;
  set name(String name) => _$this._name = name;

  String _address;
  String get address => _$this._address;
  set address(String address) => _$this._address = address;

  int _boohacksCount;
  int get boohacksCount => _$this._boohacksCount;
  set boohacksCount(int boohacksCount) => _$this._boohacksCount = boohacksCount;

  BarBuilder();

  BarBuilder get _$this {
    if (_$v != null) {
      _location = _$v.location;
      _marks = _$v.marks?.toBuilder();
      _id = _$v.id;
      _name = _$v.name;
      _address = _$v.address;
      _boohacksCount = _$v.boohacksCount;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Bar other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$Bar;
  }

  @override
  void update(void Function(BarBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$Bar build() {
    _$Bar _$result;
    try {
      _$result = _$v ??
          new _$Bar._(
              location: location,
              marks: _marks?.build(),
              id: id,
              name: name,
              address: address,
              boohacksCount: boohacksCount);
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'marks';
        _marks?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'Bar', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
