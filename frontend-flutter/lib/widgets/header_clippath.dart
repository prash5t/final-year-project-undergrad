import 'package:flutter/material.dart';
import 'package:sentimento/widgets/header_clipper.dart';

class HeaderClipPath extends StatelessWidget {
  final double times;

  const HeaderClipPath({Key? key, required this.times}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return ClipPath(
        clipper: HeaderClipper(),
        child: Container(
          height: size.height * times,
          decoration: const BoxDecoration(
              //color: Color(0xFF827BE5),

              gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                Colors.teal,
                Colors.tealAccent
              ]) //colors: [Color(0xFF827BE5), Color(0xFF0072b1)])),
              ),
        ));
  }
}
