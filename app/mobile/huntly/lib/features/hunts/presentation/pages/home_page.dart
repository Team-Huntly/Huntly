import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:huntly/core/utils/background_widget.dart';
import 'package:huntly/features/hunts/presentation/widgets/hunt_card.dart';
import 'package:huntly/core/utils/scaffold.dart';
import '../../../../core/utils/background_widget.dart';
import '../bloc/treasurehunt_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    BlocProvider.of<TreasureHuntBloc>(context)
        .add(GetRegisteredTreasureHunts());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return HuntlyScaffold(
        title: "HOME",
        outerContext: context,
        body: BlocConsumer<TreasureHuntBloc, TreasureHuntState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is Loading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is Loaded) {
              return Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    state.treasureHunts.isEmpty
                        ? BackGroundWidget(
                            title: "Not registered for any Hunts")
                        : ListView.builder(
                            shrinkWrap: true,
                            itemCount: state.treasureHunts.length,
                            itemBuilder: (context, index) {
                              return HuntCard(
                                  treasureHunt: state.treasureHunts[index]);
                            },
                          ),
                  ],
                ),
              );
            } else if (state is TreasureHuntInitial) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                BlocProvider.of<TreasureHuntBloc>(context)
                    .add(GetRegisteredTreasureHunts());
              });
              return const Center(child: CircularProgressIndicator());
            } else if (state is Failed) {
              return BackGroundWidget(title: "Some error Occured");
            } else {
              return BackGroundWidget(title: "Not registered for any Hunts");
            }
          },
        ));
  }
}
