import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../../core/theme/theme.dart';

class PresetCard extends StatefulWidget {
  String presetName;
  String noTHunts;

  PresetCard({Key? key, required this.presetName, required this.noTHunts})
      : super(key: key);

  @override
  State<PresetCard> createState() => _PresetCardState();
}

class _PresetCardState extends State<PresetCard> {
  @override
  Widget build(BuildContext context) {
    const borderRadius = Radius.circular(10);

    return IntrinsicHeight(
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                    topLeft: borderRadius, bottomLeft: borderRadius),
                color: darkTheme.colorScheme.secondary,
              ),
              child: Image.asset(
                'assets/images/preset_yoga.png',
                // width: 100,
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(left: 10),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                    topRight: borderRadius, bottomRight: borderRadius),
                color: darkTheme.colorScheme.primary,
              ),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      child: Text(
                        widget.presetName,
                        style: darkTheme.textTheme.headline3,
                      ),
                    ),
                    Column(
                      children: [
                        Container(
                          child: Text(
                            widget.noTHunts,
                            style: TextStyle(
                              color: darkTheme.colorScheme.secondary,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ]),
            ),
          )
        ],
      ),
    );
  }
}
