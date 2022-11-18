import 'package:flutter/material.dart';
import 'package:huntly/core/utils/action_button.dart';
import 'package:huntly/features/hunts/data/datasources/treasure_hunt_remote_datasource.dart';
import 'package:huntly/features/hunts/domain/entities/treasure_hunt.dart';
import 'package:huntly/features/hunts/presentation/pages/hunt_edit_page_after.dart';
import 'package:huntly/features/hunts/presentation/widgets/hunt_info_card.dart';
import 'package:iconify_flutter/icons/carbon.dart';
import 'package:iconify_flutter/icons/ic.dart';
import 'package:iconify_flutter/icons/mdi.dart';
import 'package:iconify_flutter/icons/majesticons.dart';
import 'package:iconify_flutter/icons/ri.dart';

import 'package:intl/intl.dart';

import '../../../../core/theme/theme.dart';
import '../../../../core/utils/service.dart';
import '../../../authentication/data/models/user_model.dart';
import '../../../games/presentation/pages/hunt_play.dart';
import '../../../huntsCreate/presentation/pages/hunt_edit_page.dart';

class HuntDetailPage extends StatefulWidget {
  final TreasureHunt treasureHunt;
  final UserModel user;

  const HuntDetailPage(
      {Key? key, required this.treasureHunt, required this.user})
      : super(key: key);

  @override
  State<HuntDetailPage> createState() => _HuntDetailPageState();
}

class _HuntDetailPageState extends State<HuntDetailPage> {
  bool checkIfParticipant(int userId) {
    for (final UserModel participant in widget.treasureHunt.participants) {
      if (participant.id == userId) {
        return true;
      }
    }
    return false;
  }

  bool checkIfAdmin(int userId) {
    return widget.treasureHunt.creator.id == user_.id;
  }

  late bool isLoading;
  late bool isParticipant;
  late bool isAdmin;

  @override
  void initState() {
    super.initState();

    isLoading = false;
    isParticipant = checkIfParticipant(user_.id);
    isAdmin = checkIfAdmin(user_.id);
  }

  @override
  Widget build(BuildContext context) {
    print(widget.treasureHunt.status);
    return ListView(
      shrinkWrap: true,
      children: [
        const SizedBox(height: 50),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                child: SizedBox(
                  height: 100,
                  width: 100,
                  child: Image.asset(
                    'assets/images/gdsc.jpg',
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    widget.treasureHunt.name,
                    style: darkTheme.textTheme.headline2!.copyWith(height: 1.2),
                    textAlign: TextAlign.right,
                  ),
                ),
              )
            ],
          ),
        ),
        const SizedBox(
          height: 25,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: GridView.count(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 1.5,
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
                info:
                    DateFormat("h:mm a").format(widget.treasureHunt.started_at),
              ),
              HuntInfoCard(
                icon: Mdi.map_marker_outline,
                title: 'Location',
                info: widget.treasureHunt.location_name,
                trailing: Majesticons.external_link_line,
                fontSize: 14,
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
                fontSize: 14,
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
        ),
        const SizedBox(
          height: 20,
        ),
        widget.treasureHunt.started_at.isBefore(DateTime.now())
            ? ActionButton(
                text: 'Start',
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          HuntPlay(treasureHuntId: widget.treasureHunt.id)));
                },
              )
            : isAdmin
                ? Container()
                : widget.treasureHunt.status != "Open"
                    ? Container()
                    : isLoading
                        ? CircularProgressIndicator()
                        : isParticipant
                            ? ActionButton(
                                text: 'Unregister',
                                onTap: () async {
                                  try {
                                    final thrs =
                                        TreasureHuntRemoteDataSourceImpl();
                                    setState(() {
                                      isLoading = true;
                                    });
                                    await thrs.unregisterUser(
                                        treasureHuntId: widget.treasureHunt.id);
                                    setState(() {
                                      isLoading = false;
                                      isParticipant = false;
                                      widget.treasureHunt.participants
                                          .removeWhere((element) =>
                                              element.id == user_.id);
                                    });
                                  } catch (e) {
                                    setState(() {
                                      isLoading = false;
                                    });
                                  }
                                },
                                color: darkTheme.colorScheme.secondary,
                              )
                            : ActionButton(
                                text: 'Register',
                                onTap: () async {
                                  try {
                                    final thrs =
                                        TreasureHuntRemoteDataSourceImpl();
                                    setState(() {
                                      isLoading = true;
                                    });
                                    await thrs.registerUser(
                                        treasureHuntId: widget.treasureHunt.id);
                                    setState(() {
                                      isParticipant = true;
                                      isLoading = false;

                                      widget.treasureHunt.participants
                                          .add(user_);
                                    });
                                  } catch (e) {
                                    setState(() {
                                      isLoading = false;
                                    });
                                  }
                                },
                                color: darkTheme.indicatorColor,
                              ),
        const SizedBox(
          height: 10,
        ),
        const SizedBox(width: 10),
        isAdmin
            ? ActionButton(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => HuntAfterEditPage(
                          treasureHunt: widget.treasureHunt)));
                },
                leading: Ic.twotone_edit,
              )
            : Container(),
        const SizedBox(
          height: 10,
        ),
        const SizedBox(
          height: 25,
        ),
      ],
    );
  }
}
