import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:huntly/core/utils/scaffold.dart';
import 'package:huntly/features/hunts/presentation/pages/hunt_create.dart';
import 'package:huntly/features/hunts/presentation/pages/presets_page.dart';

class MyHuntsPage extends StatefulWidget {
  const MyHuntsPage({Key? key}) : super(key: key);

  @override
  State<MyHuntsPage> createState() => _MyHuntsPageState();
}

class _MyHuntsPageState extends State<MyHuntsPage> {
  @override
  Widget build(BuildContext context) {
    return HuntlyScaffold(
      outerContext: context,
      body: Column(
        children: [
          GestureDetector(
            child: Text('Custom'),
            onTap: () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const HuntCreate()));
            },
          ),
          GestureDetector(
            child: Text('Presets'),
            onTap: () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const PresetsPage()));
            },
          ),
        ],
      ),
    );
  }
}
