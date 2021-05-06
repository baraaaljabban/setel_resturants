import 'dart:convert';

import 'package:setel/core/Strings/cash_strings.dart';
import 'package:setel/error/exceptions.dart';
import 'package:setel/error/failuer_string.dart';
import 'package:setel/features/restaurant/data/model/restorant_response.dart';
import 'package:setel/features/restaurant/domain/entities/restaurant.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class RestaurantLocalDataSource {
  void cashRestornat(RestaurantResponse restorants);
  List<Restaurant> getRestornat();
}

class RestaurantLocalDataSourceImpl extends RestaurantLocalDataSource {
  final SharedPreferences sharedPreferences;
  RestaurantLocalDataSourceImpl({
    this.sharedPreferences,
  });

  /// return a [List<Restaurant>] from sharedPreferences
  @override
  List<Restaurant> getRestornat() {
    //TODO: Change it to SqlLite to big for a string to be saved
    var s = sharedPreferences.getString(
      CASHED_RESTAURANT,
    );

    RestaurantResponse restaurantResponse =
        RestaurantResponse.fromJson(json.decode(s));
    if (restaurantResponse == null ||
        restaurantResponse.restaurants.length == 0)
      throw CacheException(
        message: CASH_ERROR,
      );
    else
      return restaurantResponse.restaurants;
  }

  /// will take [restorants] and save it in sharedPreferences
  /// as String
  /// this is a first soluation to be changed
  @override
  void cashRestornat(RestaurantResponse response) {
    sharedPreferences.setString(
      CASHED_RESTAURANT,
      json.encode(response),
    );
  }
}
