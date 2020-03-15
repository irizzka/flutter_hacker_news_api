import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hacker_news_api/src/blocs/comments_provider.dart';
import 'package:flutter_hacker_news_api/src/blocs/stories_provider.dart';
import 'package:flutter_hacker_news_api/src/screens/news_details_screen.dart';
import 'package:flutter_hacker_news_api/src/screens/news_list_screen.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CommentsProvider(
      child: StoriesProvider(
        child: MaterialApp(
          title: 'News',
          onGenerateRoute: routes,
        ),
      ),
    );
  }

  Route routes(RouteSettings settings) {
    if (settings.name == '/') {
      return MaterialPageRoute(builder: (context) {
        final bloc = StoriesProvider.of(context);
        bloc.fetchTopIds();
        return NewsList();
      });
    } else {
      return MaterialPageRoute(builder: (context) {
        // place to initialization or data fetching for NewsDetails screen
        final itemId = int.parse(settings.name.replaceFirst('/', ''));
        final commentsBloc = CommentsProvider.of(context);

        commentsBloc.fetchItemWithComments(itemId);

        return NewsDetails(
          itemId: itemId,
        );
      });
    }
  }
}
