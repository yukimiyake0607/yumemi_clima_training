// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'weather_condition_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

WeatherConditionRequest _$WeatherConditionRequestFromJson(
    Map<String, dynamic> json) {
  return _WeatherConditionRequest.fromJson(json);
}

/// @nodoc
mixin _$WeatherConditionRequest {
  String get area => throw _privateConstructorUsedError;
  DateTime get date => throw _privateConstructorUsedError;

  /// Serializes this WeatherConditionRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of WeatherConditionRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WeatherConditionRequestCopyWith<WeatherConditionRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WeatherConditionRequestCopyWith<$Res> {
  factory $WeatherConditionRequestCopyWith(WeatherConditionRequest value,
          $Res Function(WeatherConditionRequest) then) =
      _$WeatherConditionRequestCopyWithImpl<$Res, WeatherConditionRequest>;
  @useResult
  $Res call({String area, DateTime date});
}

/// @nodoc
class _$WeatherConditionRequestCopyWithImpl<$Res,
        $Val extends WeatherConditionRequest>
    implements $WeatherConditionRequestCopyWith<$Res> {
  _$WeatherConditionRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WeatherConditionRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? area = null,
    Object? date = null,
  }) {
    return _then(_value.copyWith(
      area: null == area
          ? _value.area
          : area // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$WeatherConditionRequestImplCopyWith<$Res>
    implements $WeatherConditionRequestCopyWith<$Res> {
  factory _$$WeatherConditionRequestImplCopyWith(
          _$WeatherConditionRequestImpl value,
          $Res Function(_$WeatherConditionRequestImpl) then) =
      __$$WeatherConditionRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String area, DateTime date});
}

/// @nodoc
class __$$WeatherConditionRequestImplCopyWithImpl<$Res>
    extends _$WeatherConditionRequestCopyWithImpl<$Res,
        _$WeatherConditionRequestImpl>
    implements _$$WeatherConditionRequestImplCopyWith<$Res> {
  __$$WeatherConditionRequestImplCopyWithImpl(
      _$WeatherConditionRequestImpl _value,
      $Res Function(_$WeatherConditionRequestImpl) _then)
      : super(_value, _then);

  /// Create a copy of WeatherConditionRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? area = null,
    Object? date = null,
  }) {
    return _then(_$WeatherConditionRequestImpl(
      area: null == area
          ? _value.area
          : area // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$WeatherConditionRequestImpl
    with DiagnosticableTreeMixin
    implements _WeatherConditionRequest {
  const _$WeatherConditionRequestImpl({required this.area, required this.date});

  factory _$WeatherConditionRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$WeatherConditionRequestImplFromJson(json);

  @override
  final String area;
  @override
  final DateTime date;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'WeatherConditionRequest(area: $area, date: $date)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'WeatherConditionRequest'))
      ..add(DiagnosticsProperty('area', area))
      ..add(DiagnosticsProperty('date', date));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WeatherConditionRequestImpl &&
            (identical(other.area, area) || other.area == area) &&
            (identical(other.date, date) || other.date == date));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, area, date);

  /// Create a copy of WeatherConditionRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WeatherConditionRequestImplCopyWith<_$WeatherConditionRequestImpl>
      get copyWith => __$$WeatherConditionRequestImplCopyWithImpl<
          _$WeatherConditionRequestImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WeatherConditionRequestImplToJson(
      this,
    );
  }
}

abstract class _WeatherConditionRequest implements WeatherConditionRequest {
  const factory _WeatherConditionRequest(
      {required final String area,
      required final DateTime date}) = _$WeatherConditionRequestImpl;

  factory _WeatherConditionRequest.fromJson(Map<String, dynamic> json) =
      _$WeatherConditionRequestImpl.fromJson;

  @override
  String get area;
  @override
  DateTime get date;

  /// Create a copy of WeatherConditionRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WeatherConditionRequestImplCopyWith<_$WeatherConditionRequestImpl>
      get copyWith => throw _privateConstructorUsedError;
}
