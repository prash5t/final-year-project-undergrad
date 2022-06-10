import 'package:flutter/material.dart';
import 'package:sentimento/screens/mynetwork_screen/add_post_screen.dart';

class PostVacancy extends StatelessWidget {
  const PostVacancy({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const AddPostScreen(isVacancy: true);
  }
}
