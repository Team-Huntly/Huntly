import 'package:flutter/material.dart';
import 'package:huntly/core/theme/theme.dart';
import 'package:huntly/core/utils/action_button.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/mdi.dart';
import 'package:iconify_flutter/icons/ic.dart';
import 'package:iconify_flutter/icons/ph.dart';

import '../../../../core/utils/text_field.dart';

class ClueCreatePage extends StatelessWidget {
  const ClueCreatePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 20),
        TextField(
            maxLines: 5,
            maxLength: 250,
            style: darkTheme.textTheme.bodyText2,
            decoration: inputDecoration('Clue hint...')),
        const SizedBox(height: 15),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.white),
              borderRadius: const BorderRadius.all(Radius.circular(10))),
          child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Iconify(
              Mdi.map_marker_outline,
              color: Colors.white,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'D516 NITK',
                    style: darkTheme.textTheme.bodyText1,
                  ),
                  const SizedBox(height: 10),
                  GestureDetector(
                      child: Text(
                    'Edit',
                    textAlign: TextAlign.left,
                    style: darkTheme.textTheme.bodyText1!.copyWith(
                        color: darkTheme.highlightColor,
                        fontWeight: FontWeight.w700),
                  )),
                ],
              ),
            ),
          ]),
        ),
        ActionButton(
          text: 'Add QR',
          onTap: () {},
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Image.asset(
              'assets/images/qr.png',
              width: 80,
              height: 80,
            ),
            ActionButton(leading: Ph.download_simple_fill, onTap: () {}),
            ActionButton(leading: Ic.baseline_delete_outline, onTap: () {}),
          ],
        )
      ],
    );
  }
}
