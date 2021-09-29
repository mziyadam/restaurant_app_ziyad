import 'package:flutter/material.dart';
import 'package:restaurant_app/view/detail.dart';
import 'package:restaurant_app/model/customer_reviews.dart';

class CustomInkwell extends StatelessWidget {
  final String name, description, pictureId, city;
  final double rating;
  final List<String> foods, drinks;
  final int foodSize, drinkSize;
  final bool isLiked;
  final Function() onClick;
  final List<CustomerReviews> customerReviews;
  final int id;

  CustomInkwell(
      this.name,
      this.description,
      this.pictureId,
      this.city,
      this.rating,
      this.foods,
      this.drinks,
      this.foodSize,
      this.drinkSize,
      this.isLiked,
      this.onClick,
      this.customerReviews,
      this.id);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        children: [
          Expanded(
            flex: 21,
            child: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DetailPage(
                              name: name,
                              description: description,
                              pictureId: pictureId,
                              city: city,
                              rating: rating,
                              foods: foods,
                              drinks: drinks,
                              foodsize: foodSize,
                              drinksize: drinkSize,
                              customerReviews: customerReviews,
                              id: id,
                            )));
              },
              child: Container(
                padding: EdgeInsets.all(8),
                child: Row(
                  children: [
                    Expanded(
                      flex: 7,
                      child: Hero(
                        tag: pictureId,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.network(
                            pictureId,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 18,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Text(
                                  name,
                                  style: Theme.of(context).textTheme.headline6,
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 5.0),
                            child: Row(
                              children: [
                                Icon(Icons.location_on_outlined),
                                Text(
                                  city,
                                  style: Theme.of(context).textTheme.subtitle2,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 5.0, bottom: 12),
                            child: Row(
                              children: [
                                Icon(Icons.star_outlined),
                                Text(
                                  rating.toString(),
                                  style: Theme.of(context).textTheme.subtitle1,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
              flex: 3,
              child: isLiked
                  ? IconButton(
                      icon: Icon(
                        Icons.favorite,
                      ),
                      onPressed: onClick,
                    )
                  : IconButton(
                      icon: Icon(Icons.favorite_border),
                      onPressed: onClick,
                    )),
        ],
      ),
    );
  }
}
