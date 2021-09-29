import 'package:restaurant_app/model/customer_reviews.dart';
import 'package:restaurant_app/model/menus.dart';

class Restaurants {
  String id;
  String name;
  String description;
  String pictureId;
  String city;
  double rating;
  Menus menus;
  List<CustomerReviews> customerReviews;

  Restaurants(
      {this.id,
      this.name,
      this.description,
      this.pictureId,
      this.city,
      this.rating,
      this.menus,
      this.customerReviews});

  Restaurants.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    pictureId = json['pictureId'];
    city = json['city'];
    rating = json['rating'].toDouble();
    menus = json['menus'] != null ? Menus.fromJson(json['menus']) : null;
    if (json['customerReviews'] != null) {
      customerReviews = <CustomerReviews>[];
      json['customerReviews'].forEach((v) {
        customerReviews.add(CustomerReviews.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['pictureId'] = pictureId;
    data['city'] = city;
    data['rating'] = rating;
    if (menus != null) {
      data['menus'] = menus.toJson();
    }
    if (customerReviews != null) {
      data['customerReviews'] = customerReviews.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
