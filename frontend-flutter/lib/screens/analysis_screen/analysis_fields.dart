import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sentimento/screens/analysis_screen/analysis_result.dart';
import 'package:sentimento/utilities/validators.dart';
import 'package:sentimento/widgets/header_clippath.dart';

class AnalysisDetail extends StatefulWidget {
  const AnalysisDetail(
      {Key? key,
      required this.platform,
      required this.dataSourceTitle,
      required this.approxDataTitle})
      : super(key: key);

  final String platform;
  final String dataSourceTitle;
  final String approxDataTitle;
  @override
  _AnalysisDetailState createState() => _AnalysisDetailState();
}

class _AnalysisDetailState extends State<AnalysisDetail> {
  final _fieldKey = GlobalKey<FormState>();
  TextEditingController sourceField = TextEditingController();
  TextEditingController numField = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Material(
      child: Stack(
        children: <Widget>[
          const HeaderClipPath(times: 0.5),
          SizedBox(
            height: size.height * 0.5,
            width: double.maxFinite,
            child: Image.asset(
              "lib/assets/icon.PNG",
              fit: BoxFit.contain,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: SingleChildScrollView(
              child: Form(
                key: _fieldKey,
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: size.height * 0.55,
                    ),
                    TextFormField(
                      controller: sourceField,
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        return TextFieldValidator.dataSourceValidator(
                            value, widget.platform);
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: InputDecoration(
                          labelText: widget.dataSourceTitle,
                          suffixIcon: const Icon(Icons.source_outlined)),
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    TextFormField(
                      controller: numField,
                      keyboardType: TextInputType.number,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        return TextFieldValidator.numOfDataValidator(value);
                      },
                      decoration: InputDecoration(
                          labelText: widget.approxDataTitle,
                          suffixIcon: const Icon(Icons.format_list_numbered)),
                    ),
                    SizedBox(
                      height: size.height * 0.04,
                    ),
                    ButtonTheme(
                      minWidth: double.maxFinite,
                      height: 40,
                      child: RaisedButton(
                        onPressed: () {
                          if (_fieldKey.currentState!.validate()) {
                            showModalBottomSheet(
                                isScrollControlled: true,
                                shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(50))),
                                context: context,
                                builder: (context) => AnalysisResult(
                                    platform: widget.platform,
                                    dataSource: sourceField.text,
                                    approxData: numField.text));
                          }
                        },
                        child: const Text(
                          "Analyse",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.3,
                    ),
                  ],
                ),
              ),
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
        ],
      ),
    );
  }
}
