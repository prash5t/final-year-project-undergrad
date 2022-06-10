import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:sentimento/screens/mynetwork_screen/posts_fields.dart';
import 'package:sentimento/widgets/header_clippath.dart';

class AddPostScreen extends StatelessWidget {
  const AddPostScreen({Key? key, required this.isVacancy}) : super(key: key);
  final bool isVacancy;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Material(
      child: Stack(
        children: <Widget>[
          const HeaderClipPath(times: 0.2),
          PostFields(
            isVacancy: isVacancy,
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
