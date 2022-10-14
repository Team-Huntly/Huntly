import 'package:flutter/material.dart';
import 'package:huntly/features/hunts/presentation/widgets/leaderboard_data.dart';
import 'package:huntly/features/hunts/presentation/widgets/leaderboard_header.dart';

import '../../../../core/theme/theme.dart';
import '../widgets/leaderboard_row.dart';

class LeaderboardPage extends StatelessWidget {
  const LeaderboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const List<double> fractions = [
      0.1,
      0.3,
      0.21,
      0.21
    ];

    return Column(
      children: [
        const SizedBox(height: 30),
        LeaderboardRow(
          attributes: const [
            LeaderboardHeader(text: '#'),
            LeaderboardHeader(text: 'Team'),
            LeaderboardHeader(text: 'Clues'),
            LeaderboardHeader(text: 'Time')
          ],
        ),
        Divider(color: darkTheme.colorScheme.secondary, thickness: 2,),
        LeaderboardRow(attributes: const [
          LeaderboardData(text: '1'),
          LeaderboardData(text: 'Name 404'),
          LeaderboardData(text: '3'),
          LeaderboardData(text: '4:03')
        ]),
        LeaderboardRow(attributes: const [
          LeaderboardData(text: '1'),
          LeaderboardData(text: 'Hello world!'),
          LeaderboardData(text: '2'),
          LeaderboardData(text: '5:03')
        ]),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: const [
        //     LeaderboardData(fraction: 0.1, text: '#'),
        //     LeaderboardData(fraction: 0.3, text: 'Team'),
        //     LeaderboardData(fraction: 0.21, text: 'Clues'),
        //     LeaderboardData(fraction: 0.21, text: 'Time')
        //   ]
        // )
      ]
    );
  }
}