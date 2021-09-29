import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:restart_app/restart_app.dart';

class Setting extends StatefulWidget {
  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  static const String isNotifOn = 'isNotifOn';

  Future<bool> getNotif() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(isNotifOn);
  }

  void onOff(bool val) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(isNotifOn, val);
    print(prefs.getBool(isNotifOn));
  }

  void showMsg(BuildContext context) {
    final scaffold = ScaffoldMessenger.of(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 25),
        content: const Text(
            'Silahkan buka ulang aplikasi untuk menerapkan perubahan'),
        action: SnackBarAction(
            label: 'OK',
            onPressed: () {
              Restart.restartApp();
            }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Favourite Restaurants'),
      ),
      body: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Show Notification',
                style: Theme.of(context).textTheme.subtitle1,
              ),
              FutureBuilder<bool>(
                future: getNotif(),
                builder: (context, _snapshot) {
                  return Switch(
                    value: _snapshot.data ?? false,
                    onChanged: (value) {
                      onOff(value);
                      showMsg(context);
                      setState(() {
                        onOff(value);
                      });
                    },
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
