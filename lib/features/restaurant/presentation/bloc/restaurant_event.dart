part of 'restaurant_bloc.dart';

@immutable
abstract class RestaurantEvent {}

class ShowOpperatingHoursEvent extends RestaurantEvent {
  final Restaurant restaurant;

  ShowOpperatingHoursEvent({this.restaurant});
}

class GetRestaurants extends RestaurantEvent {}

class GoToRasturanetsListEvent extends RestaurantEvent {}