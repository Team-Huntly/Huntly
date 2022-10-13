import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/carbon.dart';
import 'package:iconify_flutter/icons/ic.dart';
import 'package:iconify_flutter/icons/ion.dart';
import 'package:iconify_flutter/icons/ri.dart';
import 'package:iconify_flutter/icons/healthicons.dart';
import 'package:iconify_flutter/icons/mdi.dart';
import 'package:iconify_flutter/icons/ph.dart';
import 'package:iconify_flutter/icons/bx.dart';
import 'package:iconify_flutter/icons/uiw.dart';

import '../../core/theme/theme.dart';

class DrawerListItem extends StatelessWidget {
  final String icon;
  final Function() onTap;
  final String title;
  
  const DrawerListItem({
    Key? key,
    required this.icon,
    required this.onTap,
    required this.title
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Iconify(
        icon,
        size: 35,
        color: darkTheme.colorScheme.secondary
      ),
      title: Text(
        title.toUpperCase(),
        style: TextStyle(
          color: darkTheme.colorScheme.secondary,
          fontSize: 28,
          fontWeight: FontWeight.w600
        ),
      ),
      onTap: onTap
    );
  }
}

class HuntlyScaffold extends StatelessWidget {
  final Widget body;
  
  const HuntlyScaffold({Key? key, required this.body}) : super(key: key);

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
            child: Column(
              children: []
            ),
          ),
          DrawerListItem(
            icon: Ri.home_2_line,
            onTap: () {},
            title: 'Home'
          ),
          DrawerListItem(
            icon: Healthicons.ui_user_profile,
            onTap: () {},
            title: 'Profile'
          ),
          DrawerListItem(
            icon: Mdi.file_find_outline,
            onTap: () {},
            title: 'Find'
          ),
          DrawerListItem(
            icon: Carbon.recently_viewed,
            onTap: () {},
            title: 'Recent'
          ),
          DrawerListItem(
            icon: Ic.outline_diamond,
            onTap: () {},
            title: 'My Hunts'
          ),
          DrawerListItem(
            icon: Ph.currency_circle_dollar,
            onTap: () {},
            title: 'Rewards'
          ),
          DrawerListItem(
            icon: Bx.photo_album,
            onTap: () {},
            title: 'Memories'
          ),
          DrawerListItem(
            icon: Ic.round_mail_outline,
            onTap: () {},
            title: 'Invites'
          ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomLeft,
              child: DrawerListItem(
                icon: Uiw.logout,
                onTap: () {},
                title: 'Logout'
              ),
            ),
          ),
        ],
      ),
    ),
      body: body,
    );
  }
}