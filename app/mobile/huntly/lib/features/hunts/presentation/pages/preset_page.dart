import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:huntly/core/theme/theme.dart';

import 'package:huntly/features/hunts/presentation/widgets/preset_card.dart';
import '../../../../../common/constants.dart';
import '../../../../core/utils/scaffold.dart';

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
            TextField(
              controller: _controller,
              style: GoogleFonts.poppins(
                  fontSize: 16, fontWeight: FontWeight.w500),
              decoration: InputDecoration(
                filled: true,
                hintText: 'Search',
                hintStyle: darkTheme.textTheme.bodyText2!.copyWith(color: darkTheme.disabledColor),
                suffixIcon: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Icon(Icons.search),
                      SizedBox(
                        width: 10,
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
            const SizedBox(height: 50),
            const PresetCard(presetName: "Running", numberOfHunts: 8),
            const PresetCard(presetName: "Dancing", numberOfHunts: 6),
            const PresetCard(presetName: "Yoga", numberOfHunts: 5),
          ],
        ),
      ),
    );
  }
}
