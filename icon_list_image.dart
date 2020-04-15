import 'package:flutter/material.dart';

class IconListImage extends StatelessWidget {

  final String iconPath;

  IconListImage(this.iconPath);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 35,
      height: 35,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: Colors.white,
        image: DecorationImage(
          image: AssetImage(iconPath),
          fit: BoxFit.fitHeight,
        ),
      ),
    );
  }
}
