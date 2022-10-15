import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:huntly/core/utils/scaffold.dart';
import 'package:huntly/features/hunts/presentation/bloc/treasurehunt_bloc.dart';

import '../../../../core/theme/theme.dart';
import '../../../huntsCreate/data/models/clue_model.dart';
import '../../domain/entities/treasure_hunt.dart';
import '../widgets/tab.dart';
import 'hunt_clue_view_page.dart';

class HuntAfterEditPage extends StatefulWidget {
  final TreasureHunt treasureHunt;
  const HuntAfterEditPage({Key? key, required this.treasureHunt})
      : super(key: key);

  @override
  State<HuntAfterEditPage> createState() => _HuntAfterEditPageState();
}

class _HuntAfterEditPageState extends State<HuntAfterEditPage>
    with TickerProviderStateMixin {
  late TabController _tabController;
  ValueNotifier<List<ClueModel>> clubs = ValueNotifier([]);
  final List<Widget> _tab = [];

  final List<Widget> _tabMenu = [];

  @override
  void initState() {
    BlocProvider.of<TreasureHuntBloc>(context)
        .add(GetClues(treasureHuntId: widget.treasureHunt.id));

    _tabController = TabController(length: _tab.length, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TreasureHuntBloc, TreasureHuntState>(
      listener: (context, state) {
        if (state is CluesLoaded) {
          _tab.clear();
          _tabMenu.clear();
          for (var i = 0; i < state.clues.length; i++) {
            _tab.add(HuntTab(color: darkTheme.colorScheme.secondary));
            _tabMenu.add(
              Column(
                children: [
                  const SizedBox(height: 20),
                  HuntClueViewPage(
                    clue: state.clues[i],
                  )
                ],
              ),
            );
          }
        }

        _tabController = TabController(length: _tab.length, vsync: this);
      },
      builder: (context, state) {
        return HuntlyScaffold(
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 14),
              TabBar(
                isScrollable: true,
                indicatorWeight: 0,
                indicatorSize: TabBarIndicatorSize.label,
                // indicatorPadding: const EdgeInsets.symmetric(vertical: 1),
                // isScrollable: true,
                tabs: _tab.map((e) => e).toList(),
                controller: _tabController,
                indicatorColor: Colors.transparent,
                overlayColor:
                    MaterialStateProperty.all<Color>(Colors.transparent),
                indicator: BoxDecoration(
                  color: darkTheme.highlightColor,
                  border: Border.all(color: darkTheme.highlightColor),
                  borderRadius: const BorderRadius.all(Radius.circular(100)),
                ),
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: _tabMenu.map((e) => e).toList(),
                ),
              ),
            ],
          ),
          outerContext: context,
        );
        ;
      },
    );
  }
}
