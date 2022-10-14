import 'package:flutter/material.dart';

class GalleryImage extends StatelessWidget {
  const GalleryImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      width: MediaQuery.of(context).size.width * 0.9,
      child: Image.asset(
        'assets/images/0.jpg',
        fit: BoxFit.fill,
      ),
    );
  }
}
