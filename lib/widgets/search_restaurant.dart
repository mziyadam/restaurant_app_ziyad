import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/view/home.dart';
import 'package:restaurant_app/provider/favourite_restaurants_provider.dart';
import 'package:restaurant_app/style/styles.dart';
import 'package:restaurant_app/widgets/custom_inkwell.dart';

class RestaurantSearchDelegate extends SearchDelegate {
  HomePage data;

  RestaurantSearchDelegate(this.data);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(
          Icons.clear_outlined,
          color: primaryColor,
        ),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.arrow_back_outlined,
        color: primaryColor,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    var indexed = <int, int>{};
    var j = 0;
    for (var i = 0; i < data.restaurantSize; i++) {
      if (data.name[i].toLowerCase().contains(query.toLowerCase())) {
        indexed[j] = i;
        j++;
      }
    }
    if (indexed.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.not_listed_location_outlined,
              size: 70,
            ),
            Text(
              'Not Found',
              style: Theme.of(context).textTheme.headline6,
            )
          ],
        ),
      );
    } else {
      return ListView.builder(
          itemCount: indexed.length,
          itemBuilder: (context, index) {
            return Consumer<FavouriteRestaurantsProvider>(
                builder: (context, FavouriteRestaurantsProvider datap, widget) {
              return CustomInkwell(
                  data.name[indexed[index]],
                  data.description[indexed[index]],
                  data.pictureId[indexed[index]],
                  data.city[indexed[index]],
                  data.rating[indexed[index]],
                  data.foodLists[indexed[index]],
                  data.drinkLists[indexed[index]],
                  data.foodLists[indexed[index]].length,
                  data.drinkLists[indexed[index]].length,
                  datap.favouriteRestaurantsList
                      .contains(data.name[indexed[index]]),
                  () => {
                        datap.favouriteRestaurantsList
                                .contains(data.name[indexed[index]])
                            ? datap.unlike(
                                indexed[index], data.name[indexed[index]])
                            : datap.liked(
                                indexed[index], data.name[indexed[index]])
                      },
                  data.customerReviewsList[indexed[index]],
                  indexed[index]);
            });
          });
    }
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    var indexed = <int, int>{};
    var j = 0;
    for (var i = 0; i < data.restaurantSize; i++) {
      if (data.name[i].toLowerCase().contains(query.toLowerCase())) {
        indexed[j] = i;
        j++;
      }
    }
    if (query.isNotEmpty) {
      return ListView.builder(
          itemCount: indexed.length,
          itemBuilder: (content, index) => ListTile(
                onTap: () {
                  query = data.name[indexed[index]];
                  showResults(context);
                },
                title: Text(data.name[indexed[index]]),
              ));
    } else {
      return Column();
    }
  }
}
