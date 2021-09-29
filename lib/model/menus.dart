import 'package:restaurant_app/model/drinks.dart';
import 'package:restaurant_app/model/foods.dart';

class Menus {
  List<Foods> foods;
  List<Drinks> drinks;

  Menus({this.foods, this.drinks});

  Menus.fromJson(Map<String, dynamic> json) {
    if (json['foods'] != null) {
      foods = <Foods>[];
      json['foods'].forEach((v) {
        foods.add(Foods.fromJson(v));
      });
    }
    if (json['drinks'] != null) {
      drinks = <Drinks>[];
      json['drinks'].forEach((v) {
        drinks.add(Drinks.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (foods != null) {
      data['foods'] = foods.map((v) => v.toJson()).toList();
    }
    if (drinks != null) {
      data['drinks'] = drinks.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
