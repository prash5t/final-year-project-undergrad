import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sentimento/screens/profile_screen/custom_shimmer.dart';
import 'package:sentimento/screens/profile_screen/profile_icon.dart';

import 'custom_tile.dart';

class UserInfoWidget extends StatelessWidget {
  const UserInfoWidget(
      {Key? key,
      required this.dataState,
      required this.name,
      required this.email,
      required this.purpose,
      required this.analysisCount,
      required this.vacancyCount})
      : super(key: key);

  final String dataState;
  final String name;
  final String email;
  final String purpose;
  final String analysisCount;
  final String vacancyCount;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        dataState == "loading"
            ? const ProfileIcon(imgPath: "lib/assets/lgbtload.gif")
            : const ProfileIcon(imgPath: "lib/assets/user.png"),
        const SizedBox(
          height: 20,
        ),
        dataState == "loading"
            ? const CustomShimmer(
                shimmerHeight: 20, shimmerWidth: 180, shimmerColor: Colors.red)
            : Text(
                name,
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal),
              ),
        const SizedBox(
          height: 5,
        ),
        dataState == "loading"
            ? const CustomShimmer(
                shimmerHeight: 15,
                shimmerWidth: 240,
                shimmerColor: Colors.orange)
            : Text(
                email,
                style: const TextStyle(fontSize: 18, color: Colors.black54),
              ),
        const SizedBox(
          height: 40,
        ),
        ProfileTile(
            state: dataState,
            loadingColor: Colors.green,
            icon: const Icon(
              Icons.work_outline,
              size: 35,
              color: Colors.teal,
            ),
            title: "Purpose",
            titleLeftPadding: 120,
            data: purpose),
        const SizedBox(
          height: 20,
        ),
        ProfileTile(
            state: dataState,
            loadingColor: Colors.indigo,
            icon: const Icon(
              CupertinoIcons.settings,
              size: 35,
              color: Colors.teal,
            ),
            title: "Sentiment Examined",
            titleLeftPadding: 80,
            data: analysisCount),
        const SizedBox(height: 20),
        ProfileTile(
            state: dataState,
            loadingColor: Colors.purple,
            icon: const Icon(
              Icons.post_add,
              size: 35,
              color: Colors.teal,
            ),
            title: "Vacancies Posted",
            titleLeftPadding: 90,
            data: vacancyCount),
        const SizedBox(
          height: 20,
        )
      ],
    );
  }
}
