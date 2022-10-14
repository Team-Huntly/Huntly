import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:huntly/core/utils/service.dart';
import 'package:huntly/features/hunts/presentation/bloc/treasurehunt_bloc.dart';
import 'package:huntly/features/hunts/presentation/pages/home_page.dart';
import 'package:huntly/features/rewards/presentation/bloc/rewards_bloc.dart';

import 'features/authentication/presentation/bloc/authentication_bloc.dart';
import 'features/authentication/presentation/pages/authentication_page.dart';
import 'features/authentication/presentation/pages/profile_page.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'features/huntsCreate/presentation/bloc/hunts_create_bloc.dart';
import 'features/memories/presentation/bloc/memories_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // final prefs = await SharedPreferences.getInstance();
  // if (!prefs.containsKey("profile")) {
  //   prefs.setInt("profile", 0);
  // }
  // if (!prefs.containsKey("name")) {
  //   username_ = prefs.getString("name")!;
  // }
  // if (!prefs.containsKey("email")) {
  //   email_ = prefs.getString("email")!;
  // }
  // if (!prefs.containsKey("photo")) {
  //   photoUrl_ = prefs.getString("photo")!;
  // }
  // prefs.setInt("profile", 0);
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
        BlocProvider<TreasureHuntBloc>(
          create: (context) => TreasureHuntBloc(),
        ),
        BlocProvider<HuntsCreateBloc>(
          create: (context) => HuntsCreateBloc(),
        ),
        BlocProvider<RewardsBloc>(create: (context) => RewardsBloc()),
        BlocProvider<MemoriesBloc>(create: (context) => MemoriesBloc())
      ],
      child: MaterialApp(
        scrollBehavior: MyCustomScrollBehavior(),
        title: 'Huntly',
        // darkTheme
        theme: ThemeData.dark(),
        home: const WrapperPage(),
      ),
    );
  }
}

class WrapperPage extends StatefulWidget {
  const WrapperPage({Key? key}) : super(key: key);

  @override
  State<WrapperPage> createState() => _WrapperPageState();
}

class _WrapperPageState extends State<WrapperPage> {
  static const String OAUTH_CLIENT_ID =
      '363088523272-orkcfiqub7hshaq29pisji796or7ohpq.apps.googleusercontent.com';

  final GoogleSignIn _googleSignIn = GoogleSignIn(
    serverClientId: OAUTH_CLIENT_ID,
    scopes: <String>[
      'email',
      'profile',
    ],
  );

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _googleSignIn.isSignedIn(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text('Error');
          } else if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.data == false) {
              return const AuthenticationPage();
            } else {
              return FutureBuilder(
                  future: SharedPreferences.getInstance(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if ((snapshot.data as SharedPreferences)
                              .getInt("profile") ==
                          0) {
                        return const ProfilePage();
                      } else {
                        return const HomePage();
                      }
                    }
                    return const Center(child: CircularProgressIndicator());
                  });
            }
          } else {
            return const CircularProgressIndicator();
          }
        });
  }
}
