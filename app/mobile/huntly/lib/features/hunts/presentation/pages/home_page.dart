import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:huntly/features/hunts/presentation/widgets/hunt_card.dart';
import 'package:huntly/core/utils/scaffold.dart';

import '../../../../core/theme/theme.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return HuntlyScaffold(
        body: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          "Hello!",
          style: darkTheme.textTheme.overline,
        ),
        Text(
          'John Doe',
          style: darkTheme.textTheme.headline2,
        ),
        HuntCard(
            title: "Manipal Institute of Technology Hunt!",
            location: "MIT Udupi",
            seatsLeft: 5,
            start: DateTime(2022, 9, 5, 17, 30))
      ]),
    ));
  }
}
