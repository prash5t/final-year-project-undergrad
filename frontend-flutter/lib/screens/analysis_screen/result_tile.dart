import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sentimento/screens/profile_screen/custom_shimmer.dart';

class ResultTile extends StatelessWidget {
  const ResultTile({
    required this.state,
    required this.icon,
    required this.title,
    required this.data,
    Key? key,
  }) : super(key: key);
  final String state;
  final ImageIcon icon;
  final String title;
  final String data;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      height: 70,
      width: size.width * 0.42,
      decoration: BoxDecoration(
        color: Colors.grey[350],
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        boxShadow: [
          BoxShadow(
            color: Colors.blueGrey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3),
          )
        ],
      ),
      child: Stack(
        children: <Widget>[
          Padding(
              padding: const EdgeInsets.only(top: 20, left: 12), child: icon),
          Padding(
            padding: const EdgeInsets.only(bottom: 40),
            child: Center(
              child: Text(
                title,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Center(
              child: Padding(
            padding: const EdgeInsets.only(
              top: 15.0,
            ),
            child: state == "loading"
                ? const CustomShimmer(
                    shimmerHeight: 15,
                    shimmerWidth: 90,
                    shimmerColor: Colors.tealAccent)
                : Text(
                    data,
                    style: TextStyle(fontSize: 18, color: Colors.grey[700]),
                  ),
          ))
        ],
      ),
    );
  }
}
