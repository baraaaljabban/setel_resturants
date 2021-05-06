import 'package:connectivity/connectivity.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:setel/Network/network.dart';
import 'package:http/http.dart' as http;
import 'package:setel/features/restaurant/data/datasource/data_source.dart';
import 'package:setel/features/restaurant/data/repository/restaurant_impl.dart';
import 'package:setel/features/restaurant/domain/repositories/restaurant_repositoray.dart';
import 'package:setel/features/restaurant/domain/usecases/restaurant_uc.dart';
import 'package:setel/features/restaurant/presentation/bloc/restaurant_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerFactory(() => DataConnectionChecker());
  sl.registerFactory(() => Connectivity());

  sl.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(
      connectivity: sl(),
      dataConnectionChecker: sl(),
    ),
  );
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);

  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => MHttpClient(client: sl()));

  /// register Restaurant Bloc and all other Depindicis
  sl.registerLazySingleton<RestaurantReomtDataSource>(
      () => RestaurantReomtDataSourceImpl(client: sl()));
  sl.registerLazySingleton<RestaurantLocalDataSource>(
      () => RestaurantLocalDataSourceImpl(sharedPreferences: sl()));
  sl.registerLazySingleton<RestaurantRepository>(() => RestaurantRepositoryImpl(
        localDataSource: sl(),
        reomtDataSource: sl(),
        networkInfo: sl(),
      ));
  sl.registerFactory(() => RestaurantUC(restaurantRepository: sl()));
  sl.registerFactory(() => RestaurantBloc(restaurantUC: sl()));
}
