import 'package:flutter/material.dart';
import 'package:huntly/core/theme/theme.dart';
import 'package:huntly/core/utils/action_button.dart';
import 'package:huntly/features/huntsCreate/presentation/pages/place_picker.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/mdi.dart';
import 'package:iconify_flutter/icons/ic.dart';
import 'package:iconify_flutter/icons/ph.dart';
import 'package:place_picker/entities/location_result.dart';

import '../../../../core/utils/text_field.dart';

class ClueCreatePage extends StatefulWidget {
  const ClueCreatePage({Key? key}) : super(key: key);

  @override
  State<ClueCreatePage> createState() => _ClueCreatePageState();
}

class _ClueCreatePageState extends State<ClueCreatePage>
    with AutomaticKeepAliveClientMixin<ClueCreatePage> {
  LocationResult? _locationResult;

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
                    _locationResult?.name ?? "No location selected",
                    style: darkTheme.textTheme.bodyText1,
                  ),
                  const SizedBox(height: 10),
                  GestureDetector(
                      onTap: () async {
                        LocationResult? result = await Navigator.of(context)
                            .push(MaterialPageRoute(
                                builder: (context) => PlacePickerNew(
                                    "AIzaSyDQEaVpcxfkOXMDDqdHfk0kgMUxJF5zXU0")));
                        if (result != null) {
                          setState(() {
                            _locationResult = result;
                          });
                        }
                      },
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
        Padding(
          padding: const EdgeInsets.only(top: 18.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ActionButton(
                  text: "Save", leading: Ph.download_simple_fill, onTap: () {}),
              ActionButton(
                  text: "Delete",
                  leading: Ic.baseline_delete_outline,
                  onTap: () {}),
            ],
          ),
        ),
      ],
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
