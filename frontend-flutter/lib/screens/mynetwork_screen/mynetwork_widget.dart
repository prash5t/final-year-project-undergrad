import 'package:flutter/material.dart';
import 'package:sentimento/utilities/routes.dart';
import 'package:sentimento/widgets/menu_widget.dart';

class NetworksMenu extends StatelessWidget {
  const NetworksMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String dir = "lib/assets";
    List<String> titles = [
      "Vacancies",
      "Freelancers",
      "Post vacancy",
      "Post service",
    ];
    List<String> imagePaths = [
      "$dir/available_vacancies.png",
      "$dir/available_freelancers.png",
      "$dir/post_vacancy.png",
      "$dir/post_skill.png",
    ];
    List<String> routes = [
      AppRoutes.viewVacancy,
      AppRoutes.viewFreelancer,
      AppRoutes.postVacancy,
      AppRoutes.postSkill,
    ];
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          MenuWidget(titles: titles, imagePaths: imagePaths, routes: routes),
        ],
      ),
    );
  }
}
