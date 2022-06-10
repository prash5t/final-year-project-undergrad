import 'package:flutter/material.dart';
import 'package:sentimento/screens/analysis_screen/analysis_fields.dart';

class TweetsScreen extends StatelessWidget {
  const TweetsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const AnalysisDetail(
      platform: "twitter",
      dataSourceTitle: "Enter a tweet topic",
      approxDataTitle: "Approximate number of tweets",
    );
  }
}
