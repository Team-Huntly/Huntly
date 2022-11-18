import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/theme/theme.dart';
import '../../../../core/utils/background_widget.dart';
import '../bloc/treasurehunt_bloc.dart';
import '../widgets/user_card.dart';

class TeamPage extends StatefulWidget {
  int treasureHuntId;
  TeamPage({Key? key, required this.treasureHuntId}) : super(key: key);

  @override
  State<TeamPage> createState() => _TeamPageState();
}

class _TeamPageState extends State<TeamPage> {
  @override
  void initState() {
    BlocProvider.of<TreasureHuntBloc>(context)
        .add(GetTeamMates(widget.treasureHuntId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TreasureHuntBloc, TreasureHuntState>(
      builder: (context, state) {
        if (state is TeamLoaded) {
          return Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Column(
              children: [
                Text(
                  state.teamMates.name,
                  style: darkTheme.textTheme.headline3,
                ),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: state.teamMates.members.length,
                  itemBuilder: (context, index) {
                    return UserCard(user: state.teamMates.members[index]);
                  },
                ),
              ],
            ),
          );
        } else if (state is Failed) {
          return Center(
            child: Text(
              "Teams haven't been created yet",
              textAlign: TextAlign.center,
              style: darkTheme.textTheme.headline3!.copyWith(
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
          );
        } else {
          return const Center(
              child: CircularProgressIndicator(color: Colors.white));
        }
      },
    );
  }
}
