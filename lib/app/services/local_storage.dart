import 'package:get_storage/get_storage.dart';

abstract class LocalStorageProcess {
  Future<void> setData(String key, dynamic value);
  Future<int>? getInt(String key);
  Future<String>? getString(String key);
  Future<bool>? getBool(String key);
  Future<double>? getDouble(String key);
  Future<dynamic> getData(String key);
  Future<void> clearData();
}

class GetStorageLib extends LocalStorageProcess {
  @override
  Future<void> clearData() async {
    return await GetStorage().erase();
  }

  @override
  Future<bool>? getBool(String key) async {
    return await GetStorage().read(key);
  }

  @override
  Future<dynamic> getData(String key) async {
    return await GetStorage().read(key);
  }

  @override
  Future<double>? getDouble(String key) async {
    return await GetStorage().read(key);
  }

  @override
  Future<int>? getInt(String key) async {
    return await GetStorage().read(key);
  }

  @override
  Future<String>? getString(String key) async {
    return await GetStorage().read(key);
  }

  @override
  Future<void> setData(String key, dynamic value) async {
    return await GetStorage().write(key, value);
  }
}
