// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint

part of 'weather_notifier_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$weatherNotifierHash() => r'7ffba976a135f5784d55e15fd1eadd4ce420b7d4';

/// See also [WeatherNotifier].
@ProviderFor(WeatherNotifier)
final weatherNotifierProvider =
    AutoDisposeAsyncNotifierProvider<WeatherNotifier, WeatherResponse>.internal(
  WeatherNotifier.new,
  name: r'weatherNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$weatherNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$WeatherNotifier = AutoDisposeAsyncNotifier<WeatherResponse>;
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
