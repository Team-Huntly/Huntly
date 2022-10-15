import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:huntly/core/theme/theme.dart';
import 'package:huntly/core/utils/action_button.dart';
import 'package:huntly/core/utils/scaffold.dart';
import 'package:huntly/features/huntsCreate/presentation/pages/clue_create_page.dart';
import 'package:huntly/features/hunts/presentation/pages/clue_page.dart';
import 'package:huntly/features/huntsCreate/presentation/pages/hunt_edit_page.dart';
import 'package:huntly/features/hunts/presentation/widgets/tab.dart';
import 'package:iconify_flutter/icons/ic.dart';
import 'package:iconify_flutter/icons/mdi.dart';
import 'package:colorful_iconify_flutter/icons/noto.dart';

import '../bloc/game_bloc.dart';

class HuntPlay extends StatefulWidget {
  int treasureHuntId;
  HuntPlay({Key? key, required this.treasureHuntId}) : super(key: key);

  @override
  State<HuntPlay> createState() => _HuntPlayState();
}

class _HuntPlayState extends State<HuntPlay> with TickerProviderStateMixin {
  @override
  void initState() {
    BlocProvider.of<GameBloc>(context)
        .add(SetUpGame(treasureHuntId: widget.treasureHuntId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GameBloc, GameState>(
      listener: (context, state) {
        if (state is TeamLoaded) {
          BlocProvider.of<GameBloc>(context).add(GetClues(
              treasureHuntId: widget.treasureHuntId, teamId: state.team.id));
        } else if (state is CluesLoaded) {
          print(state.clues);
        } else if (state is LocationUnverified) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Location not verified'),
              backgroundColor: Colors.red,
            ),
          );
        } else if (state is LocationVerified) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Location verified'),
              backgroundColor: Colors.green,
            ),
          );
        }
      },
      builder: (context, state) {
        if (state is CluesLoaded) {
          return HuntlyScaffold(
              outerContext: context,
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 70),
                  Text(
                      'Clue #${state.clues[state.index].stepNo}/${state.clues.length}',
                      style: darkTheme.textTheme.caption),
                  const SizedBox(height: 50),
                  Text(state.clues[state.index].description,
                      style: darkTheme.textTheme.bodyText2),
                  const SizedBox(height: 15),
                  ActionButton(
                    leading: Mdi.map_marker_multiple,
                    text: 'Verify',
                    onTap: () {
                      BlocProvider.of<GameBloc>(context).add(VerifyClue(
                          treasureHuntId: widget.treasureHuntId,
                          clueId: state.clues[state.index].id,
                          clues: state.clues,
                          teamId: state.teamId,
                          index: state.index));
                    },
                  ),
                  // ActionButton(
                  //   leading: Ri.qr_scan_2_line,
                  //   text: 'Verify',
                  //   onTap: () {},
                  // ),
                  // ActionButton(
                  //   leading: Ooui.next_ltr,
                  //   alignment: Alignment.bottomRight,
                  //   onTap: () {},
                  // ),
                  // Text(
                  //     'A man who was outside in the rain without an umbrella or hat didn’t get a single hair on his head wet. Why?',
                  //     style: darkTheme.textTheme.bodyText2!
                  //         .copyWith(fontSize: 12, color: darkTheme.disabledColor)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ActionButton(
                        text: 'Success',
                        leading: Noto.party_popper,
                        onTap: () {},
                        colorIcon: false,
                        color: darkTheme.colorScheme.secondary,
                      ),
                      const SizedBox(width: 10),
                      ActionButton(
                          leading: Mdi.camera_wireless_outline,
                          onTap: () {},
                          color: darkTheme.colorScheme.primary)
                    ],
                  )
                  // Container(
                  //   padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                  //   decoration: BoxDecoration(
                  //     border: Border.all(
                  //       color: Colors.white
                  //     ),
                  //     borderRadius: const BorderRadius.all(Radius.circular(10))
                  //   ),
                  //   child: Row(
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     children: [
                  //       const Iconify(
                  //         Mdi.map_marker_outline,
                  //         color: Colors.white,
                  //       ),
                  //       Padding(
                  //         padding: const EdgeInsets.only(left: 10),
                  //         child: Column(
                  //           crossAxisAlignment: CrossAxisAlignment.start,
                  //           children: [
                  //             Text(
                  //               'D516\nNITK Hostels\nSurathkal, Mangalore\nKarnataka',
                  //               style: darkTheme.textTheme.bodyText1,
                  //             ),
                  //             const SizedBox(height: 10),
                  //             GestureDetector(
                  //               child: Text(
                  //                 'Edit',
                  //                 textAlign: TextAlign.left,
                  //                 style: darkTheme.textTheme.bodyText1!.copyWith(color: darkTheme.highlightColor, fontWeight: FontWeight.w700),
                  //               )
                  //             ),
                  //           ],
                  //         ),
                  //       ),
                  //     ]
                  //   ),
                  // ),
                ],
              ));
        } else if (state is Loading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is GameEnded) {
          return HuntlyScaffold(
            outerContext: context,
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Congratulations!', style: darkTheme.textTheme.headline5),
                const SizedBox(height: 20),
                Text('You have completed the hunt',
                    style: darkTheme.textTheme.bodyText1),
                const SizedBox(height: 20),
                ActionButton(
                  text: 'Finish',
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            ),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
