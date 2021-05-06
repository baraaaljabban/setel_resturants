import 'package:dartz/dartz.dart';
import 'package:setel/Network/network.dart';
import 'package:setel/core/app_utils.dart';
import 'package:setel/error/exceptions.dart';
import 'package:setel/error/failuer_string.dart';
import 'package:setel/error/failures.dart';
import 'package:setel/features/restaurant/data/datasource/data_source.dart';
import 'package:setel/features/restaurant/domain/entities/restaurant.dart';
import 'package:setel/features/restaurant/domain/repositories/restaurant_repositoray.dart';

class RestaurantRepositoryImpl extends RestaurantRepository {
  final RestaurantLocalDataSource localDataSource;
  final RestaurantReomtDataSource reomtDataSource;
  final NetworkInfo networkInfo;

  RestaurantRepositoryImpl({
    this.localDataSource,
    this.reomtDataSource,
    this.networkInfo,
  });

  ///function will return [Either] [Failure] or [List<Restaurant>]
  ///the flow of the function : first will call the `"remot"` datasource if there is an
  ///internt connection otherwise will call it from `"locale"` and if it failed will
  ///return [CacheException]
  ///if there was no internt will try to call it from `"locale"`data source
  ///else will return `"InternetConnectionFailure"` the reaseon here to to return
  /// `"CacheException"` is because user shoud be notified that he/she has no
  /// internt access
  @override
  Future<Either<Failure, List<Restaurant>>> getRestaurant() async {
    //check if there is an internt conniction and call remot data source
    if (await networkInfo.isconnected && await networkInfo.hassconnectivity) {
      try {
        final remote = await reomtDataSource.getRestornat();
        localDataSource.cashRestornat(remote);
        List<Restaurant> rests = List<Restaurant>();
        remote.restaurants.forEach((element) {
          rests.add(
            Restaurant(
              restaurantName: element.name,
              workindDays: element.workindDays,
              isOpen: isRestaurantNowOppend(
                workingDays: element.workindDays,
              ),
            ),
          );
        });
        return Right(rests);
      } on UnExpectedServerResponseException catch (_) {
        /** it could show only ServerFailure and we are done but I decided to give it last shoot
         * on this Exception I decided that I want to try to get the info even
         * there was failuer from server side
        */

        // calling remot failed for any kind of reason
        // try to call localDataSource
        try {
          final locale = localDataSource.getRestornat();
          return Right(locale);
          //error happend when
        } on CacheException catch (e) {
          return Left(
            CacheFailure(
              message: e != null ? e.message : CASH_ERROR,
            ),
          );
        }
      } catch (serverErro) {
        return Left(ServerFailure(message: SERVER_ERROR));
      }
    } else {
      try {
        final locale = localDataSource.getRestornat();
        return Right(locale);
      } on CacheException catch (e) {
        return Left(
          CacheFailure(
            message: e != null ? e.message : CASH_ERROR,
          ),
        );
      } catch (exp) {
        return Left(
          InternetConnectionFailure(
            message: NO_INTERNET,
          ),
        );
      }
    }
  }
}
