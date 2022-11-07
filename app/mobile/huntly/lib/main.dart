import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:huntly/common/constants.dart';
import 'package:huntly/core/utils/service.dart';
import 'package:huntly/features/hunts/data/datasources/treasure_hunt_remote_datasource.dart';
import 'package:huntly/features/hunts/presentation/bloc/treasurehunt_bloc.dart';
import 'package:huntly/features/hunts/presentation/pages/home_page.dart';
import 'package:huntly/features/rewards/presentation/bloc/rewards_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'features/authentication/presentation/bloc/authentication_bloc.dart';
import 'features/authentication/presentation/pages/authentication_page.dart';
import 'features/authentication/presentation/pages/profile_page.dart';
import 'features/games/presentation/bloc/game_bloc.dart';
import 'features/huntsCreate/presentation/bloc/hunts_create_bloc.dart';
import 'features/memories/presentation/bloc/memories_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();

  final thrs = TreasureHuntRemoteDataSourceImpl();

  final GoogleSignIn _googleSignIn = GoogleSignIn(
    serverClientId: OAUTH_CLIENT_ID,
    scopes: <String>[
      'email',
      'profile',
    ],
  );
  bool isSignedIn = await _googleSignIn.isSignedIn();
  
  if (isSignedIn) {
    try {
      user_ = await thrs.getUser();
    } catch(e) {}
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
        BlocProvider<TreasureHuntBloc>(
          create: (context) => TreasureHuntBloc(),
        ),
        BlocProvider<HuntsCreateBloc>(
          create: (context) => HuntsCreateBloc(),
        ),
        BlocProvider<GameBloc>(
          create: (context) => GameBloc(),
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
        // home: AuthenticationPage()
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
