import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:huntly/core/utils/scaffold.dart';
import 'package:huntly/main.dart';

class GamePage extends StatefulWidget {
  const GamePage({Key? key}) : super(key: key);

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  @override
  Widget build(BuildContext context) {
    return HuntlyScaffold(
      outerContext: context,
      body: Column(
        children: const [
          Text('Game Page'),
        ],
      ),
    );
  }
}
