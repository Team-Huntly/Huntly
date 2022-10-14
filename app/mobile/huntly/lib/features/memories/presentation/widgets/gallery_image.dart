import 'package:flutter/material.dart';

import '../../../../common/constants.dart';

class GalleryImage extends StatelessWidget {
  final String image;

  const GalleryImage({Key? key, required this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      width: MediaQuery.of(context).size.width * 0.9,
      child: Image.network(
        '$url$image',
        fit: BoxFit.fill,
      ),
    );
  }
}
