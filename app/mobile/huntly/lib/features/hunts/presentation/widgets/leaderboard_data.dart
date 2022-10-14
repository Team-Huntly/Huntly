import 'package:flutter/material.dart';

import '../../../../core/theme/theme.dart';

class LeaderboardData extends StatelessWidget {
  final String text;

  const LeaderboardData({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: darkTheme.textTheme.headline6,
      textAlign: TextAlign.center,
    );
  }
}
