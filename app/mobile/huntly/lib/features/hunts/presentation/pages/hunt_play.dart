import 'package:flutter/material.dart';
import 'package:huntly/core/theme/theme.dart';
import 'package:huntly/core/utils/action_button.dart';
import 'package:huntly/core/utils/scaffold.dart';
import 'package:huntly/features/hunts/presentation/pages/clue_create_page.dart';
import 'package:huntly/features/hunts/presentation/pages/clue_page.dart';
import 'package:huntly/features/hunts/presentation/pages/hunt_edit_page.dart';
import 'package:huntly/features/hunts/presentation/widgets/tab.dart';
import 'package:iconify_flutter/icons/ic.dart';

class HuntPlay extends StatefulWidget {
  const HuntPlay({Key? key}) : super(key: key);

  @override
  State<HuntPlay> createState() => _HuntPlayState();
}

class _HuntPlayState extends State<HuntPlay> with TickerProviderStateMixin {
  late TabController _tabController;

  final List<Widget> _tab = [
    HuntTab(color: darkTheme.colorScheme.secondary)
  ];
  final List<Widget> _tabMenu = [
    const CluePage(),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tab.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return HuntlyScaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.only(top: 10),
            child: TabBar(
              // isScrollable: true, 
              tabs: _tab.map((e) => e).toList(),
              controller: _tabController,
              indicatorColor: Colors.transparent,
              overlayColor: MaterialStateProperty.all<Color>(Colors.transparent),
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: _tabMenu.map((e) => e).toList(),
            ),
          ),
          const SizedBox(height: 100)
        ],
      ), outerContext: context,
    );
  }
}
