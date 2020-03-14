import 'package:flutter/material.dart';
import 'package:flutter_hacker_news_api/src/blocs/comments_bloc.dart';
import 'package:flutter_hacker_news_api/src/blocs/comments_provider.dart';
import 'package:flutter_hacker_news_api/src/models/item_model.dart';
import 'package:flutter_hacker_news_api/src/widgets/comment.dart';
import 'package:flutter_hacker_news_api/src/widgets/news_list_tile.dart';

class NewsDetails extends StatelessWidget {

  final int itemId;


  NewsDetails({@required this.itemId});

  @override
  Widget build(BuildContext context) {
    final bloc = CommentsProvider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Details'),
      ),
      body: buildBody(bloc),
    );
  }

  buildBody(CommentsBloc bloc) {
    return StreamBuilder(
      stream: bloc.itemWithComments,
      builder: (context, AsyncSnapshot<Map<int, Future<ItemModel>>> snapshot) {
        if(!snapshot.hasData){
          return Text('Loading');
        }

        final itemFuture = snapshot.data[itemId];

        return FutureBuilder(
          future: itemFuture,
          builder: (context, AsyncSnapshot<ItemModel> itemSnapshot){
            if(!itemSnapshot.hasData){
              return Text('Loading');
            }
            return buildList(itemSnapshot.data, snapshot.data);
          },
        );
      },
    );
  }

  Widget buildList(ItemModel item, Map<int, Future<ItemModel>> itemMap){

    final commentsList = item.kids.map((el) => Comment(itemId: el, itemMap: itemMap,)).toList();

    return ListView(
      children: <Widget>[
        buildTitle(item),
        ...commentsList,
      ],
    );

  }


  Widget buildTitle(ItemModel item) {
    return Container(
      alignment: Alignment.topCenter,
      margin: EdgeInsets.all(10.0),
      child: Text(item.title,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 20.0,
        fontWeight: FontWeight.w600
      ),),
    );
  }
}
