import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:huntly/core/utils/scaffold.dart';
import 'package:huntly/features/rewards/presentation/widgets/rewards_card.dart';

class RewardsPage extends StatefulWidget {
  const RewardsPage({Key? key}) : super(key: key);

  @override
  State<RewardsPage> createState() => _RewardsPageState();
}

class _RewardsPageState extends State<RewardsPage> {
  @override
  Widget build(BuildContext context) {
    return HuntlyScaffold(
      outerContext: context,
      body: RewardsCard(
        code: '325rsdv',
        link: 'www.sdfsf.com',
        description: 'UPTO 50% OFF + extra 10% OFF via CODE',
        orgName: 'Spotify',
        imageLocation: 'assets/images/spotify.png',
      )
    );
  }
}