// Mocks generated by Mockito 5.4.4 from annotations
// in flutter_training/test/mock/weather_repository_mock.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:flutter_training/data/repository/weather_repository.dart'
    as _i3;
import 'package:flutter_training/models/response/weather_condition_response.dart'
    as _i2;
import 'package:flutter_training/models/weather_request.dart' as _i5;
import 'package:mockito/mockito.dart' as _i1;
import 'package:mockito/src/dummies.dart' as _i6;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeWeatherConditionResponse_0 extends _i1.SmartFake
    implements _i2.WeatherConditionResponse {
  _FakeWeatherConditionResponse_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [WeatherRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockWeatherRepository extends _i1.Mock implements _i3.WeatherRepository {
  @override
  _i4.Future<_i2.WeatherConditionResponse> getWeather(
          _i5.WeatherRequest? weatherRequest) =>
      (super.noSuchMethod(
        Invocation.method(
          #getWeather,
          [weatherRequest],
        ),
        returnValue: _i4.Future<_i2.WeatherConditionResponse>.value(
            _FakeWeatherConditionResponse_0(
          this,
          Invocation.method(
            #getWeather,
            [weatherRequest],
          ),
        )),
        returnValueForMissingStub:
            _i4.Future<_i2.WeatherConditionResponse>.value(
                _FakeWeatherConditionResponse_0(
          this,
          Invocation.method(
            #getWeather,
            [weatherRequest],
          ),
        )),
      ) as _i4.Future<_i2.WeatherConditionResponse>);

  @override
  String toJsonString(_i5.WeatherRequest? weatherRequest) =>
      (super.noSuchMethod(
        Invocation.method(
          #toJsonString,
          [weatherRequest],
        ),
        returnValue: _i6.dummyValue<String>(
          this,
          Invocation.method(
            #toJsonString,
            [weatherRequest],
          ),
        ),
        returnValueForMissingStub: _i6.dummyValue<String>(
          this,
          Invocation.method(
            #toJsonString,
            [weatherRequest],
          ),
        ),
      ) as String);

  @override
  Map<String, dynamic> toMap(String? weatherDataOfJson) => (super.noSuchMethod(
        Invocation.method(
          #toMap,
          [weatherDataOfJson],
        ),
        returnValue: <String, dynamic>{},
        returnValueForMissingStub: <String, dynamic>{},
      ) as Map<String, dynamic>);
}