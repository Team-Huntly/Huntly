import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:huntly/features/memories/presentation/pages/gallery_page.dart';

import '../../../../core/theme/theme.dart';

class MemoriesMenuItem extends StatelessWidget {
  MemoriesMenuItem({Key? key}) : super(key: key);

  final Random random = Random();
  final double angleRangeMultiplier = 0.1;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const GalleryPage()));
      },
      child: Transform.rotate(
        angle: random.nextDouble() * angleRangeMultiplier,
        child: Container(
          margin: const EdgeInsets.only(top: 20),
          width: MediaQuery.of(context).size.width * 0.9,
          // height: 250,
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              image: DecorationImage(
                  image: AssetImage('assets/images/0.jpg'), fit: BoxFit.fill)),
          child: Column(
            children: [
              const SizedBox(height: 100),
              Text(
                'NITK Hunt'.toUpperCase(),
                style: darkTheme.textTheme.headline1,
              ),
              Text('16/12/11',
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
