// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint

part of 'weather_condition_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$WeatherConditionRequestImpl _$$WeatherConditionRequestImplFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$WeatherConditionRequestImpl',
      json,
      ($checkedConvert) {
        final val = _$WeatherConditionRequestImpl(
          area: $checkedConvert('area', (v) => v as String),
          date: $checkedConvert('date', (v) => DateTime.parse(v as String)),
        );
        return val;
      },
    );

Map<String, dynamic> _$$WeatherConditionRequestImplToJson(
        _$WeatherConditionRequestImpl instance) =>
    <String, dynamic>{
      'area': instance.area,
      'date': instance.date.toIso8601String(),
    };
