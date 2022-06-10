import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sentimento/screens/profile_screen/userinfo_widget.dart';
import 'package:sentimento/widgets/header_clippath.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({
    Key? key,
    required this.profileState,
    required this.name,
    required this.email,
    required this.purpose,
    required this.analysisCount,
    required this.vacancyCount,
  }) : super(key: key);

  final String profileState;
  final String name;
  final String email;
  final String purpose;
  final String analysisCount;
  final String vacancyCount;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Material(
      child: Stack(
        children: <Widget>[
          const HeaderClipPath(times: 0.3),
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(top: size.height * 0.13),
              child: Center(
                child: Column(
                  children: <Widget>[
                    const SizedBox(
                      height: 20,
                    ),
                    UserInfoWidget(
                        dataState: profileState,
                        name: name,
                        email: email,
                        purpose: purpose,
                        analysisCount: analysisCount,
                        vacancyCount: vacancyCount)
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
