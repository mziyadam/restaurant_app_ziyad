import 'package:flutter/material.dart';
import 'package:restaurant_app/view/detail.dart';
import 'package:restaurant_app/style/styles.dart';

class MenuSearchDelegate extends SearchDelegate {
  DetailPage data;

  MenuSearchDelegate(this.data);

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
    var indexedf = <int, int>{};
    var indexedd = <int, int>{};
    var j = 0, k = 0;
    for (var i = 0; i < (data.foodsize); i++) {
      if (data.foods[i].toLowerCase().contains(query.toLowerCase())) {
        indexedf[j] = i;
        j++;
      }
    }
    for (var i = 0; i < (data.drinksize); i++) {
      if (data.drinks[i].toLowerCase().contains(query.toLowerCase())) {
        indexedd[k] = i;
        k++;
      }
    }
    if (indexedd.isEmpty && indexedf.isEmpty) {
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
      return SingleChildScrollView(
        child: Column(
          children: [
            ListView.builder(
                padding: EdgeInsets.all(8),
                itemCount: indexedf.length,
                shrinkWrap: true,
                physics: ScrollPhysics(),
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Icon(Icons.fastfood_outlined),
                    title: Text(data.foods[indexedf[index]]),
                  );
                }),
            ListView.builder(
                padding: EdgeInsets.all(8),
                itemCount: indexedd.length,
                shrinkWrap: true,
                physics: ScrollPhysics(),
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Icon(Icons.emoji_food_beverage_outlined),
                    title: Text(data.drinks[indexedd[index]]),
                  );
                }),
          ],
        ),
      );
    }
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    var indexedf = <int, int>{};
    var indexedd = <int, int>{};
    var j = 0, k = 0;
    for (var i = 0; i < (data.foodsize); i++) {
      if (data.foods[i].toLowerCase().contains(query.toLowerCase())) {
        indexedf[j] = i;
        j++;
      }
    }
    for (var i = 0; i < (data.drinksize); i++) {
      if (data.drinks[i].toLowerCase().contains(query.toLowerCase())) {
        indexedd[k] = i;
        k++;
      }
    }
    if (query.isNotEmpty) {
      return SingleChildScrollView(
        child: Column(
          children: [
            ListView.builder(
                itemCount: indexedf.length,
                itemBuilder: (content, index) => ListTile(
                      onTap: () {
                        query = data.foods[indexedf[index]];
                        showResults(context);
                      },
                      title: Text(data.foods[indexedf[index]]),
                    )),
            ListView.builder(
                itemCount: indexedd.length,
                itemBuilder: (content, index) => ListTile(
                      onTap: () {
                        query = data.drinks[indexedd[index]];
                        showResults(context);
                      },
                      title: Text(data.drinks[indexedd[index]]),
                    )),
          ],
        ),
      );
    } else {
      return Column();
    }
  }
}
