import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sentimento/bloc/coupans_bloc.dart/coupan_bloc.dart';
import 'package:sentimento/utilities/routes.dart';
import 'package:sentimento/utilities/securestorage.dart';
import 'package:sentimento/utilities/validators.dart';
import 'package:sentimento/widgets/minor_ui_parts.dart';

class CoupansMenu extends StatefulWidget {
  const CoupansMenu({Key? key}) : super(key: key);

  @override
  _CoupansMenuState createState() => _CoupansMenuState();
}

class _CoupansMenuState extends State<CoupansMenu> {
  final _coupansKey = GlobalKey<FormState>();
  TextEditingController youtube = TextEditingController();
  //these are for youtube and twitter api keys
  TextEditingController consumerKey = TextEditingController();
  TextEditingController consumerSecret = TextEditingController();
  TextEditingController accessToken = TextEditingController();
  TextEditingController accessTokenSecret = TextEditingController();

  //List<String> savedCoupans = [];
  // takeData() async {
  //   savedCoupans = await getStoredCoupans();
  //   youtube = TextEditingController(text: savedCoupans[0]);
  //   consumerKey = TextEditingController(text: savedCoupans[1]);
  //   consumerSecret = TextEditingController(text: savedCoupans[2]);
  //   accessToken = TextEditingController(text: savedCoupans[3]);
  //   accessTokenSecret = TextEditingController(text: savedCoupans[4]);
  // }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (context) => CoupanBloc(InitialState())..add(InitialEvent()),
      child: BlocBuilder<CoupanBloc, CoupanState>(
        builder: (context, state) {
          if (state is CoupansState) {
            youtube = TextEditingController(text: state.yKey);
            consumerKey = TextEditingController(text: state.ck);
            consumerSecret = TextEditingController(text: state.cs);
            accessToken = TextEditingController(text: state.at);
            accessTokenSecret = TextEditingController(text: state.ats);
            return SingleChildScrollView(
              child: Form(
                key: _coupansKey,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Column(
                    children: <Widget>[
                      const FieldHeader(
                        title: "YouTube Information",
                      ),
                      KeysTextField(
                        textController: youtube,
                        fieldLabel: "API Key",
                        hintData: youtube.text,
                      ),
                      SizedBox(
                        height: size.height * 0.04,
                      ),
                      const FieldHeader(title: "Twitter Information"),
                      CoupansTextField(
                        textController: consumerKey,
                        fieldLabel: "Consumer Key",
                        hintData: consumerKey.text,
                      ),
                      CoupansTextField(
                        textController: consumerSecret,
                        fieldLabel: "Consumet Secret Key",
                        hintData: consumerSecret.text,
                      ),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      CoupansTextField(
                        textController: accessToken,
                        fieldLabel: "Access Token Key",
                        hintData: accessToken.text,
                      ),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      CoupansTextField(
                        textController: accessTokenSecret,
                        fieldLabel: "Access Token Secret Key",
                        hintData: accessTokenSecret.text,
                      ),
                      SizedBox(
                        height: size.height * 0.01,
                      ),
                      ElevatedButton(
                          onPressed: () async {
                            if (_coupansKey.currentState!.validate()) {
                              await saveUserKeys(
                                  youtube.text,
                                  consumerKey.text,
                                  consumerSecret.text,
                                  accessToken.text,
                                  accessTokenSecret.text);
                              manualToastMsg("Updated successfully");
                              Navigator.pushNamedAndRemoveUntil(context,
                                  AppRoutes.homescreen, (route) => false);
                            }
                          },
                          child: const Text("Update"))
                    ],
                  ),
                ),
              ),
            );
          }
          return showLoading(context);
        },
      ),
    );
  }
}

class FieldHeader extends StatelessWidget {
  const FieldHeader({
    Key? key,
    required this.title,
  }) : super(key: key);
  final String title;
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 32,
      width: double.maxFinite,
      color: Colors.grey[300],
      child: Text(title,
          style: const TextStyle(
              fontWeight: FontWeight.bold, color: Colors.teal, fontSize: 18)),
    );
  }
}

class KeysTextField extends StatelessWidget {
  const KeysTextField(
      {Key? key,
      required this.textController,
      required this.fieldLabel,
      required this.hintData})
      : super(key: key);

  final TextEditingController textController;
  final String fieldLabel;
  final String? hintData;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textController,
      keyboardType: TextInputType.text,
      validator: (value) {
        return TextFieldValidator.keyValidator(value);
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        labelText: fieldLabel,
        //hintText: hintData,
      ),
    );
  }
}

class CoupansTextField extends StatefulWidget {
  const CoupansTextField(
      {Key? key,
      required this.textController,
      required this.fieldLabel,
      required this.hintData})
      : super(key: key);

  final TextEditingController textController;
  final String fieldLabel;
  final String? hintData;

  @override
  _CoupansTextFieldState createState() => _CoupansTextFieldState();
}

class _CoupansTextFieldState extends State<CoupansTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.textController,
      keyboardType: TextInputType.text,
      validator: (value) {
        return TextFieldValidator.keyValidator(value);
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        labelText: widget.fieldLabel,
        hintText: widget.hintData,
      ),
    );
  }
}
