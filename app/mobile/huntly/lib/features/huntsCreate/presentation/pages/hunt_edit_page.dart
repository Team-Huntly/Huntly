import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

import 'package:huntly/core/utils/scaffold.dart';
import 'package:huntly/features/huntsCreate/presentation/pages/hunt_create.dart';
import 'package:huntly/features/huntsCreate/presentation/pages/place_picker.dart';
import 'package:huntly/features/huntsCreate/presentation/widgets/form_text_field.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/mdi.dart';
import 'package:intl/intl.dart';
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
  DateTime? _startDate;
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
            builder: (context) => HuntCreate(huntId: state.id),
          ));
          // ignore: curly_braces_in_flow_control_structures
        } else if (state is Error) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Could not create hunt"),
            ),
          );
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => const HuntEditPage(),
          ));
        }
      },
      builder: (context, state) {
        return HuntlyScaffold(
            outerContext: context,
            body: SingleChildScrollView(
              child: Column(children: [
                Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Form(
                        key: _formKey,
                        child: Column(children: [
                          const SizedBox(height: 30),
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
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 5, vertical: 10),
                        decoration: BoxDecoration(
                            border: Border.all(color: darkTheme.disabledColor),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10))),
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
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
                                      _locationResult?.name ??
                                          "No location selected",
                                      style: darkTheme.textTheme.bodyText1,
                                    ),
                                    const SizedBox(height: 10),
                                    GestureDetector(
                                        onTap: () async {
                                          LocationResult? result = await Navigator
                                                  .of(context)
                                              .push(MaterialPageRoute(
                                                  builder: (context) =>
                                                      PlacePickerNew(
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
                                          style: darkTheme.textTheme.bodyText1!
                                              .copyWith(
                                                  color:
                                                      darkTheme.highlightColor,
                                                  fontWeight: FontWeight.w700),
                                        )),
                                  ],
                                ),
                              ),
                            ]),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 5, vertical: 10),
                        decoration: BoxDecoration(
                            border: Border.all(color: darkTheme.disabledColor),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10))),
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Iconify(
                                Mdi.calendar,
                                color: Colors.white,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    GestureDetector(
                                      onTap: () async {
                                        DatePicker.showDateTimePicker(context,
                                            showTitleActions: true,
                                            minTime: DateTime.now(),
                                            maxTime: DateTime(2024, 6, 7),
                                            onChanged: (date) {},
                                            onConfirm: (datetime) {
                                          setState(() {
                                            _startDate = datetime;
                                            _endDate = datetime.add(
                                                const Duration(days: 1));
                                          });
                                        },
                                            currentTime: DateTime.now(),
                                            locale: LocaleType.en);
                                      },
                                      child: Text(
                                        _startDate != null
                                            ? DateFormat.yMd()
                                                .add_jm()
                                                .format(_startDate!)
                                            : 'Start date',
                                        style: darkTheme.textTheme.bodyText2,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ]),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 5, vertical: 10),
                        decoration: BoxDecoration(
                            border: Border.all(color: darkTheme.disabledColor),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10))),
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Iconify(
                                Mdi.calendar,
                                color: Colors.white,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    GestureDetector(
                                      onTap: () async {
                                        DatePicker.showDateTimePicker(context,
                                            showTitleActions: true,
                                            minTime: DateTime.now(),
                                            maxTime: DateTime(2024, 6, 7),
                                            onChanged: (date) {},
                                            onConfirm: (datetime) {
                                          setState(() {
                                            _endDate = datetime;
                                          });
                                        },
                                            currentTime: DateTime.now(),
                                            locale: LocaleType.en);
                                      },
                                      child: Text(
                                        _endDate != null
                                            ? DateFormat.yMd()
                                                .add_jm()
                                                .format(_endDate!)
                                            : 'End date',
                                        style: darkTheme.textTheme.bodyText2,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ]),
                      ),
                      const SizedBox(height: 20),
                      ActionButton(
                          text: 'Save',
                          color: darkTheme.indicatorColor,
                          onTap: () {
                            if (_formKey.currentState!.validate() &&
                                _startDate != null &&
                                _endDate != null &&
                                _locationResult != null) {
                              BlocProvider.of<HuntsCreateBloc>(context).add(
                                CreateHunt(
                                  name: _nameController.text,
                                  total_seats:
                                      int.parse(_totalSeatsController.text),
                                  team_size:
                                      int.parse(_teamSizeController.text),
                                  location: _locationResult!,
                                  endedAt: _endDate.toString(),
                                  startedAt: _startDate.toString(),
                                  theme: 2,
                                ),
                              );
                            }
                          }),
                    ]),
              ]),
            ));
      },
    );
  }
}
