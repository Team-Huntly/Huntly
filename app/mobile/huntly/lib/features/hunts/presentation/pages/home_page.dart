import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:huntly/features/hunts/presentation/widgets/hunt_card.dart';
import 'package:huntly/core/utils/scaffold.dart';

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
  Widget build(BuildContext context) {
    return HuntlyScaffold(
        outerContext: context,
        body: BlocConsumer<TreasureHuntBloc, TreasureHuntState>(
          listener: (context, state) {
            if (state is TreasureHuntInitial) {
              BlocProvider.of<TreasureHuntBloc>(context)
                  .add(GetTreasureHunts());
            }
          },
          builder: (context, state) {
            if (state is Loading) {
              return const Center(
                child: CircularProgressIndicator(color: Colors.white,),
              );
            } else if (state is Loaded) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Hello!",
                          style: darkTheme.textTheme.overline,
                        ),
                      ]),
                  const SizedBox(height: 30),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: state.treasureHunts.length,
                    itemBuilder: (context, index) {
                      return HuntCard(
                        treasureHunt: state.treasureHunts[index]
                      );
                    },
                  ),
                ],
              );
            } else if (state is TreasureHuntInitial) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                BlocProvider.of<TreasureHuntBloc>(context)
                    .add(GetTreasureHunts());
              });
              return const Center(
                child: CircularProgressIndicator(color: Colors.white,),
              );
            } else {
              return const Center(
                child: Text('Error'),
              );
            }
          },
        ));
  }
}
