import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sentimento/screens/profile_screen/custom_shimmer.dart';

class ProfileTile extends StatelessWidget {
  const ProfileTile({
    required this.state,
    required this.icon,
    required this.title,
    required this.titleLeftPadding,
    required this.data,
    required this.loadingColor,
    Key? key,
  }) : super(key: key);
  final String state;
  final Icon icon;
  final String title;
  final double titleLeftPadding;
  final String data;
  final Color loadingColor;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      width: 300,
      decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(
              color: Colors.blueGrey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3),
            )
          ]),
      child: Stack(
        children: <Widget>[
          Padding(
              padding: const EdgeInsets.only(top: 20, left: 20), child: icon),
          Padding(
            padding: EdgeInsets.only(top: 7.0, left: titleLeftPadding),
            child: Text(
              title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Center(
              child: Padding(
            padding: const EdgeInsets.only(top: 15.0),
            child: state == "loading"
                ? CustomShimmer(
                    shimmerHeight: 15,
                    shimmerWidth: 150,
                    shimmerColor: loadingColor)
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
