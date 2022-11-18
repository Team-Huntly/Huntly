import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:huntly/features/hunts/presentation/pages/home_page.dart';

import '../../../../core/utils/scaffold.dart';
import '../bloc/treasurehunt_bloc.dart';
import '../widgets/hunt_card.dart';

class FindHuntPage extends StatefulWidget {
  const FindHuntPage({Key? key}) : super(key: key);

  @override
  State<FindHuntPage> createState() => _FindHuntPageState();
}

class _FindHuntPageState extends State<FindHuntPage> {
  @override
  void initState() {
    BlocProvider.of<TreasureHuntBloc>(context).add(GetTreasureHunts());
    super.initState();
  }

  TextEditingController _controller = TextEditingController();

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
        body: Column(
          children: [
            // Create a search bar with a search icon
            Padding(
              padding: const EdgeInsets.only(bottom: 18.0),
              child: TextField(
                controller: _controller,
                style: GoogleFonts.poppins(
                    fontSize: 16, fontWeight: FontWeight.w500),
                decoration: InputDecoration(
                  filled: true,
                  hintText: 'Search',
                  suffixIcon: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Icon(Icons.search, color: Colors.black),
                        SizedBox(
                          width: 10,
                        ),
                        Icon(
                          Icons.filter_list,
                          color: Colors.black,
                        ),
                      ],
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  fillColor: Colors.white,
                ),
              ),
            ),
            BlocConsumer<TreasureHuntBloc, TreasureHuntState>(
              listener: (context, state) {
                if (state is TreasureHuntInitial) {
                  BlocProvider.of<TreasureHuntBloc>(context)
                      .add(GetTreasureHunts());
                }
              },
              builder: (context, state) {
                if (state is Loading) {
                  return const Padding(
                    padding: EdgeInsets.only(top: 40),
                    child: Center(
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    ),
                  );
                } else if (state is Loaded) {
                  if (state.treasureHunts.isEmpty) {
                    return Padding(
                        padding: const EdgeInsets.all(8),
                        child: Text(
                          'No Treasure Hunts Found',
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ));
                  } else {
                    return Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: state.treasureHunts.length,
                        itemBuilder: (context, index) {
                          return HuntCard(
                              treasureHunt: state.treasureHunts[index]);
                        },
                      ),
                    );
                  }
                } else if (state is TreasureHuntInitial) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    BlocProvider.of<TreasureHuntBloc>(context)
                        .add(GetTreasureHunts());
                  });
                  return const Center(child: CircularProgressIndicator());
                } else {
                  return const Center(
                    child: Text('Treasure Hunts not Found'),
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
