import 'package:flutter/material.dart';

class DisplayImage extends StatelessWidget {
  final String imagePath;

  const DisplayImage({
    Key? key,
    required this.imagePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const color = Colors.lightBlue;
    return Center(child: buildImage(color));
  }

  Widget buildImage(Color color) {
    final image = AssetImage(imagePath);

    return CircleAvatar(
      radius: 75,
      backgroundColor: color,
      child: CircleAvatar(
        backgroundImage: image,
        radius: 70,
      ),
    );
  }

  Widget buildCircle({
    required Widget child,
    required double all,
  }) =>
      ClipOval(
          child: Container(
        padding: EdgeInsets.all(all),
        color: Colors.white,
        child: child,
      ));
}
