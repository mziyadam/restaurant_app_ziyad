import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:http/http.dart' as http;

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_app/model/customer_reviews.dart';
import 'package:restaurant_app/model/restaurants_list.dart';
import 'package:restaurant_app/provider/loader.dart';
import 'package:restaurant_app/view/detail.dart';
import 'package:restaurant_app/view/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Notif {
  List<String> name = [];
  List<String> description = [];
  List<String> pictureId = [];
  List<String> city = [];
  List<double> rating = [];
  int restaurantSize = 0;
  List<List<String>> foodLists = [];
  List<List<String>> drinkLists = [];
  List<List<CustomerReviews>> customerReviewsList = [];

  Future<Widget> loadData() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('connected');
      } else {
        print('error');
      }

      var jsonString = await http.get(Uri.parse(
          'https://gist.githubusercontent.com/mziyadam/d99e2d5c5aab97878b0c6613f884ed97/raw/d05f64cd0571f24702d68f6fa94985f1766575cf/restaurant.json'));

      if (jsonString.statusCode == 200) {
        final jsonData = json.decode(jsonString.body);
        var restaurantsList = RestaurantsList.fromJson(jsonData);

        restaurantSize = restaurantsList.restaurants.length;
        for (var i = 0; i < restaurantSize; i++) {
          var foods = <String>[];
          var drinks = <String>[];
          var foodsize = restaurantsList.restaurants[i].menus.foods.length;
          var drinksize = restaurantsList.restaurants[i].menus.drinks.length;

          name.add(restaurantsList.restaurants[i].name);
          description.add(restaurantsList.restaurants[i].description);
          city.add(restaurantsList.restaurants[i].city);
          rating.add(restaurantsList.restaurants[i].rating);
          pictureId.add(restaurantsList.restaurants[i].pictureId);
          customerReviewsList
              .add(restaurantsList.restaurants[i].customerReviews);
          for (var j = 0; j < foodsize; j++) {
            foods.add(restaurantsList.restaurants[i].menus.foods[j].name);
          }
          foodLists.add(foods);
          for (var j = 0; j < drinksize; j++) {
            drinks.add(restaurantsList.restaurants[i].menus.drinks[j].name);
          }
          drinkLists.add(drinks);
        }
      } else {
        print(jsonString.statusCode);
        print('error');
      }
      return Future.value(HomePage(name, description, pictureId, city, rating,
          restaurantSize, foodLists, drinkLists, customerReviewsList));
    } catch (error) {
      print(error);
    }
    ;
  }
}
