import 'dart:async';
import 'package:flutter_hacker_news_api/src/resources/cache.dart';
import 'package:flutter_hacker_news_api/src/resources/source.dart';

import 'news_api_provider.dart';
import 'news_db_provider.dart';
import '../models/item_model.dart';

class Repository {
 // NewsDbProvider dbProvider = NewsDbProvider();
 // NewsApiProvider newsApiProvider = NewsApiProvider();
  List<Source> sources = <Source> [
    NewsDbProvider(),
    NewsApiProvider()
  ];

  List<Cache> caches = <Cache>[
    NewsDbProvider(),
  ];

  Future<List<int>> fetchTopIds() {


  }

  Future<ItemModel> fetchItem(int id) async{
    ItemModel item;
    Source source;

    for(source in sources){
      item = await source.fetchItem(id);
      if(item != null){
        break;
      }
    }

    for(var cache in caches){
      cache.addItem(item);
    }

    return item;
  }
}