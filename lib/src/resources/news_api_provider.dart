import 'dart:convert';

import 'package:flutter_hacker_news_api/src/models/item_model.dart';
import 'package:flutter_hacker_news_api/src/resources/source.dart';
import 'package:http/http.dart' show Client;

class NewsApiProvider implements Source{
  Client client = Client();
  final String _url = 'https://hacker-news.firebaseio.com/v0';

  Future<List<int>> fetchTopId() async{
    final response  = await  client.get('$_url/topstories.json');
    final ids = jsonDecode(response.body);


    return ids.cast<int>();
  }


  Future<ItemModel> fetchItem(int id) async{
    final response = await client.get('$_url/item/$id.json');
    final item = jsonDecode(response.body);
    return ItemModel.fromJson(item);
  }
}

final NewsApiProvider newsApiProvider = NewsApiProvider();