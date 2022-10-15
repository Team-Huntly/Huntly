import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:huntly/core/utils/action_button.dart';
import 'package:huntly/features/games/domain/models/game_clue_model.dart';
import 'package:qr_flutter/qr_flutter.dart';

class HuntClueViewPage extends StatefulWidget {
  GameClueModel clue;
  HuntClueViewPage({Key? key, required this.clue}) : super(key: key);

  @override
  State<HuntClueViewPage> createState() => _HuntClueViewPageState();
}

class _HuntClueViewPageState extends State<HuntClueViewPage> {
  bool isQrShown = false;
  @override
  Widget build(BuildContext context) {
    return !isQrShown
        ? Column(
            children: [
              ActionButton(
                  onTap: () {
                    setState(() {
                      isQrShown = true;
                    });
                  },
                  text: 'Show QR'),
              SizedBox(
                height: 20,
              ),
              Text(widget.clue.id.toString()),
              Text(widget.clue.description),
              Text(widget.clue.answerDescription),
              Text(widget.clue.answerLatitude),
              Text(widget.clue.answerLongitude),
            ],
          )
        : Column(
            children: [
              SizedBox(
                height: 20,
              ),
              ActionButton(
                  onTap: () {
                    setState(() {
                      isQrShown = false;
                    });
                  },
                  text: 'Details'),
              QrImage(
                data: widget.clue.id.toString(),
                version: QrVersions.auto,
                size: 320,
                gapless: false,
                dataModuleStyle: QrDataModuleStyle(
                  color: Colors.white,
                  dataModuleShape: QrDataModuleShape.square,
                ),
                eyeStyle: QrEyeStyle(
                  eyeShape: QrEyeShape.square,
                  color: Colors.white,
                ),
              ),
            ],
          );
  }
}
