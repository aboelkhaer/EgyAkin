import 'package:get_it/get_it.dart';

import '../../../exports.dart';

extension ServiceLocatorExtensions on GetIt {
  void resetLazySingleton<T extends Cubit>(T Function() factoryFn) {
    if (isRegistered<T>()) {
      final cubit = get<T>();
      unregister<T>();
      if (!cubit.isClosed) {
        cubit.close();
      }
    }
    registerLazySingleton<T>(factoryFn);
  }
}
