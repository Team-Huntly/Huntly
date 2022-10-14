import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:huntly/core/utils/scaffold.dart';
import 'package:huntly/features/huntsCreate/presentation/pages/hunt_create.dart';
import 'package:huntly/features/huntsCreate/presentation/pages/place_picker.dart';
import 'package:huntly/features/huntsCreate/presentation/widgets/form_text_field.dart';
import 'package:huntly/features/hunts/presentation/widgets/tab.dart';
import 'package:place_picker/place_picker.dart';
import '../../../../core/theme/theme.dart';
import '../../../../core/utils/action_button.dart';
import '../bloc/hunts_create_bloc.dart';

class HuntEditPage extends StatefulWidget {
  const HuntEditPage({Key? key}) : super(key: key);

  @override
  State<HuntEditPage> createState() => _HuntEditPageState();
}

class _HuntEditPageState extends State<HuntEditPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _totalSeatsController = TextEditingController();
  final TextEditingController _teamSizeController = TextEditingController();
  LocationResult? _locationResult;
  DateTime? _stateDate;
  DateTime? _endDate;

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HuntsCreateBloc, HuntsCreateState>(
      listener: (context, state) {
        if (state is HuntCreated) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
            ),
          );
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => HuntCreate(),
          ));
          // ignore: curly_braces_in_flow_control_structures
        } else if (state is Error) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Could not create hunt"),
            ),
          );
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => HuntEditPage(),
          ));
        }
      },
      builder: (context, state) {
        return HuntlyScaffold(
          outerContext: context,
          body: Column(children: [
            Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
              Form(
                key: _formKey,
                child: Column(children: [
                  const SizedBox(height: 100),
                  FormTextField(
                    hint: '',
                    label: 'Name',
                    type: TextInputType.text,
                    controller: _nameController,
                  ),
                  FormTextField(
                    hint: '',
                    label: 'Total seats',
                    type: TextInputType.number,
                    controller: _totalSeatsController,
                  ),
                  FormTextField(
                    hint: '',
                    label: 'Team size',
                    type: TextInputType.number,
                    controller: _teamSizeController,
                  ),
                ]),
              ),
              Row(children: [
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: ActionButton(
                      text: 'Save',
                      color: darkTheme.indicatorColor,
                      onTap: () {
                        if (_formKey.currentState!.validate() &&
                            _stateDate != null &&
                            _endDate != null &&
                            _locationResult != null) {
                          BlocProvider.of<HuntsCreateBloc>(context).add(
                            CreateHunt(
                              name: _nameController.text,
                              total_seats:
                                  int.parse(_totalSeatsController.text),
                              team_size: int.parse(_teamSizeController.text),
                              location: _locationResult!,
                              endedAt: _endDate.toString(),
                              startedAt: _stateDate.toString(),
                              theme: 1,
                            ),
                          );
                        }
                      }),
                ),
                ActionButton(
                    text: 'Pick Location',
                    color: darkTheme.indicatorColor,
                    onTap: () async {
                      LocationResult? result = await Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => PlacePickerNew(
                                  "AIzaSyDQEaVpcxfkOXMDDqdHfk0kgMUxJF5zXU0")));
                      if (result != null) {
                        setState(() {
                          _locationResult = result;
                        });
                      }
                      // Handle the result in your way
                      // print(result!.name);
                      // print(result.latLng!.latitude);
                      // print(result.latLng!.longitude);
                    }),
              ]),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: ActionButton(
                        text: 'Start Time',
                        color: darkTheme.indicatorColor,
                        onTap: () {
                          DatePicker.showDateTimePicker(context,
                              showTitleActions: true,
                              minTime: DateTime.now(),
                              maxTime: DateTime(2024, 6, 7),
                              onChanged: (date) {}, onConfirm: (datetime) {
                            setState(() {
                              _stateDate = datetime;
                              _endDate = null;
                            });
                          },
                              currentTime: DateTime.now(),
                              locale: LocaleType.en);
                        }),
                  ),
                  ActionButton(
                      text: 'End Time',
                      color: darkTheme.indicatorColor,
                      onTap: () async {
                        if (_stateDate == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Please select start time first'),
                            ),
                          );
                        } else {
                          DatePicker.showDateTimePicker(context,
                              showTitleActions: true,
                              minTime:
                                  _stateDate!.add(const Duration(minutes: 120)),
                              maxTime: DateTime(2024, 6, 7), onChanged: (date) {
                            print('change $date');
                          }, onConfirm: (datetime) {
                            setState(() {
                              _endDate = datetime;
                            });
                          },
                              currentTime: DateTime.now(),
                              locale: LocaleType.en);
                        }
                      }),
                ]),
              ),
              Text("Selected location: ${_locationResult?.name ?? ''}"),
              Text("Selected start time: ${_stateDate ?? ''}"),
              Text("Selected end time: ${_endDate ?? ''}"),
            ])
          ]),
        );
      },
    );
  }
}
