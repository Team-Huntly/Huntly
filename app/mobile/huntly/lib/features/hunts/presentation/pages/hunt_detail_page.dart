import 'package:flutter/material.dart';
import 'package:huntly/core/utils/action_button.dart';
import 'package:huntly/features/hunts/domain/entities/treasure_hunt.dart';
import 'package:huntly/features/hunts/presentation/widgets/hunt_info_card.dart';
import 'package:iconify_flutter/icons/carbon.dart';
import 'package:iconify_flutter/icons/ic.dart';
import 'package:iconify_flutter/icons/mdi.dart';
import 'package:iconify_flutter/icons/majesticons.dart';
import 'package:iconify_flutter/icons/ri.dart';
import 'package:colorful_iconify_flutter/icons/twemoji.dart';

import 'package:intl/intl.dart';

import '../../../../core/theme/theme.dart';
import '../../../authentication/data/models/user_model.dart';
import '../../../games/presentation/pages/hunt_play.dart';

class HuntDetailPage extends StatefulWidget {
  final TreasureHunt treasureHunt;

  const HuntDetailPage({Key? key, required this.treasureHunt})
      : super(key: key);

  @override
  State<HuntDetailPage> createState() => _HuntDetailPageState();
}

class _HuntDetailPageState extends State<HuntDetailPage> {
  bool isParticipant(int userId) {
    for (final UserModel participant in widget.treasureHunt.participants) {
      if (participant.id == userId) {
        return true;
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(height: 50),
        Row(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              child: SizedBox(
                height: 120,
                width: 100,
                child: Image.asset(
                  'assets/images/0.jpg',
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(widget.treasureHunt.name,
                    style:
                        darkTheme.textTheme.headline2!.copyWith(height: 1.2)),
              ),
            )
          ],
        ),
        const SizedBox(
          height: 25,
        ),
        Wrap(
          alignment: WrapAlignment.center,
          runSpacing: 10,
          spacing: 10,
          children: [
            HuntInfoCard(
              icon: Ic.baseline_calendar_today,
              title: 'On',
              info: DateFormat.yMd().format(widget.treasureHunt.started_at),
              // fontSize: 8,
            ),
            HuntInfoCard(
              icon: Ic.baseline_alarm,
              title: 'Starts at',
              info: DateFormat('HH:MM').format(widget.treasureHunt.started_at),
            ),
            HuntInfoCard(
              icon: Mdi.map_marker_outline,
              title: 'Location',
              info: widget.treasureHunt.location_name,
              trailing: Majesticons.external_link_line,
            ),
            HuntInfoCard(
              icon: Ri.team_line,
              title: 'Team size',
              info: widget.treasureHunt.team_size.toString(),
            ),
            HuntInfoCard(
              icon: Carbon.paint_brush,
              title: 'Theme',
              info: widget.treasureHunt.theme.name,
            ),
            HuntInfoCard(
              icon: Carbon.cabin_care_alert,
              title: 'Seats left',
              info: (widget.treasureHunt.total_seats -
                      widget.treasureHunt.participants.length)
                  .toString(),
            ),
          ],
        ),
        const SizedBox(
          height: 25,
        ),
        ActionButton(
          text: 'Start',
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) =>
                    HuntPlay(treasureHuntId: widget.treasureHunt.id)));
          },
        ),
        ActionButton(
          text: 'Register',
          onTap: () {},
          color: darkTheme.indicatorColor,
        ),
        const SizedBox(
          height: 10,
        ),
        ActionButton(
          text: 'Unregister',
          onTap: () {},
          color: darkTheme.colorScheme.secondary,
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ActionButton(onTap: () {}, text: 'Lock teams'),
            const SizedBox(width: 10),
            ActionButton(
              onTap: () {},
              leading: Ic.twotone_edit,
            )
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        ActionButton(
          text: 'Teams locked',
          onTap: () {},
          color: darkTheme.colorScheme.secondary,
          leading: Twemoji.locked_with_key,
          colorIcon: false,
        )
      ],
    ));
  }
}