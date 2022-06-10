import 'package:flutter/material.dart';
import 'package:sentimento/models/saved_report.dart';
import 'package:sentimento/screens/reports_screen/individual_tile.dart';

class DetailedReport extends StatelessWidget {
  const DetailedReport({Key? key, required this.report}) : super(key: key);

  final Reports report;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          ImageIcon(
            AssetImage(report.platform == "youtube"
                ? "lib/assets/comments.png"
                : "lib/assets/tweets.png"),
            size: 50,
            color: Colors.teal,
          ),
          const SizedBox(
            height: 20,
          ),
          Text(report.data!,
              style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal)),
          const SizedBox(
            height: 5,
          ),
          Text(
            "Scanned ${report.dataCount} data",
            style: const TextStyle(fontSize: 18, color: Colors.black54),
          ),
          const SizedBox(
            height: 40,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              IndividualTile(
                  icon: const ImageIcon(
                    AssetImage(
                      "lib/assets/spam.png",
                    ),
                    size: 35,
                    color: Colors.teal,
                  ),
                  title: "Spam",
                  data: report.spamCount.toString()),
              const SizedBox(
                width: 20,
              ),
              IndividualTile(
                  icon: const ImageIcon(
                    AssetImage("lib/assets/sarcastic.png"),
                    size: 35,
                    color: Colors.teal,
                  ),
                  title: "Sarcastic",
                  data: report.sarcasmCount.toString())
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              IndividualTile(
                  icon: const ImageIcon(
                    AssetImage("lib/assets/happy.png"),
                    size: 35,
                    color: Colors.teal,
                  ),
                  title: "Positive",
                  data: report.positiveCount.toString()),
              const SizedBox(
                width: 20,
              ),
              IndividualTile(
                  icon: const ImageIcon(AssetImage("lib/assets/angry.png"),
                      size: 35, color: Colors.teal),
                  title: "Negative",
                  data: report.negativeCount.toString())
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              IndividualTile(
                  icon: const ImageIcon(AssetImage("lib/assets/neutral.png"),
                      size: 35, color: Colors.teal),
                  title: "Neutral",
                  data: report.neutralCount.toString()),
              const SizedBox(
                width: 20,
              ),
              IndividualTile(
                  icon: const ImageIcon(AssetImage("lib/assets/rating.png"),
                      size: 35, color: Colors.teal),
                  title: "Polarity",
                  data: report.overallPolarity.toString())
            ],
          ),
          const SizedBox(
            height: 40,
          ),
        ],
      ),
    );
  }
}
