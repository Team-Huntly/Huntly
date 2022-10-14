import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:huntly/core/utils/scaffold.dart';
import 'package:huntly/features/huntsCreate/presentation/pages/hunt_create.dart';
import 'package:huntly/features/hunts/presentation/pages/presets_page.dart';
import 'package:huntly/features/huntsCreate/presentation/pages/hunt_edit_page.dart';

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
            child: Text(
              'Custom',
              style: TextStyle(fontSize: 40),
            ),
            onTap: () {
              // TODO: Navigate to custom hunt edit page
              // Navigator.of(context).pushReplacement(MaterialPageRoute(
              //     builder: (context) => const HuntEditPage()));
              // TODO remove this
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const HuntCreate()));
            },
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              child: Text('Presets'),
              onTap: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const PresetsPage()));
              },
            ),
          ),
        ],
      ),
    );
  }
}
