import 'dart:async';
import 'news_api_provider.dart';
import 'news_db_provider.dart';
import '../models/item_model.dart';

class Repository {
  NewsDbProvider dbProvider = NewsDbProvider();
  NewsApiProvider newsApiProvider = NewsApiProvider();

  Future<List<int>> fetchTopIds() {
    return newsApiProvider.fetchTopId();
  }

  Future<ItemModel> fetchItem(int id) async{
    var item = await dbProvider.fetchItem(id);
    if(item != null){
      return item;
    }

    item = await newsApiProvider.fetchItem(id);
    dbProvider.addItem(item);

    return item;
  }
}