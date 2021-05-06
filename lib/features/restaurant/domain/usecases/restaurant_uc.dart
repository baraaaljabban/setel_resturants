import 'package:dartz/dartz.dart';
import 'package:setel/core/use_cases.dart';
import 'package:setel/error/failures.dart';
import 'package:setel/features/restaurant/domain/entities/restaurant.dart';
import 'package:setel/features/restaurant/domain/repositories/restaurant_repositoray.dart';

class RestaurantUC extends UseCaseNoParams<List<Restaurant>> {
  final RestaurantRepository restaurantRepository;

  RestaurantUC({
    this.restaurantRepository,
  });

  @override
  Future<Either<Failure, List<Restaurant>>> call() async{
   return await restaurantRepository.getRestaurant();
  }
}
