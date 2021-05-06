import 'package:json_annotation/json_annotation.dart';
import 'package:setel/Network/response.dart';
import 'package:setel/features/restaurant/data/model/restaurant_model.dart';

part 'restorant_response.g.dart';

@JsonSerializable()
class RestaurantResponse extends Response {
  final int timestamp;
  final List<RestaurantModel> restaurants;

  RestaurantResponse({
    this.timestamp,
    this.restaurants,
  });
  factory RestaurantResponse.fromJson(Map<String, dynamic> json) =>
      _$RestaurantResponseFromJson(json);

  Map<String, dynamic> toJson() => _$RestaurantResponseToJson(this);
}
