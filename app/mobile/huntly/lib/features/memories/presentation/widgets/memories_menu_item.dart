import 'dart:math';

import 'package:flutter/material.dart';
import 'package:huntly/features/memories/presentation/pages/gallery_page.dart';
import 'package:intl/intl.dart';

import '../../../../common/constants.dart';
import '../../../../core/theme/theme.dart';
import '../../data/models/memory_model.dart';

class MemoriesMenuItem extends StatelessWidget {
  final Random random = Random();
  final double angleRangeMultiplier = 0.1;

  final MemoryModel memory;

  MemoriesMenuItem({Key? key, required this.memory}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => GalleryPage(memory: memory)));
      },
      child: Transform.rotate(
        angle: random.nextDouble() * angleRangeMultiplier,
        child: Container(
          margin: const EdgeInsets.only(top: 20),
          width: MediaQuery.of(context).size.width * 0.9,
          // height: 250,
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              image: DecorationImage(
                  image: NetworkImage('$url${memory.images[0]}'),
                  fit: BoxFit.fill)),
          child: Column(
            children: [
              const SizedBox(height: 100),
              Text(
                memory.huntName,
                style: darkTheme.textTheme.headline1!.copyWith(fontSize: 24),
              ),
              Text(DateFormat.yMd().format(memory.startedAt),
                  style: darkTheme.textTheme.headline3!
                      .copyWith(color: darkTheme.colorScheme.secondary)),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
