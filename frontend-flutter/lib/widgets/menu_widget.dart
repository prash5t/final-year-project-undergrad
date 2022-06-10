import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:sentimento/widgets/minor_ui_parts.dart';

class MenuWidget extends StatelessWidget {
  final List<String> titles;
  final List<String> imagePaths;
  final List<String> routes;

  const MenuWidget(
      {Key? key,
      required this.titles,
      required this.imagePaths,
      required this.routes})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Column(
      children: [
        SizedBox(
          height: size.height - size.height * 0.27,
          child: Padding(
            padding: EdgeInsets.only(
                left: size.width * 0.1,
                right: size.width * 0.1,
                top: size.height * 0.1,
                bottom: size.height * 0.1),
            child: GridView(
              children: <Widget>[
                for (int i = 0; i < titles.length; i++)
                  MenuItem(
                      title: titles[i],
                      imgPath: imagePaths[i],
                      route: routes[i]),
              ],
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: size.width < 425 ? 2 : 4,
                  mainAxisSpacing: size.height * 0.03,
                  crossAxisSpacing: size.width * 0.03),
            ),
          ),
        ),
      ],
    );
  }
}

class MenuItem extends StatelessWidget {
  final String title;
  final String imgPath;
  final String route;
  const MenuItem(
      {Key? key,
      required this.title,
      required this.imgPath,
      required this.route})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        FlutterSecureStorage? secureStorage = const FlutterSecureStorage();
        String? yKey = await secureStorage.read(key: 'red-key');
        if (yKey == null) {
          manualToastMsg("Please enter your coupan or keys first");
        } else {
          Navigator.pushNamed(context, route);
        }
      },
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), color: Colors.grey[300]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(imgPath),
            const SizedBox(
              height: 10,
            ),
            Text(
              title,
            )
          ],
        ),
      ),
    );
  }
}
