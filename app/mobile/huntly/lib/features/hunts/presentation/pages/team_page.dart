import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
          return ListView.builder(
            itemCount: state.teamMates.members.length,
            itemBuilder: (context, index) {
              return UserCard(user: state.teamMates.members[index]);
            },
          );
        } else
          return Container();
      },
    );
  }
}
