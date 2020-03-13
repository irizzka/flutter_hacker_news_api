import 'package:flutter/material.dart';
import 'package:flutter_hacker_news_api/src/blocs/stories_bloc.dart';
import 'package:flutter_hacker_news_api/src/blocs/stories_provider.dart';
import 'package:flutter_hacker_news_api/src/widgets/news_list_tile.dart';

class NewsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = StoriesProvider.of(context);
    bloc.fetchTopIds();

    return Scaffold(
      appBar: AppBar(
        title: Text('Top News'),
      ),
      body: buildList(bloc),
    );
  }

  Widget buildList (StoriesBloc bloc) {
    return StreamBuilder(
      stream: bloc.topIds,
      builder: (context, AsyncSnapshot<List<int>> snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index){
                  bloc.fetchItem(snapshot.data[index]);
                  return NewsListTile(itemId: snapshot.data[index]);
            })
            : Center(
                child: CircularProgressIndicator(),
        );
      },
    );
  }

}
