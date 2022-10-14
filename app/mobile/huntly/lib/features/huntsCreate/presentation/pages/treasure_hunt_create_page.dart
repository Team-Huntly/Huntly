import 'package:flutter/material.dart';
import 'package:huntly/core/theme/theme.dart';
import 'package:huntly/core/utils/action_button.dart';
import 'package:huntly/core/utils/scaffold.dart';
import 'package:huntly/features/huntsCreate/presentation/pages/clue_create_page.dart';
import 'package:huntly/features/huntsCreate/presentation/pages/hunt_edit_page.dart';
import 'package:huntly/features/hunts/presentation/widgets/tab.dart';
import 'package:iconify_flutter/icons/ic.dart';

class HuntCreate extends StatefulWidget {
  const HuntCreate({Key? key}) : super(key: key);

  @override
  State<HuntCreate> createState() => _HuntCreateState();
}

class _HuntCreateState extends State<HuntCreate> with TickerProviderStateMixin {
  late TabController _tabController;

  final List<Widget> _tab = [HuntTab(color: darkTheme.colorScheme.secondary)];
  final List<Widget> _tabMenu = [
    const HuntEditPage(),
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
            overlayColor: MaterialStateProperty.all<Color>(Colors.transparent),
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
          Align(
            alignment: Alignment.bottomRight,
            child: ActionButton(
              alignment: Alignment.bottomRight,
              // text: 'Add clue',
              leading: Ic.baseline_plus,
              onTap: () {
                setState(() {
                  _tab.add(HuntTab(color: darkTheme.colorScheme.primary));
                  _tabMenu.add(Column(
                    children: [
                      const SizedBox(height: 20),
                      Text("Clue #${_tabController.index + 1}",
                          style: darkTheme.textTheme.caption),
                      const ClueCreatePage()
                    ],
                  ));
                  _tabController =
                      TabController(length: _tab.length, vsync: this);
                  _tabController.animateTo(_tab.length - 1);
                });
              },
            ),
          ),
          const SizedBox(height: 100)
        ],
      ),
      outerContext: context,
    );
  }
}
