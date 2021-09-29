import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static DatabaseHelper _databaseHelper;
  static Database _database;

  DatabaseHelper._internal() {
    _databaseHelper = this;
  }

  factory DatabaseHelper() => _databaseHelper ?? DatabaseHelper._internal();

  Future<Database> get database async {
    _database = await _initializeDb();
    return _database;
  }

  Future<Database> _initializeDb() async {
    var dbPath = await getDatabasesPath();
    var path = dbPath + 'restaurant_db.db';
    var db = openDatabase(
      path,
      onCreate: (db, version) async {
        await db.execute(
          '''CREATE TABLE favourite (
             name TEXT PRIMARY KEY
           )
           ''',
        );
        await db.execute(
          '''CREATE TABLE indx (
             id INTEGER PRIMARY KEY)
             ''',
        );
        await db.execute(
          '''
             CREATE TABLE myreview (
             id INTEGER PRIMARY KEY,
             review TEXT
           )
             
           ''',
        );
        await db.execute(
          '''
          CREATE TABLE myreviewdate (
             id INTEGER PRIMARY KEY,
             reviewdate TEXT
           )
             
           ''',
        );
      },
      onOpen: (db) async {},
      version: 1,
    );

    return db;
  }

  Future<void> insertFavs(String name) async {
    try {
      var dbPath = await getDatabasesPath();
      var path = dbPath + 'restaurant_db.db';
      var db = await openDatabase(
        path,
        version: 1,
      );
      print('start');
      await db.rawInsert(
          'INSERT INTO favourite(name) VALUES(\'${name.toString()}\')');

      print('Data saved');
    }catch(e){
      print(e);
      var dbPath = await getDatabasesPath();
      var path = dbPath + 'restaurant_db.db';
      var db = await openDatabase(
        path,
        version: 1,
      );
      await db.execute(
        '''CREATE TABLE favourite (
             name TEXT PRIMARY KEY
           )
           ''',
      );
      await db.rawInsert(
          'INSERT INTO favourite(name) VALUES(\'${name.toString()}\')');

      print('Data saved');
    }
  }

  Future<List<String>> getFavs() async {
    try{
    var dbPath = await getDatabasesPath();
    var path = dbPath + 'restaurant_db.db';
    var db = await openDatabase(
      path,
      version: 1,
    );
    var results =
        await db.rawQuery('SELECT * FROM favourite');
    var temp = <String>[];
    for (var i = 0; i < results.length; i++) {
      var tempMap = results[i];
      temp.add(tempMap['name']);
    }
    return temp;
    }catch(e){
      print(e);
      var dbPath = await getDatabasesPath();
      var path = dbPath + 'restaurant_db.db';
      var db = await openDatabase(
        path,
        version: 1,
      );
      await db.execute(
        '''CREATE TABLE favourite (
             name TEXT PRIMARY KEY
           )
           ''',
      );
      var results =
      await db.rawQuery('SELECT * FROM favourite');
      var temp = <String>[];
      for (var i = 0; i < results.length; i++) {
        var tempMap = results[i];
        temp.add(tempMap['name']);
      }
      return temp;
    }
  }

  Future<void> deleteFavs(String name) async {
    var dbPath = await getDatabasesPath();
    var path = dbPath + 'restaurant_db.db';
    var db = await openDatabase(
      path,
      version: 1,
    );
    await db
        .rawDelete('DELETE FROM favourite WHERE name = ?', [name.toString()]);
  }

  Future<void> insertId(int id) async {
    try {
      var dbPath = await getDatabasesPath();
      var path = dbPath + 'restaurant_db.db';
      var db = await openDatabase(
        path,
        version: 1,
      );
      await db.rawInsert('INSERT INTO indx(id) VALUES(${id.toString()})');
      print('Data saved');
    }catch(e){
      var dbPath = await getDatabasesPath();
      var path = dbPath + 'restaurant_db.db';
      var db = await openDatabase(
        path,
        version: 1,
      );
      await db.execute(
        '''CREATE TABLE indx (
             id INTEGER PRIMARY KEY)
             ''',
      );
      await db.rawInsert('INSERT INTO indx(id) VALUES(${id.toString()})');
      print('Data saved');
    }
  }

  Future<List<int>> getId() async {
    try{
    var dbPath = await getDatabasesPath();
    var path = dbPath + 'restaurant_db.db';
    var db = await openDatabase(
      path,
      version: 1,
    );
    var results =
        await db.rawQuery('SELECT * FROM indx');
    var temp = <int>[];
    for (var i = 0; i < results.length; i++) {
      var tempMap = results[i];
      temp.add(tempMap['id']);
    }
    return temp;
  }catch(e){
  var dbPath = await getDatabasesPath();
  var path = dbPath + 'restaurant_db.db';
  var db = await openDatabase(
  path,
  version: 1,
  );
  await db.execute(
  '''CREATE TABLE indx (
             id INTEGER PRIMARY KEY)
             ''',
  );
  var results =
  await db.rawQuery('SELECT * FROM indx');
  var temp = <int>[];
  for (var i = 0; i < results.length; i++) {
    var tempMap = results[i];
    temp.add(tempMap['id']);
  }
  return temp;
  }
  }

  Future<void> deleteId(int id) async {
    var dbPath = await getDatabasesPath();
    var path = dbPath + 'restaurant_db.db';
    var db = await openDatabase(
      path,
      version: 1,
    );
    await db.rawDelete('DELETE FROM indx WHERE id = ?', [id.toString()]);
  }

  Future<void> insertReview(int id, String review) async {
    try {
      var dbPath = await getDatabasesPath();
      var path = dbPath + 'restaurant_db.db';
      var db = await openDatabase(
        path,
        version: 1,
      );
      await db.rawInsert(
          'INSERT INTO myreview(id,review) VALUES(${id.toString()},\'${review
              .toString()}\')');
      print('Data saved');
    }catch(e){
      var dbPath = await getDatabasesPath();
      var path = dbPath + 'restaurant_db.db';
      var db = await openDatabase(
        path,
        version: 1,
      );
      await db.execute(
        '''
             CREATE TABLE myreview (
             id INTEGER PRIMARY KEY,
             review TEXT
           )
             
           ''',
      );
      await db.rawInsert(
          'INSERT INTO myreview(id,review) VALUES(${id.toString()},\'${review
              .toString()}\')');
      print('Data saved');
    }
  }

  Future<Map<int, String>> getReview() async {
    try {
      var dbPath = await getDatabasesPath();
      var path = dbPath + 'restaurant_db.db';
      var db = await openDatabase(
        path,
        version: 1,
      );
      var results =
      await db.rawQuery('SELECT * FROM myreview');
      var temp = <int, String>{};
      for (var i = 0; i < results.length; i++) {
        var tempMap = results[i];
        temp[tempMap['id']] = tempMap['review'];
      }
      return temp;
    }catch(e){
  var dbPath = await getDatabasesPath();
  var path = dbPath + 'restaurant_db.db';
  var db = await openDatabase(
  path,
  version: 1,
  );
  await db.execute(
  '''
             CREATE TABLE myreview (
             id INTEGER PRIMARY KEY,
             review TEXT
           )
             
           ''',
  );
  var results =
  await db.rawQuery('SELECT * FROM myreview');
  var temp = <int, String>{};
  for (var i = 0; i < results.length; i++) {
    var tempMap = results[i];
    temp[tempMap['id']] = tempMap['review'];
  }
  return temp;
  }
  }

  Future<void> deleteReview(int id) async {
    var dbPath = await getDatabasesPath();
    var path = dbPath + 'restaurant_db.db';
    var db = await openDatabase(
      path,
      version: 1,
    );
    await db.rawDelete('DELETE FROM myreview WHERE id = ?', [id.toString()]);
  }

  Future<void> updateReview(int id, String review) async {
    var dbPath = await getDatabasesPath();
    var path = dbPath + 'restaurant_db.db';
    var db = await openDatabase(
      path,
      version: 1,
    );
    await db.rawUpdate(
        'UPDATE myreview SET review = ? WHERE id = ?', [review, id.toString()]);
    print('Data updated');
  }

  Future<void> insertReviewDate(int id, String reviewDate) async {
    try {
      var dbPath = await getDatabasesPath();
      var path = dbPath + 'restaurant_db.db';
      var db = await openDatabase(
        path,
        version: 1,
      );
      await db.rawInsert(
          'INSERT INTO myreviewdate(id,reviewdate) VALUES(${id
              .toString()},\'${reviewDate.toString()}\')');
      print('Data saved');
    }catch(e){
      var dbPath = await getDatabasesPath();
      var path = dbPath + 'restaurant_db.db';
      var db = await openDatabase(
        path,
        version: 1,
      );
      await db.execute(
        '''
          CREATE TABLE myreviewdate (
             id INTEGER PRIMARY KEY,
             reviewdate TEXT
           )
             
           ''',
      );
      await db.rawInsert(
          'INSERT INTO myreviewdate(id,reviewdate) VALUES(${id
              .toString()},\'${reviewDate.toString()}\')');
      print('Data saved');
    }
  }

  Future<Map<int, String>> getReviewDate() async {
    try{
    var dbPath = await getDatabasesPath();
    var path = dbPath + 'restaurant_db.db';
    var db = await openDatabase(
      path,
      version: 1,
    );
    var results =
        await db.rawQuery('SELECT * FROM myreviewdate');
    var temp = <int, String>{};
    for (var i = 0; i < results.length; i++) {
      var tempMap = results[i];
      temp[tempMap['id']] = tempMap['reviewdate'];
    }
    return temp;
  }catch(e){
  var dbPath = await getDatabasesPath();
  var path = dbPath + 'restaurant_db.db';
  var db = await openDatabase(
  path,
  version: 1,
  );
  await db.execute(
  '''
          CREATE TABLE myreviewdate (
             id INTEGER PRIMARY KEY,
             reviewdate TEXT
           )
             
           ''',
  );
  var results =
  await db.rawQuery('SELECT * FROM myreviewdate');
  var temp = <int, String>{};
  for (var i = 0; i < results.length; i++) {
    var tempMap = results[i];
    temp[tempMap['id']] = tempMap['reviewdate'];
  }
  return temp;
  }
  }

  Future<void> deleteReviewDate(int id) async {
    var dbPath = await getDatabasesPath();
    var path = dbPath + 'restaurant_db.db';
    var db = await openDatabase(
      path,
      version: 1,
    );
    await db.rawDelete('DELETE FROM reviewdate WHERE id = ?', [id.toString()]);
  }

  Future<void> updateReviewDate(int id, String reviewDate) async {
    var dbPath = await getDatabasesPath();
    var path = dbPath + 'restaurant_db.db';
    var db = await openDatabase(
      path,
      version: 1,
    );
    await db.rawUpdate('UPDATE myreviewdate SET reviewdate = ? WHERE id = ?',
        [reviewDate, id.toString()]);
    print('Data updated');
  }
}
