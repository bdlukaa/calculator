import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'history.dart';

Database historyDatabase;

Future<Database> startDatabase() async {
  if (!kIsWeb)
    historyDatabase = await openDatabase(
      // Set the path to the database. Note: Using the `join` function from the
      // `path` package is best practice to ensure the path is correctly
      // constructed for each platform.
      join(
        await getDatabasesPath(),
        'history_db.db',
      ),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE history(expression TEXT, date TEXT)",
        );
      },
      version: 2,
    );

  List<Map<String, dynamic>> list = await historyDatabase.query('history');
  for (var l in list) {
    History.history.addAll(
      {l['expression']: DateTime.parse(l['date'])},
    );
  }
  return historyDatabase;
}

Future<void> closeDatabase() async => await historyDatabase.close();

Future<void> addToHistory(String expression) async {
  History.history.addAll({expression: DateTime.now()});
  await historyDatabase?.insert('history', {
    'expression': expression,
    'date': DateTime.now().toIso8601String(),
  });
}

Future<void> clear() async {
  History.history.clear();
  await historyDatabase?.execute('delete from history');
}
