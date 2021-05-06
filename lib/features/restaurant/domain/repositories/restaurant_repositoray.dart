import 'package:dartz/dartz.dart';
import 'package:setel/error/failures.dart';
import 'package:setel/features/restaurant/domain/entities/restaurant.dart';

abstract class RestaurantRepository {
  Future<Either<Failure, List<Restaurant>>> getRestaurant();
}
