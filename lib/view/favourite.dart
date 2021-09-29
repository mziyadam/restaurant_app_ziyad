import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/view/home.dart';
import 'package:restaurant_app/provider/favourite_restaurants_provider.dart';
import 'package:restaurant_app/widgets/custom_inkwell.dart';

class FavouriteList extends StatelessWidget {
  final HomePage datas;

  FavouriteList(this.datas);

  @override
  Widget build(BuildContext context) {
    final favouriteList =
        Provider.of<FavouriteRestaurantsProvider>(context, listen: false)
            .favouriteRestaurantsList;
    final favouriteListIndex =
        Provider.of<FavouriteRestaurantsProvider>(context, listen: false).index;

    return Scaffold(
      appBar: AppBar(
        title: Text('My Favourite Restaurants'),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return Consumer<FavouriteRestaurantsProvider>(
            builder: (context, FavouriteRestaurantsProvider data, widget) {
              try {
                return CustomInkwell(
                    datas.name[favouriteListIndex[index]],
                    datas.description[favouriteListIndex[index]],
                    datas.pictureId[favouriteListIndex[index]],
                    datas.city[favouriteListIndex[index]],
                    datas.rating[favouriteListIndex[index]],
                    datas.foodLists[favouriteListIndex[index]],
                    datas.drinkLists[favouriteListIndex[index]],
                    datas.foodLists[favouriteListIndex[index]].length,
                    datas.drinkLists[favouriteListIndex[index]].length,
                    data.favouriteRestaurantsList
                        .contains(datas.name[favouriteListIndex[index]]),
                    () => {
                          data.favouriteRestaurantsList.contains(
                                  datas.name[favouriteListIndex[index]])
                              ? data.unlike(
                                  favouriteListIndex[index],
                                  datas.name[favouriteListIndex[index]],
                                )
                              : data.liked(favouriteListIndex[index],
                                  datas.name[favouriteListIndex[index]])
                        },
                    datas.customerReviewsList[favouriteListIndex[index]],
                    favouriteListIndex[index]);
              } catch (e) {
                return Column(
                  children: [],
                );
              }
            },
          );
        },
        itemCount: favouriteList.length,
      ),
    );
  }
}
