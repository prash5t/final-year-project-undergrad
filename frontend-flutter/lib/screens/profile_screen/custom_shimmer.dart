import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CustomShimmer extends StatelessWidget {
  const CustomShimmer({
    Key? key,
    required this.shimmerHeight,
    required this.shimmerWidth,
    required this.shimmerColor,
  }) : super(key: key);
  final double shimmerHeight;
  final double shimmerWidth;
  final Color shimmerColor;
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        child: Container(
          decoration: BoxDecoration(
              //color: Colors.grey,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 5,
                  offset: const Offset(0, 0),
                ),
              ]),
          height: shimmerHeight,
          width: shimmerWidth,
          //color: Colors.grey,
        ),
        baseColor: Colors.teal,
        highlightColor: shimmerColor);
  }
}
