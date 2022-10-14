import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:huntly/features/hunts/presentation/pages/hunt_create.dart';
import 'package:huntly/features/hunts/presentation/pages/hunt_edit_page.dart';
import 'package:huntly/features/hunts/presentation/pages/home_page.dart';
import 'package:huntly/features/hunts/presentation/pages/presets_page.dart';

import 'features/authentication/presentation/bloc/authentication_bloc.dart';
import 'features/authentication/presentation/pages/authentication_page.dart';
import 'features/authentication/presentation/pages/profile_page.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'features/hunts/presentation/pages/clue_page.dart';
import 'features/hunts/presentation/pages/hunt_play.dart';
import 'features/hunts/presentation/pages/hunt_view.dart';

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
      ],
      child: MaterialApp(
        scrollBehavior: MyCustomScrollBehavior(),
        title: 'Huntly',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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

  StreamController<int> mystream = StreamController<int>.broadcast();
  @override
  void initState() {
    _googleSignIn.onCurrentUserChanged.asBroadcastStream();
    GoogleSignInAccount? a = _googleSignIn.currentUser;
    if (a != null) {
      mystream.add(1);
    } else {
      mystream.add(0);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MainPage2();
  }
}

class MainPage2 extends StatefulWidget {
  const MainPage2({Key? key}) : super(key: key);

  @override
  State<MainPage2> createState() => _MainPage2State();
}

class _MainPage2State extends State<MainPage2> {
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
