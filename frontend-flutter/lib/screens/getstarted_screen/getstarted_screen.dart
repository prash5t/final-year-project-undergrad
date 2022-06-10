import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:sentimento/utilities/routes.dart';
import 'package:sentimento/widgets/header_clippath.dart';

class GetStartedScreen extends StatelessWidget {
  const GetStartedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Neumorphic(
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            const HeaderClipPath(times: 0.51),
            SizedBox(
              height: size.height * 0.5,
              width: double.maxFinite,
              //color: Colors.red,
              child: Image.asset(
                "lib/assets/icon.PNG",
                fit: BoxFit.contain,
              ),
            ),
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: size.height * 0.53,
                  ),
                  NeumorphicText(
                    "Sentimento",
                    style: const NeumorphicStyle(
                      depth: 20,
                      color: Colors.black,
                      shape: NeumorphicShape.concave,
                    ),
                    textStyle: NeumorphicTextStyle(
                        fontWeight: FontWeight.bold, fontSize: 30),
                  ),
                  const Center(
                    child: SizedBox(
                      height: 10,
                    ),
                  ),
                  Text(
                    "Bringing data science tool in your hand",
                    style: TextStyle(
                        fontSize: 17,
                        fontStyle: FontStyle.italic,
                        color: Colors.black.withOpacity(0.7)),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 24.0, right: 24),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  // color: Colors.red,just for debugging check
                  width: double.maxFinite,
                  height: 150,
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        const SizedBox(
                          height: 20,
                        ),
                        ElevatedButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, AppRoutes.loginscreen);
                            },
                            child: const Text(
                              "Login",
                              style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            style: TextButton.styleFrom(
                                //backgroundColor: Colors.pink,
                                minimumSize: const Size(double.maxFinite, 44))),
                        const SizedBox(
                          height: 10,
                        ),
                        ElevatedButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, AppRoutes.registerscreen);
                            },
                            child: const Text(
                              "Sign up",
                              style: TextStyle(
                                  fontSize: 17,
                                  //fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            style: TextButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                minimumSize: const Size(double.maxFinite, 44))),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
