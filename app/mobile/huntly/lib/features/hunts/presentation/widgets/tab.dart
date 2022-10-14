import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class HuntTab extends StatelessWidget {
  final Color color;

  const HuntTab({Key? key, required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 20,
      height: 20,
      decoration: BoxDecoration(
          color: color.withAlpha(100),
          borderRadius: const BorderRadius.all(Radius.circular(100))),
    );
  }
}
