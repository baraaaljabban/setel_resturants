import 'package:setel/core/app_utils.dart';
import 'package:setel/features/restaurant/domain/entities/restaurant.dart';

part 'restaurant_model.g.dart';

class RestaurantModel extends Restaurant {
  final String name;
  final String operatingHours;

  RestaurantModel({
    this.name,
    this.operatingHours,
  }) : super(
          restaurantName: name,
          workindDays: fillWirkingDaysWithHours(
            operatingHours: operatingHours,
          ),
        );
  factory RestaurantModel.fromJson(Map<String, dynamic> json) =>
      _$RestaurantModelFromJson(json);

  Map<String, dynamic> toJson() => _$RestaurantModelToJson(this);
}
