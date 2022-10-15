import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:huntly/core/utils/action_button.dart';

import 'package:huntly/core/utils/scaffold.dart';
import 'package:huntly/core/utils/text_field.dart';
import 'package:huntly/features/authentication/presentation/widgets/box_renderer.dart';
import 'package:huntly/features/hunts/presentation/pages/home_page.dart';
import '../../../../common/constants.dart';
import '../../../../core/theme/theme.dart';
import '../bloc/authentication_bloc.dart';

class ProfileEditPage extends StatefulWidget {
  const ProfileEditPage({Key? key}) : super(key: key);

  @override
  State<ProfileEditPage> createState() => _ProfileEditPageState();
}

class _ProfileEditPageState extends State<ProfileEditPage> {
  @override
  void initState() {
    BlocProvider.of<AuthenticationBloc>(context).add(GetProfileEvent());
    super.initState();
  }

  late TextEditingController _controller;
  ValueNotifier<List<Interests>> selectedWords = ValueNotifier([]);

  void updateSelectedWords(String interests) {
    if (interests == "") return;
    Map<String, dynamic> jsonText = jsonDecode(interests);
    jsonText.forEach((key, value) {
      value.split(",").forEach((element) {
        //remove from and back space in element
        element = element.replaceAll(" ", "");
        if (sendInterest(element) != null) {
          selectedWords.value.add(sendInterest(element)!);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        if (state is ProfileAdded) {
          BlocProvider.of<AuthenticationBloc>(context).add(GetProfileEvent());
        }
      },
      builder: (context, state) {
        if (state is ProfileLoaded) {
          updateSelectedWords(state.profileModel.interests ?? "");
          _controller = TextEditingController(text: state.profileModel.bio);
          return HuntlyScaffold(
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: 100,
                    width: 100,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: Colors.red),
                  ),
                  Center(
                    child: Text(
                      'John Doe',
                      style: darkTheme.textTheme.headline2,
                    ),
                  ),
                  Center(
                    child: Text(
                      'jhondoe@gmail.com',
                      style: darkTheme.textTheme.headline3,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 20),
                    child: TextField(
                        controller: _controller,
                        maxLines: 5,
                        maxLength: 150,
                        style: darkTheme.textTheme.bodyText2,
                        decoration: inputDecoration(state.profileModel.bio == ''
                            ? 'What would you like others to know about you?'
                            : state.profileModel.bio.toString())),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  BoxRenderer(
                    interests: creativity,
                    selectedWords: selectedWords,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  BoxRenderer(
                    interests: sports,
                    selectedWords: selectedWords,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  BoxRenderer(
                    interests: pets,
                    selectedWords: selectedWords,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  BoxRenderer(
                    interests: values,
                    selectedWords: selectedWords,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  BoxRenderer(
                    interests: food,
                    selectedWords: selectedWords,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  BoxRenderer(
                    interests: music,
                    selectedWords: selectedWords,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  BoxRenderer(
                    interests: films,
                    selectedWords: selectedWords,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  BoxRenderer(
                    interests: reading,
                    selectedWords: selectedWords,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  BoxRenderer(
                    interests: travel,
                    selectedWords: selectedWords,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  BoxRenderer(
                    interests: hobbies,
                    selectedWords: selectedWords,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  ActionButton(
                    onTap: () {
                      BlocProvider.of<AuthenticationBloc>(context).add(
                        AddProfileEvent(
                            bio: _controller.text,
                            interests: selectedWords.value),
                      );
                    },
                    text: 'Submit',
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),
            outerContext: context,
          );
        } else if (state is Loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return const Center(
            child: Text("Something went wrong"),
          );
        }
      },
    );
  }
}
