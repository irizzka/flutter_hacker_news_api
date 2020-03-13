import 'package:flutter/material.dart';
import 'package:flutter_hacker_news_api/src/blocs/stories_provider.dart';
import 'package:flutter_hacker_news_api/src/models/item_model.dart';

class NewsListTile extends StatelessWidget {

  final int itemId;


  NewsListTile({@required this.itemId});

  @override
  Widget build(BuildContext context) {
    final bloc = StoriesProvider.of(context);
    return StreamBuilder(
      stream: bloc.items,
      builder: (context, AsyncSnapshot<Map<int, Future<ItemModel>>> snapshot) {
        return snapshot.hasData
            ? FutureBuilder(
          future: snapshot.data[itemId],
          builder: (context, AsyncSnapshot<ItemModel> snapshotItem) {
              return snapshotItem.hasData
                  ? Text(snapshotItem.data.title)
                  : Text('Still loading item $itemId');
          },
        )
            : Text('Stream still loading');
      },
    );
  }
}
