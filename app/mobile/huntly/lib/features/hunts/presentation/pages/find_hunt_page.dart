import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/utils/scaffold.dart';
import '../bloc/treasurehunt_bloc.dart';
import '../widgets/hunt_card.dart';

class FindHuntPage extends StatefulWidget {
  const FindHuntPage({Key? key}) : super(key: key);

  @override
  State<FindHuntPage> createState() => _FindHuntPageState();
}

class _FindHuntPageState extends State<FindHuntPage> {
  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return HuntlyScaffold(
      outerContext: context,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Create a search bar with a search icon
            Container(
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
                        Icon(Icons.search),
                        SizedBox(
                          width: 10,
                        ),
                        Icon(Icons.filter_list),
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
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  );
                } else if (state is Loaded) {
                  return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 24),
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: state.treasureHunts.length,
                          itemBuilder: (context, index) {
                            return HuntCard(
                                treasureHunt: state.treasureHunts[index]);
                          },
                        )
                      ]);
                } else if (state is TreasureHuntInitial) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    BlocProvider.of<TreasureHuntBloc>(context)
                        .add(GetTreasureHunts());
                  });
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  );
                } else {
                  return const Center(
                    child: Text('Error'),
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
