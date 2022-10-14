import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:huntly/core/utils/scaffold.dart';
import 'package:huntly/features/memories/presentation/widgets/gallery_image.dart';

class GalleryPage extends StatelessWidget {
  const GalleryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return HuntlyScaffold(
      outerContext: context,
      body: Column(
        children: const [
          SizedBox(height: 30),
          GalleryImage(),
          GalleryImage(),
        ]
      ),
    );
  }
}