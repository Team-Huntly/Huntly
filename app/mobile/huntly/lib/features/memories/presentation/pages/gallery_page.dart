import 'package:flutter/material.dart';
import 'package:huntly/core/utils/scaffold.dart';
import 'package:huntly/features/memories/presentation/widgets/gallery_image.dart';

import '../../data/models/memory_model.dart';

class GalleryPage extends StatelessWidget {
  final MemoryModel memory;

  const GalleryPage({Key? key, required this.memory}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return HuntlyScaffold(
      outerContext: context,
      body: SingleChildScrollView(
        child: Column(children: [
          const SizedBox(height: 30),
          ListView.builder(
            shrinkWrap: true,
            itemCount: memory.images.length,
            itemBuilder: (context, index) {
              return GalleryImage(image: memory.images[index]);
            }
          ),
        ]),
      ),
    );
  }
}
