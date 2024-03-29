import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:huntly/features/hunts/presentation/pages/home_page.dart';

import '../../../../core/theme/theme.dart';
import '../../../../core/utils/background_widget.dart';
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
    print("Recents page");
    return WillPopScope(
      onWillPop: () {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const HomePage()));
        return Future.value(true);
      },
      child: HuntlyScaffold(
          title: "RECENTS",
          outerContext: context,
          body: BlocConsumer<TreasureHuntBloc, TreasureHuntState>(
            listener: (context, state) {},
            builder: (context, state) {
              if (state is Loading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is Loaded) {
                return state.treasureHunts.isEmpty
                    ? BackGroundWidget(title: "No Hunts found")
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 30),
                          ListView.builder(
                            shrinkWrap: true,
                            itemCount: state.treasureHunts.length,
                            itemBuilder: (context, index) {
                              return HuntCard(
                                  treasureHunt: state.treasureHunts[index]);
                            },
                          ),
                        ],
                      );
              } else if (state is TreasureHuntInitial) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  BlocProvider.of<TreasureHuntBloc>(context)
                      .add(GetRecentTreasureHunts());
                });
                return const Center(child: CircularProgressIndicator());
              } else {
                return BackGroundWidget(title: "No Hunts found");
              }
            },
          )),
    );
  }
}
