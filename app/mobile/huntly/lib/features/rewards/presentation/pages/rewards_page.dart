import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:huntly/core/utils/scaffold.dart';
import 'package:huntly/features/rewards/presentation/bloc/rewards_bloc.dart';
import 'package:huntly/features/rewards/presentation/widgets/rewards_card.dart';

import '../../../hunts/presentation/pages/home_page.dart';

class RewardsPage extends StatefulWidget {
  const RewardsPage({Key? key}) : super(key: key);

  @override
  State<RewardsPage> createState() => _RewardsPageState();
}

class _RewardsPageState extends State<RewardsPage> {
  @override
  void initState() {
    BlocProvider.of<RewardsBloc>(context).add(GetUserRewards());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => HomePage()));
        return Future.value(true);
      },
      child: HuntlyScaffold(
        outerContext: context,
        body: BlocConsumer<RewardsBloc, RewardsState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is Loaded) {
              return ListView.builder(
                  itemCount: state.rewards.length,
                  itemBuilder: (context, index) {
                    return RewardsCard(
                      code: state.rewards[index].code,
                      link: state.rewards[index].url,
                      description: state.rewards[index].description,
                      orgName: state.rewards[index].orgName,
                      imageLocation: state.rewards[index].imageLink,
                    );
                  });
            } else {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
