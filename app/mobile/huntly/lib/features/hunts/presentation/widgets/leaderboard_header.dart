import 'package:flutter/material.dart';

import '../../../../core/theme/theme.dart';

class LeaderboardHeader extends StatelessWidget {
  final String text;

  const LeaderboardHeader({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: darkTheme.textTheme.headline5,
      textAlign: TextAlign.center,
    );
  }
}
