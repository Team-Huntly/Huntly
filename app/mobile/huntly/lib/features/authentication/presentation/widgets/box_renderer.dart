import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:huntly/common/constants.dart';
import 'package:huntly/features/authentication/presentation/widgets/word_button.dart';

import '../../../../core/theme/theme.dart';

class BoxRenderer extends StatelessWidget {
  final Map<String, List<Interests>> interests;
  ValueNotifier<List<Interests>> selectedWords;
  BoxRenderer({required this.interests, required this.selectedWords});

  @override
  Widget build(BuildContext context) {
    List<Interests> interestsList = interests.values.expand((i) => i).toList();
    String category = interests.keys.first;
    return IntrinsicWidth(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            category,
            style: darkTheme.textTheme.headline4,
          ),
          Wrap(
            children: interestsList
                .map((element) => WordButton(
                    word: element,
                    isSelected: false,
                    selectedWords: selectedWords))
                .toList(),
          ),
        ],
      ),
    );
  }
}
