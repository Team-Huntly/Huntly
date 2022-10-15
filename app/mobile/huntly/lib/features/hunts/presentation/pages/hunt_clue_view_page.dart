import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:huntly/core/utils/action_button.dart';
import 'package:huntly/features/games/domain/models/game_clue_model.dart';
import 'package:iconify_flutter/icons/ant_design.dart';
import 'package:iconify_flutter/icons/bx.dart';
import 'package:iconify_flutter/icons/carbon.dart';
import 'package:iconify_flutter/icons/fa_solid.dart';
import 'package:iconify_flutter/icons/ic.dart';
import 'package:iconify_flutter/icons/mdi.dart';
import 'package:iconify_flutter/icons/ri.dart';
import 'package:intl/intl.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../widgets/hunt_info_card.dart';

class HuntClueViewPage extends StatefulWidget {
  final GameClueModel clue;

  const HuntClueViewPage({Key? key, required this.clue}) : super(key: key);

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
              const SizedBox(
                height: 20,
              ),
              Wrap(
          alignment: WrapAlignment.center,
          runSpacing: 10,
          spacing: 10,
          children: [
            HuntInfoCard(
              icon: Ic.baseline_grid_3x3,
              title: 'Id',
              info: widget.clue.id.toString(),
            ),
            HuntInfoCard(
              icon: Bx.message_detail,
              title: 'Decription',
              info: widget.clue.description,
            ),
            HuntInfoCard(
              icon: FaSolid.value_absolute,
              title: 'Answer',
              info: widget.clue.answerDescription,
            ),
            HuntInfoCard(
              icon: FaSolid.value_absolute,
              title: 'Answer',
              info: widget.clue.answerDescription,
            ),
            HuntInfoCard(
              icon: Mdi.map_marker_outline,
              title: 'Latitude',
              info: widget.clue.answerLatitude,
            ),
            HuntInfoCard(
              icon: Mdi.map_marker_outline,
              title: 'Longitude',
              info: widget.clue.answerLongitude,
            ),
            HuntInfoCard(
              icon: Ri.qr_scan_line,
              title: 'QR based',
              info: widget.clue.isQrBased.toString(),
            ),
          ],
        ),
            ],
          )
        : Column(
            children: [
              // const SizedBox(
              //   height: 20,
              // ),
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
                dataModuleStyle: const QrDataModuleStyle(
                  color: Colors.white,
                  dataModuleShape: QrDataModuleShape.square,
                ),
                eyeStyle: const QrEyeStyle(
                  eyeShape: QrEyeShape.square,
                  color: Colors.white,
                ),
              ),
            ],
          );
  }
}
