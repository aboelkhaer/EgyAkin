import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import 'app/api_services/api_services.dart';
import 'app/services/dio_factory.dart';
import 'features/auth/controller/repo.dart';

GetIt sl = GetIt.instance;

Future<void> setupLocator() async {
  initNetworking();
  sl.registerLazySingleton(() => AuthRepository(apiServices: sl()));
}

initNetworking() async {
  // dio factory
  sl.registerLazySingleton<DioFactory>(() => DioFactory());
  Dio dio = await sl<DioFactory>().getDio();
  //app service client
  //? NETWORK SERVICE
  sl.registerLazySingleton<ApiServices>(() => ApiServices(dio));
}
