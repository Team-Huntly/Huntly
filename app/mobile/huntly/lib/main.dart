import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:huntly/features/hunts/presentation/bloc/treasurehunt_bloc.dart';
import 'package:huntly/features/hunts/presentation/pages/home_page.dart';
import 'package:huntly/features/presets/presentation/preset_page.dart';

import 'features/authentication/presentation/bloc/authentication_bloc.dart';
import 'features/authentication/presentation/pages/authentication_page.dart';
import 'features/authentication/presentation/pages/profile_page.dart';

import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  if (!prefs.containsKey("profile")) {
    prefs.setInt("profile", 0);
  }
  runApp(const Huntly());
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}

class Huntly extends StatelessWidget {
  const Huntly({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthenticationBloc>(
          create: (context) => AuthenticationBloc(),
        ),
        BlocProvider<TreasureHuntBloc>(create: (context) => TreasureHuntBloc()),
      ],
      child: MaterialApp(
        scrollBehavior: MyCustomScrollBehavior(),
        title: 'Huntly',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MyHomePage(
          title: "asd",
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WrapperPage();
  }
}

class WrapperPage extends StatefulWidget {
  const WrapperPage({Key? key}) : super(key: key);

  @override
  State<WrapperPage> createState() => _WrapperPageState();
}

class _WrapperPageState extends State<WrapperPage> {
  GoogleSignInAccount? _currentUser;

  static const String OAUTH_CLIENT_ID =
      '363088523272-orkcfiqub7hshaq29pisji796or7ohpq.apps.googleusercontent.com';
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    // Optional clientId
    // serverClientId: '500990447063-tclvi1rdaaugi424hsnkt5kmdj0vfhhg.apps.googleusercontent.com',
    serverClientId: OAUTH_CLIENT_ID,
    scopes: <String>[
      'email',
      'profile',
    ],
  );

  @override
  Widget build(BuildContext context) {
    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount? account) {
      print('account: $account');
      setState(() {
        _currentUser = account;
      });
    });
    // return ProfilePage();
    return FutureBuilder(
        future: _googleSignIn.isSignedIn(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text('Error');
          } else if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.data == false) {
              return AuthenticationPage();
            } else {
              return FutureBuilder(
                  future: SharedPreferences.getInstance(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      print((snapshot.data as SharedPreferences)
                          .getInt("profile"));
                      if ((snapshot.data as SharedPreferences)
                              .getInt("profile") ==
                          0) {
                        return ProfilePage();
                      } else {
                        return HomePage();
                      }
                    }
                    return Center(child: CircularProgressIndicator());
                  });
            }
          } else {
            return const CircularProgressIndicator();
          }
        });
  }
}
