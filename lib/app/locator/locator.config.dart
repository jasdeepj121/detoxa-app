// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i7;

import '../../services/auth/auth_service.dart' as _i3;
import '../../services/navigation/navigation_service.dart' as _i5;
import '../../services/network/config.dart' as _i6;
import '../../services/storage/device_storage_service.dart' as _i4;
import '../../services/tracker/tracker_service.dart'
    as _i8; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
Future<_i1.GetIt> $initGetIt(_i1.GetIt get,
    {String environment, _i2.EnvironmentFilter environmentFilter}) async {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final deviceStorageServiceAbstract = _$DeviceStorageServiceAbstract();
  gh.lazySingleton<_i3.AuthService>(() => _i3.AuthService());
  gh.lazySingleton<_i4.DeviceStorage>(() => _i4.DeviceStorage());
  gh.lazySingleton<_i5.NavigationService>(() => _i5.NavigationService());
  gh.lazySingleton<_i6.NetworkService>(() => _i6.NetworkService());
  await gh.factoryAsync<_i7.SharedPreferences>(
      () => deviceStorageServiceAbstract.preferences,
      preResolve: true);
  gh.lazySingleton<_i8.TrackerService>(() => _i8.TrackerService());
  return get;
}

class _$DeviceStorageServiceAbstract extends _i4.DeviceStorageServiceAbstract {}
