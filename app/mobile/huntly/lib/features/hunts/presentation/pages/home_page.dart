import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:huntly/features/hunts/presentation/widgets/hunt_card.dart';
import 'package:huntly/core/utils/scaffold.dart';
import 'package:lottie/lottie.dart';
import '../../../../core/theme/theme.dart';
import '../../../../core/utils/scaffold.dart';
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
        outerContext: context,
        body: BlocConsumer<TreasureHuntBloc, TreasureHuntState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is Loading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is Loaded) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  state.treasureHunts.length == 0
                      ? Padding(
                          padding: const EdgeInsets.only(top: 48.0),
                          child: Lottie.asset(
                              'assets/images/home-place-holder.json'),
                        )
                      : ListView.builder(
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
                    .add(GetRegisteredTreasureHunts());
              });
              return const Center(child: CircularProgressIndicator());
            } else if (state is Failed) {
              return const Center(child: Text("Some error has occured"));
            } else {
              return const Center(
                child: Center(child: Text('Not registered for any hunts')),
              );
            }
          },
        ));
  }
}
