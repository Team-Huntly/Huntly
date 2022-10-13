import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:huntly/common/constants.dart';
import 'package:huntly/features/authentication/presentation/widgets/wordbutton.dart';

import '../../../../core/theme/theme.dart';

class BoxRenderer extends StatelessWidget {
  final Map<String, List<Interests>> interests;
  ValueNotifier<List<Interests>> selectedWords;
  BoxRenderer({required this.interests, required this.selectedWords});

  @override
  Widget build(BuildContext context) {
    List<Interests> interestsList = interests.values.expand((i) => i).toList();
    String category = interests.keys.first;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 0.0),
          child: Text(
            category,
            style: darkTheme.textTheme.headline4,
          ),
        ),
        Container(
          decoration: BoxDecoration(
            // color: Back
          ),
          child: Wrap(
            // children: phrases.map((element) => WordButton(word: element)).toList(),
            children: interestsList
                .map((element) => WordButton(
                    word: element,
                    isSelected: false,
                    selectedWords: selectedWords))
                .toList(),
          ),
        ),
      ],
    );
  }
}
