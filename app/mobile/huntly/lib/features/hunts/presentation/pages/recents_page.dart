import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/theme.dart';
import '../../../../core/utils/scaffold.dart';
import '../bloc/treasurehunt_bloc.dart';
import '../widgets/hunt_card.dart';

class RecentsPage extends StatefulWidget {
  const RecentsPage({Key? key}) : super(key: key);

  @override
  State<RecentsPage> createState() => _RecentsPageState();
}

class _RecentsPageState extends State<RecentsPage> {
  @override
  void initState() {
    BlocProvider.of<TreasureHuntBloc>(context).add(GetRecentTreasureHunts());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return HuntlyScaffold(
        outerContext: context,
        body: BlocConsumer<TreasureHuntBloc, TreasureHuntState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is Loading) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              );
            } else if (state is Loaded) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 30),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: state.treasureHunts.length,
                    itemBuilder: (context, index) {
                      return HuntCard(treasureHunt: state.treasureHunts[index]);
                    },
                  ),
                ],
              );
            } else if (state is TreasureHuntInitial) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                BlocProvider.of<TreasureHuntBloc>(context)
                    .add(GetRecentTreasureHunts());
              });
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              );
            } else {
              return const Center(
                child: Text(''),
              );
            }
          },
        ));
  }
}
