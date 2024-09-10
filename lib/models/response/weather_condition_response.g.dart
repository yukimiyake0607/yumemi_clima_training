// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint

part of 'weather_condition_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$WeatherConditionResponseImpl _$$WeatherConditionResponseImplFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$WeatherConditionResponseImpl',
      json,
      ($checkedConvert) {
        final val = _$WeatherConditionResponseImpl(
          weatherCondition:
              $checkedConvert('weather_condition', (v) => v as String),
          maxTemperature:
              $checkedConvert('max_temperature', (v) => (v as num).toInt()),
          minTemperature:
              $checkedConvert('min_temperature', (v) => (v as num).toInt()),
        );
        return val;
      },
      fieldKeyMap: const {
        'weatherCondition': 'weather_condition',
        'maxTemperature': 'max_temperature',
        'minTemperature': 'min_temperature'
      },
    );

Map<String, dynamic> _$$WeatherConditionResponseImplToJson(
        _$WeatherConditionResponseImpl instance) =>
    <String, dynamic>{
      'weather_condition': instance.weatherCondition,
      'max_temperature': instance.maxTemperature,
      'min_temperature': instance.minTemperature,
    };
