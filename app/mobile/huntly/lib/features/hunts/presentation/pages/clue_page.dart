import 'package:flutter/material.dart';
import 'package:huntly/core/theme/theme.dart';
import 'package:huntly/core/utils/action_button.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/mdi.dart';
import 'package:iconify_flutter/icons/ic.dart';
import 'package:iconify_flutter/icons/ph.dart';
import 'package:iconify_flutter/icons/ri.dart';
import 'package:iconify_flutter/icons/ooui.dart';
import 'package:colorful_iconify_flutter/icons/noto.dart';

class CluePage extends StatelessWidget {
  const CluePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 70),
        Text(
          'Clue #1/6',
          style: darkTheme.textTheme.caption
        ),
        const SizedBox(height: 50),
        Text(
          'A man who was outside in the rain without an umbrella or hat didn’t get a single hair on his head wet. Why?',
          style: darkTheme.textTheme.bodyText2
        ),
        const SizedBox(height: 15),
        ActionButton(leading: Mdi.map_marker_multiple, text: 'Verify', onTap: () {},),
        ActionButton(leading: Ri.qr_scan_2_line, text: 'Verify', onTap: () {},),
        ActionButton(leading: Ooui.next_ltr, alignment: Alignment.bottomRight, onTap: () {},),
        Text(
          'A man who was outside in the rain without an umbrella or hat didn’t get a single hair on his head wet. Why?',
          style: darkTheme.textTheme.bodyText2!.copyWith(
            fontSize: 12,
            color: darkTheme.disabledColor
          )
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ActionButton(text: 'Success', leading: Noto.party_popper, onTap: () {}, colorIcon: false, color: darkTheme.colorScheme.secondary,),
            const SizedBox(width: 10),
            ActionButton(leading: Mdi.camera_wireless_outline, onTap: () {}, color: darkTheme.colorScheme.primary)
          ],
        )
        // Container(
        //   padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
        //   decoration: BoxDecoration(
        //     border: Border.all(
        //       color: Colors.white
        //     ),
        //     borderRadius: const BorderRadius.all(Radius.circular(10))
        //   ),
        //   child: Row(
        //     crossAxisAlignment: CrossAxisAlignment.start,
        //     children: [
        //       const Iconify(
        //         Mdi.map_marker_outline,
        //         color: Colors.white,
        //       ),
        //       Padding(
        //         padding: const EdgeInsets.only(left: 10),
        //         child: Column(
        //           crossAxisAlignment: CrossAxisAlignment.start,
        //           children: [
        //             Text(
        //               'D516\nNITK Hostels\nSurathkal, Mangalore\nKarnataka',
        //               style: darkTheme.textTheme.bodyText1,
        //             ),
        //             const SizedBox(height: 10),
        //             GestureDetector(
        //               child: Text(
        //                 'Edit',
        //                 textAlign: TextAlign.left,
        //                 style: darkTheme.textTheme.bodyText1!.copyWith(color: darkTheme.highlightColor, fontWeight: FontWeight.w700),
        //               )
        //             ),
        //           ],
        //         ),
        //       ),
        //     ]
        //   ),
        // ),
      ],
    );
  }
}