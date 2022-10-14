import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:huntly/core/utils/scaffold.dart';
import 'package:huntly/features/hunts/presentation/widgets/form_text_field.dart';
import 'package:huntly/features/hunts/presentation/widgets/tab.dart';
import '../../../../core/theme/theme.dart';
import '../../../../core/utils/action_button.dart';

class HuntDetailPage extends StatefulWidget {
  const HuntDetailPage({Key? key}) : super(key: key);

  @override
  State<HuntDetailPage> createState() => _HuntDetailPageState();
}

class _HuntDetailPageState extends State<HuntDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Form(
              child: Column(
                children: [
                  const SizedBox(height: 100),
                  const FormTextField(hint: '', label: 'Name', type: TextInputType.text),
                  const FormTextField(hint: '', label: 'Total seats', type: TextInputType.number),
                  const FormTextField(hint: '', label: 'Team size', type: TextInputType.number),
                  ActionButton(
                    text: 'Save',
                    color: darkTheme.indicatorColor,
                    onTap: () {},
                  ),
                ]
              )
            )
          ]
        )
      ]
    );
  }
}
