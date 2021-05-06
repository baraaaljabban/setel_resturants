part of 'restaurant_bloc.dart';

@immutable
abstract class RestaurantState {}

class RestaurantInitial extends RestaurantState {}

class Loading extends RestaurantState {}

class Error extends RestaurantState {
  final String message;
  Error({this.message});
}

class RestaurantListLoaded extends RestaurantState {
  final List<Restaurant> restaurant;
  RestaurantListLoaded({this.restaurant});
}

class ShowRestaurantWorkingHours extends RestaurantState {
  final List<WorkingDay> workindDays;

  ShowRestaurantWorkingHours({this.workindDays});
}
