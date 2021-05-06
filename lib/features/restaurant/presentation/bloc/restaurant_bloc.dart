import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:setel/features/restaurant/domain/entities/restaurant.dart';
import 'package:setel/features/restaurant/domain/entities/working_days.dart';
import 'package:setel/features/restaurant/domain/usecases/restaurant_uc.dart';

part 'restaurant_event.dart';
part 'restaurant_state.dart';

class RestaurantBloc extends Bloc<RestaurantEvent, RestaurantState> {
  final RestaurantUC restaurantUC;
  RestaurantBloc({
    this.restaurantUC,
  }) : super(RestaurantInitial());
  List<Restaurant> restaurants;
  @override
  Stream<RestaurantState> mapEventToState(
    RestaurantEvent event,
  ) async* {
    if (event is GetRestaurants) {
      yield Loading();
      final result = await restaurantUC();
      yield result.fold((l) => Error(message: l.message), (r) {
        restaurants = r;
        return RestaurantListLoaded(restaurant: r);
      });
    } else if (event is ShowOpperatingHoursEvent) {
      yield ShowRestaurantWorkingHours(
        workindDays: event.restaurant.workindDays,
      );
    } else if (event is GoToRasturanetsListEvent)
      yield RestaurantListLoaded(
        restaurant: restaurants,
      );
  }
}
