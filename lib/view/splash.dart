import 'package:flutter/material.dart';
import 'package:restaurant_app/provider/loader.dart';
import 'package:restaurant_app/style/styles.dart';
import 'package:splashscreen/splashscreen.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  Loader loader;

  @override
  void initState() {
    super.initState();
    loader = Loader(context);
    loader.loadData();
  }

  @override
  Widget build(BuildContext context) {
    return SplashScreen(
        seconds: 3,
        navigateAfterFuture: loader.loadData(),
        title: Text(
          'Top Restaurant\n' + "   " + 'by Ziyad',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
        ),
        image: Image.asset('assets/resto.jpg'),
        backgroundColor: backgroundColor,
        styleTextUnderTheLoader: TextStyle(),
        photoSize: 150.0,
        loaderColor: accentColor);
  }
}
