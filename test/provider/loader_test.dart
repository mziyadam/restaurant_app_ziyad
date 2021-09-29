import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:restaurant_app/provider/loader.dart';
import 'package:restaurant_app/view/home.dart';

void main() {
  test('Mengecek apakah parsing data json berhasil tersimpan', () async {
    BuildContext context;
    var loader = Loader(context);
    HomePage hp = await loader.loadData();
    var namaResto = 'Melting Pot';
    var restaurantResult = await hp.name.contains(namaResto);

    expect(restaurantResult, true);
  });
}
