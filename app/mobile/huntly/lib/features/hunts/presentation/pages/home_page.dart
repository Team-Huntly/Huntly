import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
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
              print("asd");
              BlocProvider.of<TreasureHuntBloc>(context)
                  .add(GetTreasureHunts());
            }
          },
          builder: (context, state) {
            print(state);
            if (state is Loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is Loaded) {
              return ListView.builder(
                itemCount: state.treasureHunts.length,
                itemBuilder: (context, index) {
                  return HuntCard(
                      title: state.treasureHunts[index].name,
                      location: state.treasureHunts[index].location_latitute,
                      seatsLeft: 12,
                      start: DateTime.now(),
                      treasureHunt: state.treasureHunts[index]);
                },
              );
            } else if (state is TreasureHuntInitial) {
              print("sad");
              WidgetsBinding.instance.addPostFrameCallback((_) {
                BlocProvider.of<TreasureHuntBloc>(context)
                    .add(GetTreasureHunts());
              });
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return const Center(
                child: Text('Error'),
              );
            }
            // return Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 30),
            //   child: Column(
            //       crossAxisAlignment: CrossAxisAlignment.start,
            //       children: [
            //         Text(
            //           "Hello!",
            //           style: darkTheme.textTheme.overline,
            //         ),
            //         Text(
            //           'John Doe',
            //           style: darkTheme.textTheme.headline2,
            //         ),
            //         HuntCard(
            //             title: "Manipal Institute of Technology Hunt!",
            //             location: "MIT Udupi",
            //             seatsLeft: 5,
            //             start: DateTime(2022, 9, 5, 17, 30))
            //       ]),
            // );
          },
        ));
  }
}
