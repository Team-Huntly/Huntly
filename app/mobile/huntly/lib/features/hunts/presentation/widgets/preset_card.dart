import 'dart:math';

import 'package:flutter/material.dart';

import '../../../../core/theme/theme.dart';

class PresetCard extends StatefulWidget {
  final String presetName;
  final int numberOfHunts;

  const PresetCard({Key? key, required this.presetName, required this.numberOfHunts})
      : super(key: key);

  @override
  State<PresetCard> createState() => _PresetCardState();
}

class _PresetCardState extends State<PresetCard> {
  @override
  Widget build(BuildContext context) {
    const borderRadius = Radius.circular(10);

  Random random = Random();

    return IntrinsicHeight(
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(topLeft: borderRadius, bottomLeft: borderRadius),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.4,
                decoration: const BoxDecoration(
                ),
                child: Image.asset(
                  'assets/images/${random.nextInt(2)}.jpg',
                ),
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(left: 10),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      topRight: borderRadius, bottomRight: borderRadius),
                  color: darkTheme.colorScheme.primary,
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          widget.presetName,
                          style: darkTheme.textTheme.headline3,
                        ),
                        Column(
                          children: [
                            Text(
                              "${widget.numberOfHunts} hunts",
                              style: TextStyle(
                                color: darkTheme.colorScheme.secondary,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 10),
                          ],
                        ),
                      ]),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
