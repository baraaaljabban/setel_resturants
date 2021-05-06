import 'package:setel/Network/network.dart';
import 'package:setel/error/exceptions.dart';
import 'package:setel/features/restaurant/data/model/restorant_response.dart';

abstract class RestaurantReomtDataSource {
  Future<RestaurantResponse> getRestornat();
}

class RestaurantReomtDataSourceImpl extends RestaurantReomtDataSource {
  final MHttpClient client;

  RestaurantReomtDataSourceImpl({
    this.client,
  });

  String restaurantPath = "/homework/";

  @override
  Future<RestaurantResponse> getRestornat() async {
    final response = await client.get(
      path: restaurantPath,
    );
    if (response.statusCode == RESPONSE_SUCCESS_CODE) {
      return RestaurantResponse.fromJson(json.decode(response.body));
    } else {
      throw UnExpectedServerResponseException(
        message: response.reasonPhrase,
      );
    }
  }
}
