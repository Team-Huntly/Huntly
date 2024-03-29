import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:huntly/core/utils/scaffold.dart';
import 'package:huntly/core/utils/service.dart';
import 'package:huntly/core/utils/text_field.dart';
import 'package:huntly/features/authentication/domain/entities/user.dart';
import 'package:huntly/features/authentication/presentation/widgets/box_renderer.dart';
import 'package:huntly/features/hunts/presentation/pages/home_page.dart';
import '../../../../common/constants.dart';
import '../../../../core/theme/theme.dart';
import '../../../../core/utils/action_button.dart';
import '../bloc/authentication_bloc.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    setState(() {});
    super.initState();
  }

  final TextEditingController _controller = TextEditingController();
  ValueNotifier<List<Interests>> selectedWords = ValueNotifier([]);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthenticationBloc, AuthenticationState>(
        listener: (context, state) {
      if (state is ProfileAdded) {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const HomePage()));
      }
    }, builder: (context, state) {
      if (state is Loading) {
        print("its Loading");
        return HuntlyScaffold(
          outerContext: context,
          body: const Center(child: CircularProgressIndicator()),
          showDrawer: false,
        );
      }
      return HuntlyScaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(100)),
                child: Image.network(
                  user_.photoUrl ?? "https://picsum.photos/200",
                  width: 80,
                ),
              ),
              Center(
                child: Text(
                  user_.firstName,
                  style: darkTheme.textTheme.headline2,
                ),
              ),
              Center(
                child: Text(
                  user_.email,
                  style: darkTheme.textTheme.headline5,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20),
                child: TextField(
                    controller: _controller,
                    maxLines: 5,
                    maxLength: 150,
                    style: darkTheme.textTheme.bodyText2,
                    decoration: inputDecoration(
                        'What would you like others to know about you?')),
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
                text: 'Submit',
                onTap: () {
                  BlocProvider.of<AuthenticationBloc>(context).add(
                      AddProfileEvent(
                          bio: _controller.text,
                          interests: selectedWords.value));
                },
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
        outerContext: context,
      );
    });
  }
}
