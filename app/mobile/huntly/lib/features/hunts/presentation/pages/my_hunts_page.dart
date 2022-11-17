import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:huntly/core/utils/scaffold.dart';
import 'package:huntly/features/hunts/presentation/pages/home_page.dart';
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
    return WillPopScope(
      onWillPop: () {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const HomePage()));
        return Future.value(true);
      },
      child: HuntlyScaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        body: SingleChildScrollView(
          child: Column(
            children: [
              BlocConsumer<TreasureHuntBloc, TreasureHuntState>(
                listener: (context, state) {},
                builder: (context, state) {
                  if (state is Loaded) {
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: state.treasureHunts.length,
                      itemBuilder: (context, index) {
                        return HuntCard(
                            treasureHunt: state.treasureHunts[index]);
                      },
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
              const SizedBox(
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
        ),
        outerContext: context,
      ),
    );
  }
}
