import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:sentimento/screens/analysis_screen/analysis_widget.dart';
import 'package:sentimento/screens/home_screen/header_user_info.dart';
import 'package:sentimento/screens/mycoupans_screen/mycoupan_widget.dart';
import 'package:sentimento/screens/mynetwork_screen/mynetwork_widget.dart';
import 'package:sentimento/utilities/routes.dart';
import 'package:sentimento/utilities/securestorage.dart';
import 'package:sentimento/widgets/header_clippath.dart';
import 'package:sentimento/widgets/minor_ui_parts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;
  final menuItems = const [AnalysisMenu(), NetworksMenu(), CoupansMenu()];

  bool clickedSingout = false;

  signOut(BuildContext context) async {
    setState(() {
      clickedSingout = true;
    });
    await Future.delayed(const Duration(milliseconds: 800));
    await deleteLoginTokens();
    manualToastMsg("Logged out succesfully");
    await Navigator.pushNamedAndRemoveUntil(
        context, AppRoutes.loginscreen, (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (index) => setState(() => currentIndex = index),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.settings_solid),
              label: 'Analysis',
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.person_2),
              label: 'My Network',
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.gift),
              label: 'My Coupans',
            )
          ]),
      body: Stack(
        children: <Widget>[
          const HeaderClipPath(times: 0.2),
          const UserHeaderInfo(),
          Padding(
            padding: EdgeInsets.only(top: size.height * 0.075),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                    iconSize: size.height * 0.05,
                    onPressed: () {
                      Navigator.pushNamed(context, AppRoutes.profilescreen);
                    },
                    icon: const Icon(
                      Icons.person_pin_rounded,
                      color: Colors.white,
                    )),
                IconButton(
                    iconSize: size.height * 0.05,
                    onPressed: () => signOut(context),
                    icon: clickedSingout
                        ? showLoading(context)
                        : const Icon(
                            Icons.logout,
                            color: Colors.white,
                          ))
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: size.height * 0.21),
            child: SizedBox(
              height: size.height * 2,
              child: IndexedStack(
                index: currentIndex,
                children: menuItems,
              ),
            ),
          ),
          currentIndex == 1
              ? Padding(
                  padding: EdgeInsets.only(
                      left: size.width * 0.1,
                      top: size.width < 420
                          ? size.height * 0.23
                          : size.height * 0.21,
                      right: size.width * 0.1),
                  child: ListTile(
                    onTap: () async {
                      FlutterSecureStorage? secureStorage =
                          const FlutterSecureStorage();
                      String? yKey = await secureStorage.read(key: 'red-key');
                      if (yKey == null) {
                        manualToastMsg(
                            "Please enter your coupan or keys first");
                      } else {
                        Navigator.pushNamed(context, AppRoutes.myPosts);
                      }
                    },
                    tileColor: Colors.grey[300],
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                    leading: Image.asset("lib/assets/mypost.png"),
                    trailing: const Icon(CupertinoIcons.forward),
                    title: const Text("My Posts"),
                  ))
              : const Text(""),
        ],
      ),
    );
  }
}
