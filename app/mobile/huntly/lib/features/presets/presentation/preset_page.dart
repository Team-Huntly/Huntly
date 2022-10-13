import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:huntly/features/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:huntly/features/authentication/presentation/widgets/box_renderer.dart';
import 'package:huntly/features/presets/widgets/preset_card.dart';
import 'package:iconify_flutter/iconify_flutter.dart';

import '../../../../common/constants.dart';
import '../../../../core/theme/theme.dart';
import '../../../core/utils/scaffold.dart';

class PresetPage extends StatefulWidget {
  const PresetPage({Key? key}) : super(key: key);

  @override
  State<PresetPage> createState() => _PresetPage();
}

class _PresetPage extends State<PresetPage> {
  TextEditingController _controller = TextEditingController();
  @override
  void initState() {
    setState(() {});
    super.initState();
  }

  ValueNotifier<List<Interests>> selectedWords = ValueNotifier([]);
  @override
  Widget build(BuildContext context) {
    return HuntlyScaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Create a search bar with a search icon
            Container(
              margin: const EdgeInsets.all(20),
              child: TextField(
                controller: _controller,
                style: GoogleFonts.poppins(
                    fontSize: 16, fontWeight: FontWeight.w500),
                decoration: InputDecoration(
                  filled: true,
                  hintText: 'SEARCH',
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

            // Create a list of presets
            PresetCard(presetName: "Running", noTHunts: "8"),
            PresetCard(presetName: "Dancing", noTHunts: "8"),
            PresetCard(presetName: "Yoga", noTHunts: "8"),
          ],
        ),
      ),
    );
  }
}
