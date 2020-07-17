import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Database favoritesDatabase;

Future<Database> startDatabase() async {
  if (!kIsWeb)
    favoritesDatabase = await openDatabase(
      // Set the path to the database. Note: Using the `join` function from the
      // `path` package is best practice to ensure the path is correctly
      // constructed for each platform.
      join(
        await getDatabasesPath(),
        'favorites_db.db',
      ),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE favorites(expression TEXT, date TEXT)",
        );
      },
      version: 2,
    );
  return favoritesDatabase;
}

Future<void> closeDatabase() async => await favoritesDatabase.close();

Future<void> favorite(String expression) async {
  await favoritesDatabase?.insert('favorites', {
    'expression': expression,
    'date': DateTime.now().toIso8601String(),
  });
}

Future<void> unfavorite(String expression, DateTime time) async {
  await favoritesDatabase?.delete(
    'favorites',
    where: "expression = ? and date = ?",
    whereArgs: [expression, time.toIso8601String()],
  );
}

Future<void> clear() async {
  await favoritesDatabase?.execute('delete from favorites');
}