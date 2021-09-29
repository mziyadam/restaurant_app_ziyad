import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/view/favourite.dart';
import 'package:restaurant_app/model/customer_reviews.dart';
import 'package:restaurant_app/provider/favourite_restaurants_provider.dart';
import 'package:restaurant_app/view/setting.dart';
import 'package:restaurant_app/widgets/custom_inkwell.dart';
import 'package:restaurant_app/widgets/search_restaurant.dart';
import 'dart:math';
import 'detail.dart';

class HomePage extends StatefulWidget {
  int restaurantSize;
  List<String> name;
  List<String> description;
  List<String> pictureId;
  List<String> city;
  List<double> rating;
  List<List<String>> foodLists;
  List<List<String>> drinkLists;
  List<List<CustomerReviews>> customerReviewsList;

  HomePage(
      this.name,
      this.description,
      this.pictureId,
      this.city,
      this.rating,
      this.restaurantSize,
      this.foodLists,
      this.drinkLists,
      this.customerReviewsList);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Random random = Random();
  int rId;

  @override
  Widget build(BuildContext context) {
    rId = random.nextInt(widget.restaurantSize);

    AwesomeNotifications().initialize('resource://drawable/app_icon', [
      NotificationChannel(
          channelKey: 'basic_channel',
          channelName: 'Restaurant notifications',
          channelDescription: 'Restaurant notification channel',
          defaultColor: Color(0xFF9D50DD),
          ledColor: Colors.white)
    ]);
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });
    AwesomeNotifications().actionStream.listen((receivedNotification) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => DetailPage(
                name: widget.name[rId],
                description: widget.description[rId],
                pictureId: widget.pictureId[rId],
                city: widget.city[rId],
                rating: widget.rating[rId],
                foods: widget.foodLists[rId],
                drinks: widget.drinkLists[rId],
                foodsize: widget.foodLists[rId].length,
                drinksize: widget.drinkLists[rId].length,
                customerReviews: widget.customerReviewsList[rId],
                id: rId,
              )));
    });
    return SafeArea(
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (context, isScrolled) {
            return [
              SliverAppBar(
                pinned: true,
                expandedHeight: 200.0,
                automaticallyImplyLeading: false,
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  title: Text(
                    'Top Restaurant',
                    style: Theme.of(context)
                        .textTheme
                        .headline6
                        .apply(color: Colors.white, fontSizeDelta: 4),
                  ),
                  background: Image.asset(
                    'assets/restaurant_bg.jpg',
                    fit: BoxFit.fitWidth,
                  ),
                ),
                leading: IconButton(
                  icon: Icon(
                    Icons.favorite,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => FavouriteList(widget)));
                  },
                ),
                actions: [
                  IconButton(
                    icon: Icon(
                      Icons.search_outlined,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      showSearch(
                        context: context,
                        delegate: RestaurantSearchDelegate(widget),
                      );
                    },
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.settings_outlined,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Setting()));
                    },
                  ),
                ],
              ),
            ];
          },
          body: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
            if (widget.restaurantSize != 0) {
              return SafeArea(
                child: ListView.builder(
                    itemCount: widget.restaurantSize,
                    itemBuilder: (context, index) {
                      return Consumer<FavouriteRestaurantsProvider>(
                        builder: (context, FavouriteRestaurantsProvider data,
                            widgetz) {
                          return CustomInkwell(
                              widget.name[index],
                              widget.description[index],
                              widget.pictureId[index],
                              widget.city[index],
                              widget.rating[index],
                              widget.foodLists[index],
                              widget.drinkLists[index],
                              widget.foodLists[index].length,
                              widget.drinkLists[index].length,
                              data.favouriteRestaurantsList
                                  .contains(widget.name[index]),
                              () => {
                                    data.favouriteRestaurantsList
                                            .contains(widget.name[index])
                                        ? data.unlike(index, widget.name[index])
                                        : data.liked(index, widget.name[index])
                                  },
                              widget.customerReviewsList[index],
                              index);
                        },
                      );
                    }),
              );
            } else {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.not_listed_location_outlined,
                      size: 70,
                    ),
                    Text(
                      'Not Connected to Internet!',
                      style: Theme.of(context).textTheme.headline6,
                    )
                  ],
                ),
              );
            }
          }),
        ),
      ),
    );
  }
}
