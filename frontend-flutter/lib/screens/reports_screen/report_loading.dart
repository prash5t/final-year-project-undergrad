import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:sentimento/widgets/header_clippath.dart';

class ReportLoading extends StatelessWidget {
  const ReportLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Material(
      child: Stack(children: <Widget>[
        const HeaderClipPath(times: 0.3),
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
          padding: EdgeInsets.only(top: size.height * 0.31),
          child: SizedBox(
            height: size.height * 0.55,
            width: size.width,
            child: Image.asset(
              "lib/assets/chartload.gif",
              fit: BoxFit.fill,
            ),
          ),
        ),
      ]),
    );
  }
}
