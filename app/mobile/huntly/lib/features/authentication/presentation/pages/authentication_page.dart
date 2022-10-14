import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:huntly/features/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:huntly/features/authentication/presentation/pages/profile_page.dart';
import 'package:huntly/features/hunts/presentation/pages/home_page.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:colorful_iconify_flutter/icons/logos.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/theme/theme.dart';

class AuthenticationPage extends StatefulWidget {
  const AuthenticationPage({Key? key}) : super(key: key);

  @override
  State<AuthenticationPage> createState() => _AuthenticationPageState();
}

class _AuthenticationPageState extends State<AuthenticationPage> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) async {
        if (state is AuthenticationSuccess) {
          final prefs = await SharedPreferences.getInstance();
          if (prefs.getInt("profile") == 0) {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ProfilePage()));
          } else {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => HomePage()));
          }
        }
      },
      child: Scaffold(
        backgroundColor: darkTheme.colorScheme.background,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // const SizedBox(height: 30),
              Image.asset('assets/images/map.png'),
              Positioned(
                top: 350,
                child: Text(
                  'Huntly'.toUpperCase(),
                  style: darkTheme.textTheme.headline1,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Welcome to Huntly!",
                  style: darkTheme.textTheme.headline4,
                ),
              ),
              Text(
                "Your one stop destination for making connections and memories you’ll treasure forever.",
                style: darkTheme.textTheme.bodyText2,
              ),
              const SizedBox(height: 35),
              ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        darkTheme.colorScheme.onBackground),
                    fixedSize: MaterialStateProperty.all<Size>(
                        const Size.fromWidth(250)),
                    padding: MaterialStateProperty.all<EdgeInsets>(
                        const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 10)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Iconify(Logos.google_icon),
                      const SizedBox(width: 15),
                      Text(
                        'Sign-In with Google',
                        style: darkTheme.textTheme.button!.copyWith(
                            color: darkTheme.colorScheme.background,
                            fontSize: 16),
                      )
                    ],
                  ),
                  onPressed: () async {
                    BlocProvider.of<AuthenticationBloc>(context)
                        .add(AuthenticationStarted());
                  })
            ],
          ),
        ),
      ),
    );
  }
}
