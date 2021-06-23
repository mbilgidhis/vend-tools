import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'package:vend_tools_v2/model/store.dart';

class DatabaseHandler {
  Future<Database> initializeDB() async {
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, 'stores.db'),
      onCreate: (database, version) async {
        await database.execute(
          'CREATE TABLE stores(id INTEGER PRIMARY KEY AUTOINCREMENT, name, TEXT, key TEXT, uri TEXT, active INTEGER)',
        );
      },
      version: 1,
    );
  }

  Future<int> insertStore(List<Store> stores) async {
    int result = 0;
    final Database db = await initializeDB();
    for(var store in stores){
      result = await db.insert('stores', store.toMap());
    }
    return result;
  }

  Future<List<Store>> retrieveStores() async {
    final Database db = await initializeDB();
    final List<Map<String, Object?>> queryResult = await db.query('stores');
    return queryResult.map((e) => Store.fromMap(e)).toList();
  }

  Future<void> deleteStore(int id) async {
    final db = await initializeDB();
    await db.delete(
      'stores',
      where: "id = ?",
      whereArgs: [id],
    );
  }

  Future deactiveAll() async {
    final db = await initializeDB();
    // Store all = Store( active: 0 );
    var res = await db.rawQuery("UPDATE stores set active = 0 WHERE active = 1");
    // var res = await db.update('stores', all.toMap());
    return res;
  }

  Future setActive(int id) async {
    final db = await initializeDB();
    // Store active = Store( active: 1);
    // var res = await db.update('stores', active.toMap(), where: "id = ?", whereArgs: [id]);
    var res = await db.rawQuery("UPDATE stores set active = 1 WHERE id = ? ", [id]);
    return res;
  }

  Future<List<Store>> getActives() async {
    final db = await initializeDB();
    final List<Map<String, Object?>> queryResult = await db.query('stores', where: "active = 1");
    return queryResult.map((e) => Store.fromMap(e)).toList();
    // var res = await db.query('stores', where: "active = 1");
    // return res;
    // return res.isNotEmpty ? Store.fromMap(res.first) : null;
  }
}