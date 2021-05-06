// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'restorant_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RestaurantResponse _$RestaurantResponseFromJson(Map<String, dynamic> json) {
  return RestaurantResponse(
    timestamp: json['timestamp'] as int,
    restaurants: (json['restaurants'] as List)
        ?.map((e) => e == null
            ? null
            : RestaurantModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$RestaurantResponseToJson(RestaurantResponse instance) =>
    <String, dynamic>{
      'timestamp': instance.timestamp,
      'restaurants': instance.restaurants,
    };
