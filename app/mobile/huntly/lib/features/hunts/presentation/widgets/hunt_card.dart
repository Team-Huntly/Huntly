import 'package:flutter/cupertino.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class HuntCard extends StatelessWidget {
  final String title;
  final String location;
  final int seatsLeft;
  final DateTime start;

  const HuntCard({
    Key? key,
    required this.title,
    required this.location,
    required this.seatsLeft,
    required this.start}
  ) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text()
            ],
          )
        ],
      )
    );
  }
}
