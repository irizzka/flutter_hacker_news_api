import 'package:flutter_hacker_news_api/src/models/item_model.dart';

abstract class Cache {
  Future<int> addItem(ItemModel item);
}