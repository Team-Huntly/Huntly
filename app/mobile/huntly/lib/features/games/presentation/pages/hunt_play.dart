import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
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

import '../../../hunts/presentation/pages/home_page.dart';
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
    print("Hello");
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
        } else if (state is AlreadySolved) {
          BlocProvider.of<GameBloc>(context)
              .add(SetUpGame(treasureHuntId: widget.treasureHuntId));
        } else if (state is LocationUnverified) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Location not verified'),
              backgroundColor: Colors.red,
            ),
          );
        } else if (state is LocationVerified) {
          controller.play();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Location verified'),
              backgroundColor: Colors.green,
            ),
          );
          Future.delayed(Duration(seconds: 2), () {
            controller.stop();
          });
        } else if (state is ClueSolved) {
          controller.play();

          Future.delayed(const Duration(seconds: 2), () {
            controller.stop();
          });
        } else if (state is GameEnded) {
          controller.play();
          Future.delayed(const Duration(seconds: 2), () {
            controller.stop();
          });
        }
      },
      builder: (context, state) {
        print(state);
        if (state is CluesLoaded) {
          return HuntlyScaffold(
              outerContext: context,
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 10),
                  Text('Clue #${state.index + 1}/${state.clues.length}',
                      style: darkTheme.textTheme.caption),
                  const SizedBox(height: 20),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    width: MediaQuery.of(context).size.width * 0.99,
                    height: MediaQuery.of(context).size.height * 0.6,
                    child: Markdown(
                      shrinkWrap: true,
                      data: state.clues[state.index].description,
                    ),
                  ),
                  // const SizedBox(height: 15),
                  !state.clues[state.index].isQrBased
                      ? Expanded(
                          child: ActionButton(
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
                        )
                      : Expanded(
                          child: ActionButton(
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
                                  // ignore: use_build_context_synchronously
                                  BlocProvider.of<GameBloc>(context).add(
                                      VerifyClue(
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
                        ),
                ],
              ));
        } else if (state is Loading) {
          return HuntlyScaffold(
            outerContext: context,
            body: const Center(child: CircularProgressIndicator()),
            showDrawer: false,
          );
        } else if (state is GameEnded) {
          return Stack(children: [
            HuntlyScaffold(
              outerContext: context,
              body: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Add a rich text to say congratulations, you have completed the hunt
                  RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                          style: darkTheme.textTheme.headline5,
                          children: [
                            TextSpan(
                                text: 'Congratulations!',
                                style: darkTheme.textTheme.headline2!
                                    .copyWith(color: darkTheme.highlightColor)),
                            TextSpan(
                                text: ' You have completed the hunt\n',
                                style: darkTheme.textTheme.headline5)
                          ])),

                  ActionButton(
                    text: 'Go to Home!',
                    leading: Noto.party_popper,
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    colorIcon: false,
                    color: Colors.black,
                  ),
                ],
              ),
            ),
            Center(
                child: ConfettiWidget(
              confettiController: controller,
              blastDirectionality: BlastDirectionality.explosive,
              numberOfParticles: 150,
            ))
          ]);
        } else if (state is ClueSolved) {
          return Stack(children: [
            HuntlyScaffold(
                outerContext: context,
                body: ListView(
                  // crossAxisAli./gnment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 10),
                    Text('Clue #${state.index + 1}/${state.clues.length}',
                        textAlign: TextAlign.center,
                        style: darkTheme.textTheme.caption),
                    const SizedBox(height: 20),
                    ActionButton(
                        text: 'Success',
                        leading: Noto.party_popper,
                        onTap: () {},
                        color: darkTheme.colorScheme.primary),
                    const SizedBox(height: 15),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      width: MediaQuery.of(context).size.width * 0.99,
                      height: MediaQuery.of(context).size.height * 0.6,
                      child: Markdown(
                        shrinkWrap: true,
                        data: state.clues[state.index].answerDescription,
                      ),
                    ),
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [],
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
          return HuntlyScaffold(
            outerContext: context,
            body: const Center(child: CircularProgressIndicator()),
            showDrawer: false,
          );
        }
      },
    );
  }
}
