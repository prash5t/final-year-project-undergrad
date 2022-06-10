import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:sentimento/api/analysis_requests.dart';
import 'package:sentimento/screens/analysis_screen/result_tile.dart';
import 'package:sentimento/screens/profile_screen/custom_shimmer.dart';
import 'package:sentimento/utilities/routes.dart';

class SentimentResult extends StatelessWidget {
  const SentimentResult(
      {Key? key,
      required this.resultState,
      this.platform,
      this.thumbnail,
      this.title,
      this.totalData,
      this.spamCount,
      this.sarcasmCount,
      this.positiveCount,
      this.negativeCount,
      this.neutralCount,
      this.overallPolarity})
      : super(key: key);
  final String resultState;
  final String? platform;
  final String? thumbnail;
  final String? title;
  final String? totalData;
  final String? spamCount;
  final String? sarcasmCount;
  final String? positiveCount;
  final String? negativeCount;
  final String? neutralCount;
  final String? overallPolarity;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Neumorphic(
      child: Stack(
        children: <Widget>[
          // const HeaderClipPath(times: 0.16),
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(top: size.height * 0.02),
              child: Column(
                children: <Widget>[
                  resultState == "loading"
                      ? const CustomShimmer(
                          shimmerHeight: 150,
                          shimmerWidth: 300,
                          shimmerColor: Colors.tealAccent)
                      : Container(
                          child: CachedNetworkImage(
                            fit: BoxFit.fill,
                            imageUrl: thumbnail!,
                            placeholder: (context, url) => const CustomShimmer(
                                shimmerHeight: 150,
                                shimmerWidth: 300,
                                shimmerColor: Colors.tealAccent),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          ),
                          height: 150,
                          width: 300,
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.blueGrey.withOpacity(0.8),
                                  spreadRadius: 25,
                                  blurRadius: 15,
                                  offset: const Offset(0, 0),
                                )
                              ],
                              border: Border.all(
                                  color: Colors.tealAccent, width: 3)),
                        ),
                  const SizedBox(
                    height: 20,
                  ),
                  resultState == "loading"
                      ? const CustomShimmer(
                          shimmerHeight: 20,
                          shimmerWidth: 180,
                          shimmerColor: Colors.tealAccent)
                      : Text(title!,
                          style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.teal)),
                  const SizedBox(
                    height: 5,
                  ),
                  resultState == "loading"
                      ? const CustomShimmer(
                          shimmerHeight: 15,
                          shimmerWidth: 240,
                          shimmerColor: Colors.tealAccent)
                      : Text(
                          "Scanned $totalData data",
                          style: const TextStyle(
                              fontSize: 18, color: Colors.black54),
                        ),
                  const SizedBox(
                    height: 40,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      ResultTile(
                          state: resultState,
                          icon: const ImageIcon(
                            AssetImage(
                              "lib/assets/spam.png",
                            ),
                            size: 35,
                            color: Colors.teal,
                          ),
                          title: "Spam",
                          data: "$spamCount"),
                      const SizedBox(
                        width: 20,
                      ),
                      ResultTile(
                          state: resultState,
                          icon: const ImageIcon(
                            AssetImage("lib/assets/sarcastic.png"),
                            size: 35,
                            color: Colors.teal,
                          ),
                          title: "Sarcastic",
                          data: "$sarcasmCount")
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      ResultTile(
                          state: resultState,
                          icon: const ImageIcon(
                            AssetImage("lib/assets/happy.png"),
                            size: 35,
                            color: Colors.teal,
                          ),
                          title: "Positive",
                          data: "$positiveCount"),
                      const SizedBox(
                        width: 20,
                      ),
                      ResultTile(
                          state: resultState,
                          icon: const ImageIcon(
                              AssetImage("lib/assets/angry.png"),
                              size: 35,
                              color: Colors.teal),
                          title: "Negative",
                          data: "$negativeCount")
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      ResultTile(
                          state: resultState,
                          icon: const ImageIcon(
                              AssetImage("lib/assets/neutral.png"),
                              size: 35,
                              color: Colors.teal),
                          title: "Neutral",
                          data: "$neutralCount"),
                      const SizedBox(
                        width: 20,
                      ),
                      ResultTile(
                          state: resultState,
                          icon: const ImageIcon(
                              AssetImage("lib/assets/rating.png"),
                              size: 35,
                              color: Colors.teal),
                          title: "Polarity",
                          data: "$overallPolarity")
                    ],
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      resultState == "loading"
                          ? const CustomShimmer(
                              shimmerHeight: 30,
                              shimmerWidth: 50,
                              shimmerColor: Colors.tealAccent)
                          : GestureDetector(
                              onTap: () {
                                saveSentimentReport(
                                    platform,
                                    title,
                                    totalData,
                                    spamCount,
                                    sarcasmCount,
                                    positiveCount,
                                    negativeCount,
                                    neutralCount,
                                    overallPolarity);
                                Navigator.pushNamedAndRemoveUntil(context,
                                    AppRoutes.homescreen, (route) => false);
                              },
                              child: Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color:
                                              Colors.blueGrey.withOpacity(0.5),
                                          spreadRadius: 5,
                                          blurRadius: 7,
                                          offset: const Offset(0, 3),
                                        )
                                      ],
                                      color: Colors.teal,
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(100))),
                                  child: const Icon(Icons.save_alt,
                                      color: Colors.white)),
                            ),
                      const SizedBox(
                        width: 30,
                      ),
                      resultState == "loading"
                          ? const CustomShimmer(
                              shimmerHeight: 30,
                              shimmerWidth: 50,
                              shimmerColor: Colors.tealAccent)
                          : GestureDetector(
                              onTap: () {
                                Navigator.pushNamedAndRemoveUntil(context,
                                    AppRoutes.homescreen, (route) => false);
                              },
                              child: Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color:
                                              Colors.blueGrey.withOpacity(0.5),
                                          spreadRadius: 5,
                                          blurRadius: 7,
                                          offset: const Offset(0, 3),
                                        )
                                      ],
                                      color: Colors.teal,
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(100))),
                                  child: const Icon(Icons.close,
                                      color: Colors.white)),
                            ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
