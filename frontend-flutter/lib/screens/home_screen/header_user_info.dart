import 'package:flutter/material.dart';
import 'package:sentimento/utilities/securestorage.dart';

class UserHeaderInfo extends StatelessWidget {
  const UserHeaderInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Padding(
        padding: EdgeInsets.only(left: 15, top: size.height * 0.06),
        child: SizedBox(
          //color: Colors.red,
          height: size.height * 0.1,
          width: size.width * 0.6,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "$name",
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "$email",
                style: const TextStyle(fontStyle: FontStyle.italic),
              )
            ],
          ),
        ));
  }
}
