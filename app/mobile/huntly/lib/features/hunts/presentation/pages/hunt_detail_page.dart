import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:huntly/core/utils/action_button.dart';
import 'package:huntly/core/utils/scaffold.dart';
import 'package:huntly/features/hunts/presentation/widgets/hunt_info_card.dart';
import 'package:iconify_flutter/icons/ic.dart';
import 'package:iconify_flutter/icons/mdi.dart';
import 'package:iconify_flutter/icons/majesticons.dart';
import 'package:colorful_iconify_flutter/icons/twemoji.dart';

import '../../../../core/theme/theme.dart';

class HuntDetailPage extends StatefulWidget {
  const HuntDetailPage({Key? key}) : super(key: key);

  @override
  State<HuntDetailPage> createState() => _HuntDetailPageState();
}

class _HuntDetailPageState extends State<HuntDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(height: 50),
        Row(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              child: SizedBox(
                height: 120,
                width: 100,
                child: Image.asset(
                  'assets/images/0.jpg',
                  // height: 200,
                  // width: 100,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Container(
                  child: Text(
                    'Manipal Inst. of Technology Hunt!',
                    style: darkTheme.textTheme.headline2!.copyWith(
                      height: 1.2
                    )
                  ),
                ),
              ),
            )
          ],
        ),
        const SizedBox(height: 25,),
        Wrap(
          alignment: WrapAlignment.center,
          runSpacing: 10,
          spacing: 10,
          children: [
            HuntInfoCard(
              icon: Ic.baseline_calendar_today,
              title: 'On',
              info: '17/6/22',
            ),
            HuntInfoCard(
              icon: Ic.baseline_alarm,
              title: 'Starts at',
              info: '17:00',
            ),
            HuntInfoCard(
              icon: Mdi.map_marker_outline,
              title: 'Location',
              info: 'kEF, MIT',
              trailing: Majesticons.external_link_line,
            ),
          ],
        ),
        const SizedBox(height: 25,),
        ActionButton(
          text: 'Register',
          onTap: () {},
          color: darkTheme.indicatorColor,
        ),
        const SizedBox(height: 10,),
        ActionButton(
          text: 'Unregister',
          onTap: () {},
          color: darkTheme.colorScheme.secondary,
        ),
        const SizedBox(height: 10,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ActionButton(onTap: () {}, text: 'Lock teams'),
            const SizedBox(width: 10),
            ActionButton(onTap: () {}, leading: Ic.twotone_edit,)
          ],
        ),
        const SizedBox(height: 10,),
        ActionButton(
          text: 'Teams locked',
          onTap: () {},
          color: darkTheme.colorScheme.secondary,
          leading: Twemoji.locked_with_key,
          colorIcon: false,
        )
      ],
    );
  }
}