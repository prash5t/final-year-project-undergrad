import 'package:flutter/material.dart';
import 'package:sentimento/utilities/routes.dart';
import 'package:sentimento/widgets/menu_widget.dart';

class AnalysisMenu extends StatelessWidget {
  const AnalysisMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String dir = "lib/assets";
    List<String> titles = [
      "Comments",
      "Tweets",
      "Provide Sentence",
      "My Reports"
    ];
    List<String> imagePaths = [
      "$dir/comments.png",
      "$dir/tweets.png",
      "$dir/text.png",
      "$dir/reports.png"
    ];
    List<String> routes = [
      AppRoutes.commentsAnalysis,
      AppRoutes.tweetsAnalysis,
      AppRoutes.manualAnalysis,
      AppRoutes.reports
    ];

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          MenuWidget(titles: titles, imagePaths: imagePaths, routes: routes)
        ],
      ),
    );
  }
}
