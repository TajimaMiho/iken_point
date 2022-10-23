// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'point_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$PointState {
  Point get point => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $PointStateCopyWith<PointState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PointStateCopyWith<$Res> {
  factory $PointStateCopyWith(
          PointState value, $Res Function(PointState) then) =
      _$PointStateCopyWithImpl<$Res>;
  $Res call({Point point});

  $PointCopyWith<$Res> get point;
}

/// @nodoc
class _$PointStateCopyWithImpl<$Res> implements $PointStateCopyWith<$Res> {
  _$PointStateCopyWithImpl(this._value, this._then);

  final PointState _value;
  // ignore: unused_field
  final $Res Function(PointState) _then;

  @override
  $Res call({
    Object? point = freezed,
  }) {
    return _then(_value.copyWith(
      point: point == freezed
          ? _value.point
          : point // ignore: cast_nullable_to_non_nullable
              as Point,
    ));
  }

  @override
  $PointCopyWith<$Res> get point {
    return $PointCopyWith<$Res>(_value.point, (value) {
      return _then(_value.copyWith(point: value));
    });
  }
}

/// @nodoc
abstract class _$$_PointStateCopyWith<$Res>
    implements $PointStateCopyWith<$Res> {
  factory _$$_PointStateCopyWith(
          _$_PointState value, $Res Function(_$_PointState) then) =
      __$$_PointStateCopyWithImpl<$Res>;
  @override
  $Res call({Point point});

  @override
  $PointCopyWith<$Res> get point;
}

/// @nodoc
class __$$_PointStateCopyWithImpl<$Res> extends _$PointStateCopyWithImpl<$Res>
    implements _$$_PointStateCopyWith<$Res> {
  __$$_PointStateCopyWithImpl(
      _$_PointState _value, $Res Function(_$_PointState) _then)
      : super(_value, (v) => _then(v as _$_PointState));

  @override
  _$_PointState get _value => super._value as _$_PointState;

  @override
  $Res call({
    Object? point = freezed,
  }) {
    return _then(_$_PointState(
      point: point == freezed
          ? _value.point
          : point // ignore: cast_nullable_to_non_nullable
              as Point,
    ));
  }
}

/// @nodoc

class _$_PointState implements _PointState {
  const _$_PointState({this.point = const Point()});

  @override
  @JsonKey()
  final Point point;

  @override
  String toString() {
    return 'PointState(point: $point)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_PointState &&
            const DeepCollectionEquality().equals(other.point, point));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(point));

  @JsonKey(ignore: true)
  @override
  _$$_PointStateCopyWith<_$_PointState> get copyWith =>
      __$$_PointStateCopyWithImpl<_$_PointState>(this, _$identity);
}

abstract class _PointState implements PointState {
  const factory _PointState({final Point point}) = _$_PointState;

  @override
  Point get point => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_PointStateCopyWith<_$_PointState> get copyWith =>
      throw _privateConstructorUsedError;
}
