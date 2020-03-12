import 'package:flutter_hacker_news_api/src/models/item_model.dart';

abstract class Source {

  Future<ItemModel> fetchItem(int id);
  Future<List<int>> fetchTopId();

}