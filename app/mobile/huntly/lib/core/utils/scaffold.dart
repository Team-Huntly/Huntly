import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:huntly/features/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:huntly/features/authentication/presentation/pages/profile_page.dart';
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
import '../../features/hunts/presentation/pages/home_page.dart';

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

class HuntlyScaffold extends StatelessWidget {
  final Widget body;
  final BuildContext outerContext;
  const HuntlyScaffold(
      {Key? key, required this.body, required this.outerContext})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: darkTheme.colorScheme.background,
        appBar: AppBar(
          foregroundColor: darkTheme.colorScheme.onBackground,
          backgroundColor: darkTheme.colorScheme.background,
          elevation: 0,
          leadingWidth: 80,
        ),
        drawer: Drawer(
          backgroundColor: darkTheme.colorScheme.background,
          child: Column(
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: darkTheme.colorScheme.background,
                ),
                child: Column(children: []),
              ),
              DrawerListItem(
                  icon: Ri.home_2_line,
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const HomePage()));
                  },
                  title: 'Home'),
              DrawerListItem(
                  icon: Healthicons.ui_user_profile,
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const ProfilePage()));
                  },
                  title: 'Profile'),
              DrawerListItem(
                  icon: Mdi.file_find_outline, onTap: () {}, title: 'Find'),
              DrawerListItem(
                  icon: Carbon.recently_viewed, onTap: () {}, title: 'Recent'),
              DrawerListItem(
                  icon: Ic.outline_diamond, onTap: () {}, title: 'My Hunts'),
              DrawerListItem(
                  icon: Ph.currency_circle_dollar,
                  onTap: () {},
                  title: 'Rewards'),
              DrawerListItem(
                  icon: Bx.photo_album, onTap: () {}, title: 'Memories'),
              DrawerListItem(
                  icon: Ic.round_mail_outline, onTap: () {}, title: 'Invites'),
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
              ),
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: body,
        ));
  }
}
