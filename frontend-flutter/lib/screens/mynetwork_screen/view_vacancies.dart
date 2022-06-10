import 'package:flutter/material.dart';
import 'package:sentimento/screens/mynetwork_screen/view_controller.dart';

class ViewVacancies extends StatelessWidget {
  const ViewVacancies({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const ViewController(postType: "vacancy");
  }
}
