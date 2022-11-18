import 'package:flutter/material.dart';
import 'package:huntly/core/utils/action_button.dart';
import 'package:huntly/features/hunts/domain/entities/treasure_hunt.dart';
import 'package:huntly/features/hunts/presentation/bloc/treasurehunt_bloc.dart';
import 'package:huntly/features/hunts/presentation/widgets/leaderboard_header.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:iconify_flutter/icons/mi.dart';

import '../../../../core/theme/theme.dart';
import '../widgets/leaderboard_data.dart';
import '../widgets/leaderboard_row.dart';
import '../bloc/treasurehunt_bloc.dart';

class LeaderboardPage extends StatefulWidget {
  final TreasureHunt treasureHunt;

  const LeaderboardPage({Key? key, required this.treasureHunt})
      : super(key: key);

  @override
  State<LeaderboardPage> createState() => _LeaderboardPageState();
}

class _LeaderboardPageState extends State<LeaderboardPage> {
  @override
  void initState() {
    BlocProvider.of<TreasureHuntBloc>(context)
        .add(GetLeaderboard(widget.treasureHunt.id));
    super.initState();
  }
// Padding(
//                       padding: const EdgeInsets.only(top: 8.0),
//                       child: ListView.builder(
//                         shrinkWrap: true,
//                         itemCount: state.leaderboard.leaders.length,
//                         itemBuilder: (context, index) {
//                           final Duration duration = state
//                               .leaderboard.leaders[index].lastSolved
//                               .difference(widget.treasureHunt.started_at);
//                           return LeaderboardRow(attributes: [
//                             LeaderboardData(text: index.toString()),
//                             LeaderboardData(
//                                 text: state.leaderboard.leaders[index].name),
//                             LeaderboardData(
//                                 text: state
//                                     .leaderboard.leaders[index].cluesSolved
//                                     .toString()),
//                             LeaderboardData(
//                                 text:
//                                     "${duration.inHours}:${duration.inMinutes.remainder(minutesInHours)}")
//                           ]);
//                         },
//                       ),
//                     );

  @override
  Widget build(BuildContext context) {
    const int minutesInHours = 60;
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
        Divider(
          color: darkTheme.colorScheme.secondary,
          thickness: 2,
        ),
        BlocConsumer<TreasureHuntBloc, TreasureHuntState>(
          listener: (context, state) {},
          builder: (context, state) {
            print(state);
            if (state is LeaderboardLoaded) {
              return state.leaderboard.leaders.isEmpty
                  ? Container()
                  : Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.5,
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: state.leaderboard.leaders.length,
                              itemBuilder: (context, index) {
                                final Duration duration = state
                                    .leaderboard.leaders[index].lastSolved
                                    .difference(widget.treasureHunt.started_at);
                                return LeaderboardRow(attributes: [
                                  LeaderboardData(text: (index + 1).toString()),
                                  LeaderboardData(
                                      text: state
                                          .leaderboard.leaders[index].name),
                                  LeaderboardData(
                                      text: state.leaderboard.leaders[index]
                                          .cluesSolved
                                          .toString()),
                                  LeaderboardData(
                                      text:
                                          "${duration.inHours}:${duration.inMinutes.remainder(minutesInHours)}")
                                ]);
                              },
                            ),
                          ),
                        ),
                        Padding(
                            padding: const EdgeInsets.only(top: 28.0),
                            child: ActionButton(
                              onTap: () {
                                BlocProvider.of<TreasureHuntBloc>(context).add(
                                    GetLeaderboard(widget.treasureHunt.id));
                              },
                              leading: Mi.refresh,
                            ))
                      ],
                    );
            } else {
              return Container(
                  padding: const EdgeInsets.only(top: 30),
                  child: const Center(
                      child: CircularProgressIndicator(color: Colors.white)));
            }
          },
        ),
      ],
    );
  }
}
