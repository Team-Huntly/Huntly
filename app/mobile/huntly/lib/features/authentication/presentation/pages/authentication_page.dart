import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:colorful_iconify_flutter/icons/logos.dart';

import '../../../../core/theme/theme.dart';

class AuthenticationPage extends StatefulWidget {
  const AuthenticationPage({Key? key}) : super(key: key);

  @override
  State<AuthenticationPage> createState() => _AuthenticationPageState();
}

class _AuthenticationPageState extends State<AuthenticationPage> {
  
  @override
  Widget build(BuildContext context) {
      const String oAuthClientId = '363088523272-orkcfiqub7hshaq29pisji796or7ohpq.apps.googleusercontent.com';
    
    final GoogleSignIn googleSignIn = GoogleSignIn(
        // Optional clientId
        // serverClientId: '500990447063-tclvi1rdaaugi424hsnkt5kmdj0vfhhg.apps.googleusercontent.com',
        serverClientId: oAuthClientId,
        scopes: <String>[
          'email',
          'profile',
        ],
      );
    return Scaffold(
      backgroundColor: darkTheme.colorScheme.background,
      body: Column(
        children: [
          Text(
            'Huntly'.toUpperCase(),
            style: darkTheme.textTheme.titleLarge,
          ),
          Text(
            'Welcome to Huntly!',
            style: darkTheme.textTheme.labelMedium,
          ),
          FloatingActionButton(
            child: Row(
              children: [
                Iconify(Logos.google_icon),
                
              ],
            ),
            onPressed: () async{
              final googleUser = await googleSignIn.signIn();
            }
          )
        ],
      ),
    );
  }
}
