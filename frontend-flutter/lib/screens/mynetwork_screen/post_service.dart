import 'package:flutter/material.dart';
import 'package:sentimento/screens/mynetwork_screen/add_post_screen.dart';

class PostService extends StatelessWidget {
  const PostService({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const AddPostScreen(isVacancy: false);
  }
}
