import 'package:flutter/material.dart';
import 'package:flutter_hacker_news_api/src/blocs/stories_provider.dart';
import 'package:flutter_hacker_news_api/src/models/item_model.dart';
import 'package:flutter_hacker_news_api/src/widgets/loading_container.dart';

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
                      ? buildTile(snapshotItem.data, context)
                      : LoadingContainer();
                },
              )
            : LoadingContainer();
      },
    );
  }
}

Widget buildTile(ItemModel item, BuildContext context) {
  return Card(
    elevation: 3,
    child: ListTile(
      title: Text(item.title),
      subtitle: Text('${item.score} votes'),
      trailing: Column(
        children: <Widget>[
          Icon(Icons.insert_comment),
          Text('${item.descendants}'),
        ],
      ),
      onTap: (){
        Navigator.pushNamed(context, '/${item.id}');
      },
    ),
  );
}
