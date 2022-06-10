import 'package:flutter/material.dart';
import 'package:sentimento/screens/analysis_screen/analysis_fields.dart';

class CommentsScreen extends StatelessWidget {
  const CommentsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const AnalysisDetail(
      platform: "youtube",
      dataSourceTitle: "Enter YouTube video url",
      approxDataTitle: "Approximate number of comments",
    );
  }
}
