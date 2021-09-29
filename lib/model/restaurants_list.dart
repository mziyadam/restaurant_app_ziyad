import 'package:restaurant_app/model/restaurants.dart';

class RestaurantsList {
  List<Restaurants> restaurants;

  RestaurantsList({this.restaurants});

  RestaurantsList.fromJson(Map<String, dynamic> json) {
    if (json['restaurants'] != null) {
      restaurants = <Restaurants>[];
      json['restaurants'].forEach((v) {
        restaurants.add(Restaurants.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (restaurants != null) {
      data['restaurants'] = restaurants.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
