import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:huntly/core/utils/scaffold.dart';
import 'package:huntly/features/huntsCreate/presentation/widgets/form_text_field.dart';
import 'package:huntly/features/hunts/presentation/widgets/tab.dart';
import '../../../../core/theme/theme.dart';
import '../../../../core/utils/action_button.dart';

class HuntEditPage extends StatefulWidget {
  const HuntEditPage({Key? key}) : super(key: key);

  @override
  State<HuntEditPage> createState() => _HuntEditPageState();
}

class _HuntEditPageState extends State<HuntEditPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _totalSeatsController = TextEditingController();
  final TextEditingController _teamSizeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        Form(
            child: Column(children: [
          const SizedBox(height: 100),
          FormTextField(
            hint: '',
            label: 'Name',
            type: TextInputType.text,
            controller: _nameController,
          ),
          FormTextField(
            hint: '',
            label: 'Total seats',
            type: TextInputType.number,
            controller: _totalSeatsController,
          ),
          FormTextField(
            hint: '',
            label: 'Team size',
            type: TextInputType.number,
            controller: _teamSizeController,
          ),
          ActionButton(
            text: 'Save',
            color: darkTheme.indicatorColor,
            onTap: () {},
          ),
        ]))
      ])
    ]);
  }
}
