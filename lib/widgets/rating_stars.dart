import 'package:flutter/material.dart';

class RatingStars extends StatelessWidget {
  final double rating;

  RatingStars(this.rating);

  Row _rate(double _rating) {
    if (_rating <= 0.99) {
      return Row(
        children: [
          Icon(Icons.star_half_outlined),
          Icon(Icons.star_outline_outlined),
          Icon(Icons.star_outline_outlined),
          Icon(Icons.star_outline_outlined),
          Icon(Icons.star_outline_outlined),
        ],
      );
    } else if (_rating <= 1) {
      return Row(
        children: [
          Icon(Icons.star_outlined),
          Icon(Icons.star_outline_outlined),
          Icon(Icons.star_outline_outlined),
          Icon(Icons.star_outline_outlined),
          Icon(Icons.star_outline_outlined),
        ],
      );
    } else if (_rating <= 1.99) {
      return Row(
        children: [
          Icon(Icons.star_outlined),
          Icon(Icons.star_half_outlined),
          Icon(Icons.star_outline_outlined),
          Icon(Icons.star_outline_outlined),
          Icon(Icons.star_outline_outlined),
        ],
      );
    } else if (_rating <= 2.0) {
      return Row(
        children: [
          Icon(Icons.star_outlined),
          Icon(Icons.star_outlined),
          Icon(Icons.star_outline_outlined),
          Icon(Icons.star_outline_outlined),
          Icon(Icons.star_outline_outlined),
        ],
      );
    } else if (_rating <= 2.99) {
      return Row(
        children: [
          Icon(Icons.star_outlined),
          Icon(Icons.star_outlined),
          Icon(Icons.star_half_outlined),
          Icon(Icons.star_outline_outlined),
          Icon(Icons.star_outline_outlined),
        ],
      );
    } else if (_rating <= 3.0) {
      return Row(
        children: [
          Icon(Icons.star_outlined),
          Icon(Icons.star_outlined),
          Icon(Icons.star_outlined),
          Icon(Icons.star_outline_outlined),
          Icon(Icons.star_outline_outlined),
        ],
      );
    } else if (_rating <= 3.99) {
      return Row(
        children: [
          Icon(Icons.star_outlined),
          Icon(Icons.star_outlined),
          Icon(Icons.star_outlined),
          Icon(Icons.star_half_outlined),
          Icon(Icons.star_outline_outlined),
        ],
      );
    } else if (_rating <= 4.0) {
      return Row(
        children: [
          Icon(Icons.star_outlined),
          Icon(Icons.star_outlined),
          Icon(Icons.star_outlined),
          Icon(Icons.star_outlined),
          Icon(Icons.star_outline_outlined),
        ],
      );
    } else if (_rating <= 4.99) {
      return Row(
        children: [
          Icon(Icons.star_outlined),
          Icon(Icons.star_outlined),
          Icon(Icons.star_outlined),
          Icon(Icons.star_outlined),
          Icon(Icons.star_half_outlined),
        ],
      );
    } else {
      return Row(
        children: [
          Icon(Icons.star_outlined),
          Icon(Icons.star_outlined),
          Icon(Icons.star_outlined),
          Icon(Icons.star_outlined),
          Icon(Icons.star_outlined),
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return _rate(rating);
  }
}
