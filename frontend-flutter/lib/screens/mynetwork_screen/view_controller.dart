import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sentimento/bloc/posts_bloc/posts_bloc.dart';
import 'package:sentimento/screens/home_screen/home_screen.dart';
import 'package:sentimento/screens/mynetwork_screen/posts_loaded.dart';
import 'package:sentimento/screens/reports_screen/report_loading.dart';
import 'package:sentimento/widgets/minor_ui_parts.dart';

class ViewController extends StatelessWidget {
  const ViewController({Key? key, required this.postType}) : super(key: key);
  final String postType;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          PostBloc(PostLoading())..add(ViewPostsClicked(postType: postType)),
      child: BlocBuilder<PostBloc, PostState>(builder: (context, state) {
        if (state is PostLoading) {
          return const ReportLoading();
        } else if (state is ViewPostsState) {
          return PostsLoaded(
              isUser: postType == "user" ? true : false, posts: state.posts!);
        } else if (state is PostFailedState) {
          manualToastMsg(state.message);
        }
        return const HomeScreen();
      }),
    );
  }
}
