import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:huntly/core/utils/scaffold.dart';
import 'package:huntly/features/hunts/presentation/pages/hunt_detail_page.dart';
import 'package:huntly/features/hunts/presentation/pages/leaderboard_page.dart';
import 'package:huntly/features/hunts/presentation/pages/team_page.dart';
import 'package:huntly/features/hunts/presentation/widgets/view_tab.dart';
import 'package:iconify_flutter/icons/ant_design.dart';
import 'package:iconify_flutter/icons/ri.dart';
import 'package:iconify_flutter/icons/carbon.dart';

import '../../../../core/theme/theme.dart';
import '../../../../core/utils/service.dart';
import '../../../authentication/data/models/user_model.dart';
import '../../domain/entities/treasure_hunt.dart';
import '../bloc/treasurehunt_bloc.dart';

class HuntView extends StatefulWidget {
  final TreasureHunt treasureHunt;

  const HuntView({Key? key, required this.treasureHunt}) : super(key: key);

  @override
  State<HuntView> createState() => _HuntViewState();
}

class _HuntViewState extends State<HuntView> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        BlocProvider.of<TreasureHuntBloc>(context)
            .add(GetRegisteredTreasureHunts());
        Navigator.of(context).pop();
        return false;
      },
      child: HuntlyScaffold(
        outerContext: context,
        body: DefaultTabController(
          length: 3,
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: TabBar(
                  tabs: const [
                    ViewTab(icon: AntDesign.info_circle_outlined),
                    ViewTab(icon: Ri.team_line),
                    ViewTab(icon: Carbon.trophy)
                  ],
                  indicator: BoxDecoration(
                      color: darkTheme.highlightColor,
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      shape: BoxShape.rectangle)),
            ),
            Expanded(
              child: TabBarView(
                physics: NeverScrollableScrollPhysics(),
                children: [
                  HuntDetailPage(
                      treasureHunt: widget.treasureHunt, user: user_),
                  TeamPage(
                    treasureHuntId: widget.treasureHunt.id,
                  ),
                  RefreshIndicator(
                    onRefresh: () {
                      BlocProvider.of<TreasureHuntBloc>(context)
                          .add(GetLeaderboard(widget.treasureHunt.id));
                      return Future.value();
                    },
                    child: LeaderboardPage(
                      treasureHunt: widget.treasureHunt,
                    ),
                  ),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
