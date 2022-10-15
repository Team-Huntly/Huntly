import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:huntly/core/utils/service.dart';
import 'package:huntly/features/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:huntly/features/authentication/presentation/pages/profile_page.dart';
import 'package:huntly/features/hunts/presentation/pages/my_hunts_page.dart';
import 'package:huntly/features/hunts/presentation/pages/recents_page.dart';
import 'package:huntly/features/memories/presentation/pages/memories_menu_page.dart';
import 'package:huntly/features/rewards/presentation/pages/rewards_page.dart';
import 'package:huntly/main.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/carbon.dart';
import 'package:iconify_flutter/icons/ic.dart';
import 'package:iconify_flutter/icons/ri.dart';
import 'package:iconify_flutter/icons/healthicons.dart';
import 'package:iconify_flutter/icons/mdi.dart';
import 'package:iconify_flutter/icons/ph.dart';
import 'package:iconify_flutter/icons/bx.dart';
import 'package:iconify_flutter/icons/uiw.dart';

import '../../core/theme/theme.dart';
import '../../features/authentication/presentation/pages/profile_page_edit.dart';
import '../../features/hunts/presentation/pages/find_hunt_page.dart';
import '../../features/hunts/presentation/pages/home_page.dart';
import 'get_google_signin.dart';

class DrawerListItem extends StatelessWidget {
  final String icon;
  final Function() onTap;
  final String title;

  const DrawerListItem(
      {Key? key, required this.icon, required this.onTap, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading:
            Iconify(icon, size: 30, color: darkTheme.colorScheme.secondary),
        title: Text(
          title.toUpperCase(),
          style: TextStyle(
              color: darkTheme.colorScheme.secondary,
              fontSize: 20,
              fontWeight: FontWeight.w400),
        ),
        onTap: onTap);
  }
}

Future<GoogleSignInAccount?> getUser() async {
  final GoogleSignIn googleSignIn = getGoogleSignin();
  return googleSignIn.signIn();
}

class HuntlyScaffold extends StatelessWidget {
  final Widget body;
  final BuildContext outerContext;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final FloatingActionButton? floatingActionButton;

  const HuntlyScaffold(
      {Key? key,
      required this.body,
      required this.outerContext,
      this.floatingActionButtonLocation,
      this.floatingActionButton})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: darkTheme.colorScheme.background,
        floatingActionButton: floatingActionButton,
        floatingActionButtonLocation: floatingActionButtonLocation,
        appBar: AppBar(
          foregroundColor: darkTheme.colorScheme.onBackground,
          backgroundColor: darkTheme.colorScheme.background,
          elevation: 0,
          leadingWidth: 80,
        ),
        drawer: Drawer(
          backgroundColor: darkTheme.colorScheme.background,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: darkTheme.colorScheme.background,
                ),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(100)),
                        child: Image.network(
                          user_.photoUrl ?? "https://picsum.photos/200",
                          width: 80,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        user_.firstName + ' ' + user_.lastName,
                        style: darkTheme.textTheme.headline2,
                      )
                    ]),
              ),
              DrawerListItem(
                  icon: Ri.home_2_line,
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const HomePage()));
                  },
                  title: 'Home'),
              DrawerListItem(
                  icon: Healthicons.ui_user_profile,
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const ProfileEditPage()));
                  },
                  title: 'Profile'),
              DrawerListItem(
                  icon: Mdi.file_find_outline,
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const FindHuntPage()));
                  },
                  title: 'Find'),
              DrawerListItem(
                  icon: Carbon.recently_viewed,
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const RecentsPage()));
                  },
                  title: 'Recent'),
              DrawerListItem(
                  icon: Ic.outline_diamond,
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const MyHuntsPage()));
                  },
                  title: 'My Hunts'),
              DrawerListItem(
                  icon: Ph.currency_circle_dollar,
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const RewardsPage()));
                  },
                  title: 'Rewards'),
              DrawerListItem(
                  icon: Bx.photo_album,
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const MemoriesMenuPage()));
                  },
                  title: 'Memories'),
              DrawerListItem(
                  icon: Ic.round_mail_outline,
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  title: 'Invites'),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: DrawerListItem(
                      icon: Uiw.logout,
                      onTap: () {
                        BlocProvider.of<AuthenticationBloc>(outerContext)
                            .add(AuthenticationLogOut());
                        Future.delayed(Duration(seconds: 1));
                        Navigator.of(outerContext)
                            .popUntil((route) => route.isFirst);
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => const Huntly()));
                      },
                      title: 'Logout'),
                ),
              )
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: body,
        ));
  }
}
