import '../../exports.dart';

abstract class LocalStorageProcess {
  Future<void> setData(String key, dynamic value);
  Future<int>? getInt(String key);
  Future<String>? getString(String key);
  Future<bool>? getBool(String key);
  Future<double>? getDouble(String key);
  Future<dynamic> getDynamicData(String key);
  Future<void> clearAllData();
  Future<void> removeData(String key);
}

class GetStorageLib extends LocalStorageProcess {
  GetStorage getStorage = Get.find<GetStorage>();
  @override
  Future<void> clearAllData() async {
    return await getStorage.erase();
  }

  @override
  Future<bool>? getBool(String key) async {
    return await getStorage.read(key);
  }

  @override
  Future<dynamic> getDynamicData(String key) async {
    return await getStorage.read(key);
  }

  @override
  Future<double>? getDouble(String key) async {
    return await getStorage.read(key);
  }

  @override
  Future<int>? getInt(String key) async {
    return await getStorage.read(key);
  }

  @override
  Future<String>? getString(String key) async {
    var val = await getStorage.read(key);
    if (val != null) {
      return val;
    }
    return '';
  }

  @override
  Future<void> setData(String key, dynamic value) async {
    return await getStorage.write(key, value);
  }

  @override
  Future<void> removeData(String key) async {
    return await getStorage.remove(key);
  }
}
