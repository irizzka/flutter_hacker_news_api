import 'package:flutter_hacker_news_api/src/resources/cache.dart';
import 'package:flutter_hacker_news_api/src/resources/source.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:async';
import '../models/item_model.dart';

class NewsDbProvider implements Source, Cache{
  Database db;

  NewsDbProvider(){
    init();
  }

  init() async{
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'items.db');
    db = await openDatabase(
      path,
      version: 1,
      onCreate: (Database newDb, int version) {
        newDb.execute("""
          CREATE TABLE Items
            (
              id INTEGER PRIMARY KEY,
              type TEXT,
              by TEXT,
              time INTEGER,
              text TEXT,
              parent INTEGER,
              kids BLOB,
              dead INTEGER,
              deleted INTEGER,
              url TEXT,
              score INTEGER,
              title TEXT,
              descendants INTEGER
            )
        """);
      }
    );
  }

  Future<ItemModel> fetchItem(int id) async{
    final maps = await db.query(
      'Items',
      columns: null,
      where: 'id = ?',
      whereArgs: [id],
    );

    if(maps.length > 0){
        return ItemModel.fromDB(maps.first);
    }

    return null;
  }


  Future<int> addItem(ItemModel item) {
    return db.insert('Items', item.toMapForDB() , conflictAlgorithm: ConflictAlgorithm.replace);
  }

  @override
  Future<List<int>> fetchTopId() {
    return null;
  }

  Future<int> clear() {
    return db.delete('Items');
  }
}

final newsDbProvider = NewsDbProvider();