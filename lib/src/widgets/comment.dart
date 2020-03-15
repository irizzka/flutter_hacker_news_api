import 'package:flutter/material.dart';
import 'package:flutter_hacker_news_api/src/models/item_model.dart';
import 'package:flutter_hacker_news_api/src/widgets/loading_container.dart';

class Comment extends StatelessWidget {
  final int itemId;
  final Map<int, Future<ItemModel>> itemMap;
  final int depth;

  Comment(
      {@required this.itemId, @required this.itemMap, @required this.depth});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: itemMap[itemId],
      builder: (context, AsyncSnapshot<ItemModel> snapshot) {
        if (!snapshot.hasData) {
          return LoadingContainer();
        }

        final item = snapshot.data;
        final children = <Widget>[
          ListTile(
            contentPadding: EdgeInsets.only(right: 16.0, left: depth * 16.0),
            title: buildText(item),
            subtitle: item.by == '' ? Text('Deleted comment') : Text(item.by),
          ),
          Divider(),
        ];
        if (item.kids != null) {
          item.kids.forEach(
            (el) => children.add(
              Comment(
                itemId: el,
                itemMap: itemMap,
                depth: depth + 1,
              ),
            ),
          );
        }

        return Column(
          children: children,
        );
      },
    );
  }
  
  buildText(ItemModel item) {
    final text = item.text
        .replaceAll('&#x27;', '\'')
        .replaceAll('<p>', '\n\n')
        .replaceAll('</p>', '');
    return Text(text);
  }
}
