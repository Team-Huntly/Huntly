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
import '../../data/models/clue_model.dart';

class ClueCreatePage extends StatefulWidget {
  // Function to call when the user presses the button
  final Function onDelete;
  int index;
  final ValueNotifier<List<ClueModel>> clubs;
  ClueCreatePage(
      {Key? key,
      required this.onDelete,
      required this.index,
      required this.clubs})
      : super(key: key);

  @override
  State<ClueCreatePage> createState() => _ClueCreatePageState();
}

class _ClueCreatePageState extends State<ClueCreatePage>
    with AutomaticKeepAliveClientMixin<ClueCreatePage> {
  LocationResult? _locationResult;
  TextEditingController _hintController = TextEditingController();
  TextEditingController _answerController = TextEditingController();
  bool isQrBased = false;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 20),
        Form(
          key: _formKey,
          child: Column(
            children: [
              TextField(
                  controller: _hintController,
                  maxLines: 5,
                  style: darkTheme.textTheme.bodyText2,
                  decoration: inputDecoration('Clue hint...')),
              SizedBox(height: 20),
              TextField(
                  controller: _answerController,
                  maxLines: 3,
                  style: darkTheme.textTheme.bodyText2,
                  decoration: inputDecoration('Answer...')),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Checkbox(value: isQrBased, onChanged: (bool? value) {
                    setState(() {
                      isQrBased = value!;
                    });
                  },
                  activeColor: darkTheme.highlightColor,),
                  Text('QR based', style: darkTheme.textTheme.bodyText2),
                ],
              )
            ],
          ),
        ),
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
        const SizedBox(height: 20),
        ActionButton(
          text: "Save",
          leading: Ph.download_simple_fill,
          onTap: () {
            if (_formKey.currentState!.validate() &&
                _locationResult != null) {
              ClueModel club = ClueModel(
                  stepNo: widget.index + 1,
                  description: _hintController.text,
                  answerDescription: _answerController.text,
                  answerLatitude:
                      _locationResult!.latLng!.latitude.toString(),
                  answerLongitude:
                      _locationResult!.latLng!.longitude.toString(),
                  isQrBased: isQrBased);

              widget.clubs.value.add(club);
            } else {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text('Please fill all the fields')));
            }
          }
        ),
        Padding(
          padding: const EdgeInsets.only(top: 18.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              
              widget.index != 0
                  ? ActionButton(
                      text: "Delete",
                      leading: Ic.baseline_delete_outline,
                      onTap: () {
                        setState(() {
                          widget.onDelete(widget.index);
                        });
                      })
                  : Container(),
            ],
          ),
        ),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
