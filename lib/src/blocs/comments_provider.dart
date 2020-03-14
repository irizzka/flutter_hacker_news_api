import 'package:flutter/cupertino.dart';
import 'package:flutter_hacker_news_api/src/blocs/comments_bloc.dart';

class CommentsProvider extends InheritedWidget {

  final CommentsBloc bloc;


  CommentsProvider({Key key, Widget child})
      : bloc = CommentsBloc(),
        super(key: key, child: child);

  @override
  bool updateShouldNotify(_) {
    return true;
  }

  static CommentsBloc of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(CommentsProvider) as CommentsProvider).bloc;
  }


}