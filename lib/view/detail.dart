import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/model/customer_reviews.dart';
import 'package:restaurant_app/provider/favourite_restaurants_provider.dart';
import 'package:restaurant_app/style/styles.dart';
import 'package:restaurant_app/widgets/rating_stars.dart';
import 'package:restaurant_app/widgets/search_menu.dart';

class DetailPage extends StatefulWidget {
  String name;
  String description;
  String pictureId;
  String city;
  int id;
  int foodsize;
  int drinksize;
  double rating;
  List<String> foods;
  List<String> drinks;
  List<CustomerReviews> customerReviews;

  DetailPage(
      {this.name,
      this.description,
      this.pictureId,
      this.city,
      this.rating,
      this.foods,
      this.drinks,
      this.foodsize,
      this.drinksize,
      this.customerReviews,
      this.id});

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (context, isScrolled) {
            return isScrolled
                ? [
                    SliverAppBar(
                      pinned: true,
                      expandedHeight: 210,
                      title: Text(widget.name),
                      flexibleSpace: FlexibleSpaceBar(
                        background: Hero(
                          tag: widget.pictureId,
                          child: Image.network(
                            widget.pictureId,
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                      ),
                      leading: IconButton(
                        onPressed: () => {Navigator.pop(context)},
                        icon: Icon(
                          Icons.arrow_back_outlined,
                          color: white95,
                          size: 40,
                        ),
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
                              delegate: MenuSearchDelegate(widget),
                            );
                          },
                        ),
                      ],
                    ),
                  ]
                : [
                    SliverAppBar(
                      pinned: true,
                      expandedHeight: 210,
                      flexibleSpace: FlexibleSpaceBar(
                        background: Hero(
                          tag: widget.pictureId,
                          child: Image.network(
                            widget.pictureId,
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                        titlePadding: EdgeInsets.fromLTRB(56, 0, 0, 16),
                      ),
                      leading: IconButton(
                        onPressed: () => {Navigator.pop(context)},
                        icon: Icon(
                          Icons.arrow_back_outlined,
                          color: white95,
                          size: 40,
                        ),
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
                              delegate: MenuSearchDelegate(widget),
                            );
                          },
                        ),
                      ],
                    ),
                  ];
          },
          body: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.name,
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(Icons.location_on_outlined),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            widget.city,
                            style: Theme.of(context).textTheme.subtitle2,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        RatingStars(widget.rating),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            widget.rating.toString(),
                            style: Theme.of(context).textTheme.headline6,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Text(
                      widget.description,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    SizedBox(height: 42),
                    Text(
                      'Makanan',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    SizedBox(height: 8),
                    ListView.builder(
                        padding: EdgeInsets.all(8),
                        itemCount: widget.foodsize,
                        shrinkWrap: true,
                        physics: ScrollPhysics(),
                        itemBuilder: (context, index) {
                          return ListTile(
                            leading: Icon(Icons.fastfood_outlined),
                            title: Text(widget.foods[index]),
                          );
                        }),
                    SizedBox(height: 8),
                    Text(
                      'Minuman',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    SizedBox(height: 8),
                    ListView.builder(
                        padding: EdgeInsets.all(8),
                        itemCount: widget.drinksize,
                        shrinkWrap: true,
                        physics: ScrollPhysics(),
                        itemBuilder: (context, index) {
                          return ListTile(
                            leading: Icon(Icons.emoji_food_beverage_outlined),
                            title: Text(widget.drinks[index]),
                          );
                        }),
                    SizedBox(height: 8),
                    Text(
                      'Reviews',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    SizedBox(height: 8),
                    ListView.builder(
                        padding: EdgeInsets.all(8),
                        itemCount: widget.customerReviews.length,
                        shrinkWrap: true,
                        physics: ScrollPhysics(),
                        itemBuilder: (context, index) {
                          return ListTile(
                            leading: Icon(Icons.reviews),
                            title: Text(widget.customerReviews[index].name),
                            subtitle: Text(
                                '${widget.customerReviews[index].review}\n\n${widget.customerReviews[index].date}',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2
                                    .apply(color: Colors.black87)),
                          );
                        }),
                    ListView.builder(
                        padding: EdgeInsets.fromLTRB(8, 0, 8, 8),
                        itemCount: 1,
                        shrinkWrap: true,
                        physics: ScrollPhysics(),
                        itemBuilder: (context, index) {
                          var idx = widget.id;
                          return Consumer<FavouriteRestaurantsProvider>(builder:
                              (context, FavouriteRestaurantProvider, widget) {
                            if (Provider.of<FavouriteRestaurantsProvider>(
                                            context,
                                            listen: true)
                                        .myreview[idx] !=
                                    null &&
                                Provider.of<FavouriteRestaurantsProvider>(
                                            context,
                                            listen: true)
                                        .myreviewdate[idx] !=
                                    null) {
                              final myReview =
                                  Provider.of<FavouriteRestaurantsProvider>(
                                          context,
                                          listen: true)
                                      .myreview[idx];
                              final myReviewDate =
                                  Provider.of<FavouriteRestaurantsProvider>(
                                          context,
                                          listen: true)
                                      .myreviewdate[idx];
                              return ListTile(
                                leading: Icon(Icons.reviews),
                                title: Text('Anda'),
                                subtitle: Text('$myReview\n\n$myReviewDate',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText2
                                        .apply(color: Colors.black87)),
                              );
                            } else {
                              return Column();
                            }
                          });
                        }),
                    SizedBox(
                      height: 8,
                    ),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            TextFormField(
                              controller: _controller,
                              decoration: InputDecoration(
                                hintText: 'tulis review anda di sini',
                                labelText: 'Review',
                                icon: Icon(Icons.rate_review_outlined),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0)),
                              ),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    var now = DateTime.now();
                                    var formatter = DateFormat('d MMMM yyyy');
                                    var formattedDate = formatter.format(now);
                                    Provider.of<FavouriteRestaurantsProvider>(
                                            context,
                                            listen: false)
                                        .review(widget.id, _controller.text,
                                            formattedDate);
                                    _controller.clear();
                                  },
                                  icon: Icon(
                                    Icons.done_outline,
                                    color: Color(0xFF8c8877),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
