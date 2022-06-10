import 'package:flutter/material.dart';

class ProfileIcon extends StatelessWidget {
  const ProfileIcon({
    required this.imgPath,
    Key? key,
  }) : super(key: key);

  final String imgPath;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: CircleAvatar(
        backgroundImage: AssetImage(imgPath),
        backgroundColor: Colors.transparent,
      ),
      height: 170,
      width: 170,
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.8),
              spreadRadius: 11,
              blurRadius: 10,
              offset: const Offset(0, 0),
            ),
          ],
          borderRadius: BorderRadius.circular(100),
          border: Border.all(color: Colors.white, width: 3)),
    );
  }
}
