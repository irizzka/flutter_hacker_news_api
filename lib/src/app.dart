import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hacker_news_api/src/blocs/stories_provider.dart';
import 'package:flutter_hacker_news_api/src/screens/news_list_screen.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return StoriesProvider(
      child: MaterialApp(
        title: 'News',
        home: NewsList(),
      ),
    );
  }

}