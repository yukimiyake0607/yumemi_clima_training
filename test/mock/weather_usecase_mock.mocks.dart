// Mocks generated by Mockito 5.4.4 from annotations
// in flutter_training/test/mock/weather_usecase_mock.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i5;

import 'package:flutter_training/data/repository/weather_repository.dart'
    as _i2;
import 'package:flutter_training/data/usecase/weather_usecase.dart' as _i4;
import 'package:flutter_training/models/response/weather_condition_response.dart'
    as _i6;
import 'package:flutter_training/models/result/result.dart' as _i3;
import 'package:flutter_training/models/weather_request.dart' as _i8;
import 'package:mockito/mockito.dart' as _i1;
import 'package:yumemi_weather/yumemi_weather.dart' as _i7;

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

class _FakeWeatherRepository_0 extends _i1.SmartFake
    implements _i2.WeatherRepository {
  _FakeWeatherRepository_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeResult_1<T, E> extends _i1.SmartFake implements _i3.Result<T, E> {
  _FakeResult_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [WeatherUsecase].
///
/// See the documentation for Mockito's code generation for more information.
class MockWeatherUsecase extends _i1.Mock implements _i4.WeatherUsecase {
  @override
  _i2.WeatherRepository get weatherRepository => (super.noSuchMethod(
        Invocation.getter(#weatherRepository),
        returnValue: _FakeWeatherRepository_0(
          this,
          Invocation.getter(#weatherRepository),
        ),
        returnValueForMissingStub: _FakeWeatherRepository_0(
          this,
          Invocation.getter(#weatherRepository),
        ),
      ) as _i2.WeatherRepository);

  @override
  _i5.Future<
      _i3.Result<_i6.WeatherResponse, _i7.YumemiWeatherError>> getWeather(
          _i8.WeatherRequest? request) =>
      (super.noSuchMethod(
        Invocation.method(
          #getWeather,
          [request],
        ),
        returnValue: _i5.Future<
                _i3.Result<_i6.WeatherResponse, _i7.YumemiWeatherError>>.value(
            _FakeResult_1<_i6.WeatherResponse, _i7.YumemiWeatherError>(
          this,
          Invocation.method(
            #getWeather,
            [request],
          ),
        )),
        returnValueForMissingStub: _i5.Future<
                _i3.Result<_i6.WeatherResponse, _i7.YumemiWeatherError>>.value(
            _FakeResult_1<_i6.WeatherResponse, _i7.YumemiWeatherError>(
          this,
          Invocation.method(
            #getWeather,
            [request],
          ),
        )),
      ) as _i5.Future<_i3.Result<_i6.WeatherResponse, _i7.YumemiWeatherError>>);
}
