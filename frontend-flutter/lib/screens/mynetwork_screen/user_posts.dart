import 'package:flutter/material.dart';
import 'package:sentimento/screens/mynetwork_screen/view_controller.dart';

class UserPosts extends StatelessWidget {
  const UserPosts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const ViewController(postType: "user");
  }
}
