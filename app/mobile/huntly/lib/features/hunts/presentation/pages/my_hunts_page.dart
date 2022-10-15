import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:huntly/core/utils/scaffold.dart';
import 'package:huntly/features/huntsCreate/presentation/pages/hunt_create.dart';
import 'package:huntly/features/hunts/presentation/pages/presets_page.dart';
import 'package:huntly/features/huntsCreate/presentation/pages/hunt_edit_page.dart';

import '../../../../core/theme/theme.dart';
import '../../../../core/utils/action_button.dart';
import '../bloc/treasurehunt_bloc.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import '../widgets/hunt_card.dart';

class MyHuntsPage extends StatefulWidget {
  const MyHuntsPage({Key? key}) : super(key: key);

  @override
  State<MyHuntsPage> createState() => _MyHuntsPageState();
}

class _MyHuntsPageState extends State<MyHuntsPage> {
  @override
  void initState() {
    BlocProvider.of<TreasureHuntBloc>(context).add(GetUserHunts());
    super.initState();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return HuntlyScaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      // floatingActionButton: ExpandableFabClass(
      //   onPressed: () {},
      //   child:
      // ),
      body: Column(
        children: [
          BlocConsumer<TreasureHuntBloc, TreasureHuntState>(
            listener: (context, state) {},
            builder: (context, state) {
              if (state is Loaded) {
                return Column(
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
              } else {
                return const Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                );
              }
            },
          ),
          // GestureDetector(
          //   child: const Text(
          //     'Custom',
          //     style: TextStyle(fontSize: 40),
          //   ),
          //   onTap: () {
          //     // TODO: Navigate to custom hunt edit page
          //     Navigator.of(context).pushReplacement(MaterialPageRoute(
          //         builder: (context) => const HuntEditPage()));
          //     // TODO remove this
          //     // Navigator.of(context).pushReplacement(MaterialPageRoute(
          //     //     builder: (context) => const HuntCreate(
          //     //           huntId: 3,
          //     //         )));
          //   },
          // ),
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: GestureDetector(
          //     child: const Text('Presets'),
          //     onTap: () {
          //       Navigator.of(context).pushReplacement(MaterialPageRoute(
          //           builder: (context) => const PresetsPage()));
          //     },
          //   ),
          // ),
          // DropdownButton(
          //   items: <DropdownMenuItem<int>>[
          //     DropdownMenuItem(
          //       child: Text('Custom'),
          //       value: 0,
          //     ),
          //     DropdownMenuItem(
          //       child: Text('Presets'),
          //       value: 42,
          //     ),
          //   ],
          //   onChanged: (int? value) {},
          //   // onChanged: (int value) {
          //   //   setState(() {
          //   //     _value = value;
          //   //   });
          //   // },
          // ),
          SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ActionButton(
                text: 'Custom',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HuntEditPage(),
                    ),
                  );
                },
              ),
              ActionButton(
                text: 'Preset',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PresetsPage(),
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
      outerContext: context,
    );
  }
}
