// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'restaurant_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RestaurantModel _$RestaurantModelFromJson(Map<String, dynamic> json) {
  return RestaurantModel(
    name: json['name'] as String,
    operatingHours: json['operatingHours'] as String,
  );
}

Map<String, dynamic> _$RestaurantModelToJson(RestaurantModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'operatingHours': instance.operatingHours,
    };
