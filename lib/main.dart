import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/favourite_restaurants_provider.dart';
import 'package:restaurant_app/view/splash.dart';
import 'package:restaurant_app/style/styles.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';

void showNotif() async {
  final prefs = await SharedPreferences.getInstance();
  const isNotifOn = 'isNotifOn';
  print(prefs.getBool(isNotifOn));

  if (prefs.getBool(isNotifOn)) {
    await AwesomeNotifications().createNotification(
        content: NotificationContent(
            id: 1,
            channelKey: 'basic_channel',
            title: 'Makan apa hari ini?',
            body: 'Mari kunjungi restoran ini!'));
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await AndroidAlarmManager.initialize();
  runApp(MyApp());
  await AndroidAlarmManager.periodic(
    const Duration(hours: 24),
    1,
    showNotif,
    wakeup: true,
    startAt: DateTime.now().isAfter(DateTime(DateTime.now().year,
            DateTime.now().month, DateTime.now().day, 11, 0))
        ? DateTime(DateTime.now().year, DateTime.now().month,
                DateTime.now().day, 11, 0)
            .add(Duration(days: 1))
        : DateTime(DateTime.now().year, DateTime.now().month,
            DateTime.now().day, 11, 0),
    rescheduleOnReboot: true,
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => FavouriteRestaurantsProvider(),
      child: MaterialApp(
        title: 'Restaurant App',
        theme: ThemeData(
          primaryColor: primaryColor,
          accentColor: accentColor,
          scaffoldBackgroundColor: backgroundColor,
          textTheme: textTheme,
          appBarTheme: AppBarTheme(
            textTheme: textTheme,
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              primary: accentColor,
              textStyle: TextStyle(),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.zero,
                ),
              ),
            ),
          ),
        ),
        home: SplashPage(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
