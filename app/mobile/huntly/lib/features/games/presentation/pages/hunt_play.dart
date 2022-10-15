import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:huntly/core/theme/theme.dart';
import 'package:huntly/core/utils/action_button.dart';
import 'package:huntly/core/utils/scaffold.dart';
import 'package:huntly/features/games/presentation/pages/qr_page.dart';
import 'package:huntly/features/huntsCreate/presentation/pages/clue_create_page.dart';
import 'package:huntly/features/hunts/presentation/pages/clue_page.dart';
import 'package:huntly/features/huntsCreate/presentation/pages/hunt_edit_page.dart';
import 'package:huntly/features/hunts/presentation/widgets/tab.dart';
import 'package:iconify_flutter/icons/ic.dart';
import 'package:iconify_flutter/icons/mdi.dart';
import 'package:colorful_iconify_flutter/icons/noto.dart';
import 'package:permission_handler/permission_handler.dart';

import '../bloc/game_bloc.dart';

class HuntPlay extends StatefulWidget {
  int treasureHuntId;
  HuntPlay({Key? key, required this.treasureHuntId}) : super(key: key);

  @override
  State<HuntPlay> createState() => _HuntPlayState();
}

class _HuntPlayState extends State<HuntPlay> with TickerProviderStateMixin {
  final controller = ConfettiController();
  @override
  void initState() {
    BlocProvider.of<GameBloc>(context)
        .add(SetUpGame(treasureHuntId: widget.treasureHuntId));
    super.initState();
  }

  final COLOR_CODE = "0xFFE0E0E0";

  Future<PermissionStatus> _getCameraPermission() async {
    var status = await Permission.camera.status;
    if (!status.isGranted) {
      final result = await Permission.camera.request();
      return result;
    } else {
      return status;
    }
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
          controller.play();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Location verified'),
              backgroundColor: Colors.green,
            ),
          );
          Future.delayed(Duration(seconds: 2), () {
            controller.stop();
          });
        } else if (state is ClueSolved) {
          controller.play();

          Future.delayed(Duration(seconds: 2), () {
            controller.stop();
          });
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
                  state.clues[state.index].isQrBased
                      ? ActionButton(
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
                        )
                      : ActionButton(
                          leading: Mdi.barcode,
                          text: 'Scan',
                          onTap: () async {
                            String barcodeScanRes =
                                await FlutterBarcodeScanner.scanBarcode(
                                    '#ff6666',
                                    'Cancel',
                                    true,
                                    ScanMode.BARCODE);
                            if (int.parse(barcodeScanRes) ==
                                state.clues[state.index].id) {
                              // ignore: invalid_use_of_visible_for_testing_member, use_build_context_synchronously
                              BlocProvider.of<GameBloc>(context).add(VerifyClue(
                                  treasureHuntId: widget.treasureHuntId,
                                  clueId: state.clues[state.index].id,
                                  clues: state.clues,
                                  teamId: state.teamId,
                                  index: state.index));
                            } else {
                              // ignore: use_build_context_synchronously
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Incorrect QR Code'),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            }
                            print(barcodeScanRes);
                          },
                          color: darkTheme.colorScheme.primary),
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
        } else if (state is ClueSolved) {
          return Stack(children: [
            HuntlyScaffold(
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
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 30),
                      child: Text(state.clues[state.index].answerDescription,
                          style: darkTheme.textTheme.bodyText2!.copyWith(
                              fontSize: 12, color: darkTheme.disabledColor)),
                    ),
                    ActionButton(
                      text: 'Go to next clue',
                      // leading: Noto.party_popper,
                      onTap: () {
                        BlocProvider.of<GameBloc>(context).add(NextClue(
                            clues: state.clues,
                            teamId: state.teamId,
                            index: state.index));
                      },
                    ),
                  ],
                )),
            Center(
                child: ConfettiWidget(
              confettiController: controller,
              blastDirectionality: BlastDirectionality.explosive,
              numberOfParticles: 100,
            ))
          ]);
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
