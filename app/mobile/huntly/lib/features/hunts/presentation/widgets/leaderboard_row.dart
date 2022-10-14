import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class LeaderboardRow extends StatelessWidget {
  static const List<double> fractions = [
    0.1,
    0.3,
    0.21,
    0.21
  ];

  final List<Widget> attributes;
  
  LeaderboardRow({
    Key? key,
    required this.attributes
  }) : super(key: key) {
    assert(attributes.length == fractions.length);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: attributes.map<Widget>((attribute) => Container(
          width: MediaQuery.of(context).size.width * fractions[attributes.indexOf(attribute)],
          child: attribute,
          // width: MediaQuery.of(context).size.width * fractions[]),
        )).toList()
      ),
    );
  }
}