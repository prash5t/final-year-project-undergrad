import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sentimento/models/saved_report.dart';
import 'package:sentimento/screens/reports_screen/custom_linear_gauge.dart';
import 'package:sentimento/screens/reports_screen/detailed_report.dart';
import 'package:sentimento/widgets/header_clippath.dart';

class LoadedReport extends StatelessWidget {
  const LoadedReport({Key? key, required this.reports}) : super(key: key);
  final List<Reports> reports;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Material(
      child: Stack(
        children: <Widget>[
          const HeaderClipPath(times: 0.3),
          Padding(
            padding: EdgeInsets.only(
                top: size.height * 0.084, left: size.width * 0.4),
            child: Text(
              "Total: ${reports.length}",
              style: const TextStyle(fontSize: 22, color: Colors.white),
            ),
          ),
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
            padding: EdgeInsets.only(top: size.height * 0.15),
            child: Center(
              child: SingleChildScrollView(
                  child: Column(
                children: <Widget>[
                  for (int i = 0; i < reports.length; i++)
                    Padding(
                        padding: const EdgeInsets.all(10),
                        child: Container(
                          child: SingleChildScrollView(
                              child: Padding(
                            padding: const EdgeInsets.only(
                                left: 8, right: 8, top: 2),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "${reports[i].data}",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.teal),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text("${reports[i].analysisTime}"),
                                const SizedBox(
                                  height: 5,
                                ),
                                MyLinearGauge(
                                  currentPointer: double.parse(
                                      "${reports[i].overallPolarity}"),
                                ),
                                Center(
                                  // ignore: deprecated_member_use
                                  child: ButtonTheme(
                                    minWidth: double.maxFinite,
                                    height: 25,
                                    child: RaisedButton(
                                        color: Colors.grey[400],
                                        onPressed: () {
                                          showModalBottomSheet(
                                              isScrollControlled: true,
                                              shape:
                                                  const RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.vertical(
                                                              top: Radius
                                                                  .circular(
                                                                      20))),
                                              context: context,
                                              builder: (context) =>
                                                  DetailedReport(
                                                      report: reports[i]));
                                        },
                                        child: const Text(
                                          "Show Details",
                                          style: TextStyle(fontSize: 12),
                                        )),
                                  ),
                                )
                              ],
                            ),
                          )),
                          decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(8)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.blueGrey.withOpacity(0.5),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: const Offset(0, 3),
                                )
                              ]),
                          height: 132,
                          width: size.width * 0.9,
                        )),
                ],
              )),
            ),
          ),
        ],
      ),
    );
  }
}
