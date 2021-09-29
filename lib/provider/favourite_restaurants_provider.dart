import 'package:flutter/foundation.dart';
import 'package:restaurant_app/provider/db_helper.dart';

class FavouriteRestaurantsProvider extends ChangeNotifier {
  DatabaseHelper _dbHelper;
  List<String> _favouriteRestaurantsList = [];
  List<int> _index = [];
  Map<int, String> _myreview = {};
  Map<int, String> _myreviewdate = {};

  FavouriteRestaurantsProvider() {
    _dbHelper = DatabaseHelper();
    _getAllData();
  }

  void _getAllData() async {
    try {
      _favouriteRestaurantsList = await _dbHelper.getFavs();
      _index = await _dbHelper.getId();
      _myreview = await _dbHelper.getReview();
      _myreviewdate = await _dbHelper.getReviewDate();
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Map<int, String> get myreview {
    return _myreview;
  }

  Map<int, String> get myreviewdate {
    return _myreviewdate;
  }

  List<String> get favouriteRestaurantsList {
    return _favouriteRestaurantsList;
  }

  List<int> get index {
    return _index;
  }

  Future<void> review(int index, String text, String reviewDate) async {
    try {
      await _dbHelper.insertReview(index, text);
      await _dbHelper.insertReviewDate(index, reviewDate);
      _getAllData();
    } catch (e) {
      print(e);
      await _dbHelper.updateReview(index, text);
      await _dbHelper.updateReviewDate(index, reviewDate);
      _getAllData();
    }
  }

  Future<void> liked(int index, String restaurantsName) async {
    try {
      await _dbHelper.insertFavs(restaurantsName);
      await _dbHelper.insertId(index);
      _getAllData();
    } catch (e) {
      print(e);
    }
  }

  Future<void> unlike(int index, String restaurantsName) async {
    try {
      await _dbHelper.deleteFavs(restaurantsName);
      await _dbHelper.deleteId(index);
      _getAllData();
    } catch (e) {
      print(e);
    }
  }
}
