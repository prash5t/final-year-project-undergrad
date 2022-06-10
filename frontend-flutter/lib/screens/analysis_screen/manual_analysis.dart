import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:sentimento/api/analysis_requests.dart';
import 'package:sentimento/screens/analysis_screen/manual_radial_gauge.dart';
import 'package:sentimento/screens/profile_screen/custom_shimmer.dart';
import 'package:sentimento/widgets/header_clippath.dart';

class ManualAnalysis extends StatefulWidget {
  const ManualAnalysis({Key? key}) : super(key: key);

  @override
  _ManualAnalysisState createState() => _ManualAnalysisState();
}

class _ManualAnalysisState extends State<ManualAnalysis> {
  double currentPolarity = 0.0;
  String currentSentence = "";
  bool isLoading = false;
  final _sentenceKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Material(
      child: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            const HeaderClipPath(times: 0.4),
            Padding(
              padding: EdgeInsets.only(top: size.height * 0.06, left: 20),
              child: IconButton(
                  color: Colors.white,
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(
                    CupertinoIcons.back,
                    size: 40,
                  )),
            ),
            Padding(
              padding: EdgeInsets.only(top: size.height * 0.2),
              child: Padding(
                padding: const EdgeInsets.only(left: 30, right: 30),
                child: Column(
                  children: [
                    ManualRadialGauge(
                      currentPolarity: currentPolarity,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Form(
                      key: _sentenceKey,
                      child: TextFormField(
                        onChanged: (val) {
                          setState(() {
                            currentSentence = val;
                          });
                        },
                        validator: (value) {
                          if (value!.length < 3) {
                            return "Too short";
                          }
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        maxLength: 500,
                        decoration: const InputDecoration(
                            hintText: "Enter your sentence or paragraph"),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    isLoading == true
                        ? const CustomShimmer(
                            shimmerHeight: 40,
                            shimmerWidth: double.infinity,
                            shimmerColor: Colors.tealAccent)
                        : ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15))),
                            onPressed: () async {
                              if (_sentenceKey.currentState!.validate()) {
                                double obtainedPolarity =
                                    await requestManualSentiment(
                                        currentSentence);
                                setState(() {
                                  isLoading = true;
                                  currentPolarity = obtainedPolarity;
                                  isLoading = false;
                                });
                              }
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.blueGrey.withOpacity(0.5),
                                    spreadRadius: 9,
                                    blurRadius: 8,
                                    offset: const Offset(0, 3),
                                  )
                                ],
                              ),
                              width: double.infinity,
                              height: 42,
                              child: const Center(
                                  child: Text(
                                "Check Polarity",
                                style: TextStyle(fontSize: 18),
                              )),
                            ),
                          ),
                    SizedBox(
                      height: size.height * 0.3,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
