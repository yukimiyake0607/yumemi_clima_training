// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'weather_condition_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

WeatherConditionResponse _$WeatherConditionResponseFromJson(
    Map<String, dynamic> json) {
  return _WeatherConditionResponse.fromJson(json);
}

/// @nodoc
mixin _$WeatherConditionResponse {
  WeatherCondition get weatherCondition => throw _privateConstructorUsedError;
  int get maxTemperature => throw _privateConstructorUsedError;
  int get minTemperature => throw _privateConstructorUsedError;

  /// Serializes this WeatherConditionResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of WeatherConditionResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WeatherConditionResponseCopyWith<WeatherConditionResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WeatherConditionResponseCopyWith<$Res> {
  factory $WeatherConditionResponseCopyWith(WeatherConditionResponse value,
          $Res Function(WeatherConditionResponse) then) =
      _$WeatherConditionResponseCopyWithImpl<$Res, WeatherConditionResponse>;
  @useResult
  $Res call(
      {WeatherCondition weatherCondition,
      int maxTemperature,
      int minTemperature});
}

/// @nodoc
class _$WeatherConditionResponseCopyWithImpl<$Res,
        $Val extends WeatherConditionResponse>
    implements $WeatherConditionResponseCopyWith<$Res> {
  _$WeatherConditionResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WeatherConditionResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? weatherCondition = null,
    Object? maxTemperature = null,
    Object? minTemperature = null,
  }) {
    return _then(_value.copyWith(
      weatherCondition: null == weatherCondition
          ? _value.weatherCondition
          : weatherCondition // ignore: cast_nullable_to_non_nullable
              as WeatherCondition,
      maxTemperature: null == maxTemperature
          ? _value.maxTemperature
          : maxTemperature // ignore: cast_nullable_to_non_nullable
              as int,
      minTemperature: null == minTemperature
          ? _value.minTemperature
          : minTemperature // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$WeatherConditionResponseImplCopyWith<$Res>
    implements $WeatherConditionResponseCopyWith<$Res> {
  factory _$$WeatherConditionResponseImplCopyWith(
          _$WeatherConditionResponseImpl value,
          $Res Function(_$WeatherConditionResponseImpl) then) =
      __$$WeatherConditionResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {WeatherCondition weatherCondition,
      int maxTemperature,
      int minTemperature});
}

/// @nodoc
class __$$WeatherConditionResponseImplCopyWithImpl<$Res>
    extends _$WeatherConditionResponseCopyWithImpl<$Res,
        _$WeatherConditionResponseImpl>
    implements _$$WeatherConditionResponseImplCopyWith<$Res> {
  __$$WeatherConditionResponseImplCopyWithImpl(
      _$WeatherConditionResponseImpl _value,
      $Res Function(_$WeatherConditionResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of WeatherConditionResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? weatherCondition = null,
    Object? maxTemperature = null,
    Object? minTemperature = null,
  }) {
    return _then(_$WeatherConditionResponseImpl(
      weatherCondition: null == weatherCondition
          ? _value.weatherCondition
          : weatherCondition // ignore: cast_nullable_to_non_nullable
              as WeatherCondition,
      maxTemperature: null == maxTemperature
          ? _value.maxTemperature
          : maxTemperature // ignore: cast_nullable_to_non_nullable
              as int,
      minTemperature: null == minTemperature
          ? _value.minTemperature
          : minTemperature // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$WeatherConditionResponseImpl implements _WeatherConditionResponse {
  const _$WeatherConditionResponseImpl(
      {required this.weatherCondition,
      required this.maxTemperature,
      required this.minTemperature});

  factory _$WeatherConditionResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$WeatherConditionResponseImplFromJson(json);

  @override
  final WeatherCondition weatherCondition;
  @override
  final int maxTemperature;
  @override
  final int minTemperature;

  @override
  String toString() {
    return 'WeatherConditionResponse(weatherCondition: $weatherCondition, maxTemperature: $maxTemperature, minTemperature: $minTemperature)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WeatherConditionResponseImpl &&
            (identical(other.weatherCondition, weatherCondition) ||
                other.weatherCondition == weatherCondition) &&
            (identical(other.maxTemperature, maxTemperature) ||
                other.maxTemperature == maxTemperature) &&
            (identical(other.minTemperature, minTemperature) ||
                other.minTemperature == minTemperature));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, weatherCondition, maxTemperature, minTemperature);

  /// Create a copy of WeatherConditionResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WeatherConditionResponseImplCopyWith<_$WeatherConditionResponseImpl>
      get copyWith => __$$WeatherConditionResponseImplCopyWithImpl<
          _$WeatherConditionResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WeatherConditionResponseImplToJson(
      this,
    );
  }
}

abstract class _WeatherConditionResponse implements WeatherConditionResponse {
  const factory _WeatherConditionResponse(
      {required final WeatherCondition weatherCondition,
      required final int maxTemperature,
      required final int minTemperature}) = _$WeatherConditionResponseImpl;

  factory _WeatherConditionResponse.fromJson(Map<String, dynamic> json) =
      _$WeatherConditionResponseImpl.fromJson;

  @override
  WeatherCondition get weatherCondition;
  @override
  int get maxTemperature;
  @override
  int get minTemperature;

  /// Create a copy of WeatherConditionResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WeatherConditionResponseImplCopyWith<_$WeatherConditionResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}
