import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:sentimento/screens/profile_screen/custom_shimmer.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Neumorphic(
        child: const Center(
      child: CustomShimmer(
          shimmerHeight: 50,
          shimmerWidth: 300,
          shimmerColor: Colors.tealAccent),
    ));
  }
}
