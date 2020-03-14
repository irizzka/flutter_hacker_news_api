import 'package:flutter/material.dart';
import 'package:flutter_hacker_news_api/src/models/item_model.dart';

class Comment extends StatelessWidget {
  final int itemId;
  final Map<int, Future<ItemModel>> itemMap;


  Comment({@required this.itemId, @required this.itemMap});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: itemMap[itemId],
      builder: (context, AsyncSnapshot<ItemModel> snapshot){
        if(!snapshot.hasData){
          return Text('Still loading comment');
        }

        return Text(snapshot.data.text);
      },
    );
  }
}
