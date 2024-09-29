// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, duplicate_ignore

part of 'weather_notifier_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$weatherNotifierHash() => r'b0bbdaedc8b6799828d6d6ac486e7ae4a28a219d';

/// See also [WeatherNotifier].
@ProviderFor(WeatherNotifier)
final weatherNotifierProvider = AutoDisposeAsyncNotifierProvider<
    WeatherNotifier, WeatherConditionResponse>.internal(
  WeatherNotifier.new,
  name: r'weatherNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$weatherNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$WeatherNotifier = AutoDisposeAsyncNotifier<WeatherConditionResponse>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
