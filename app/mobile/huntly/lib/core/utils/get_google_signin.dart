import 'package:google_sign_in/google_sign_in.dart';

GoogleSignIn getGoogleSignin() {
  const String oAuthClientId =
      '363088523272-orkcfiqub7hshaq29pisji796or7ohpq.apps.googleusercontent.com';
  final GoogleSignIn googleSignIn = GoogleSignIn(
    // Optional clientId
    // serverClientId: '500990447063-tclvi1rdaaugi424hsnkt5kmdj0vfhhg.apps.googleusercontent.com',
    serverClientId: oAuthClientId,
    scopes: <String>[
      'email',
      'profile',
    ],
  );
  return googleSignIn;
}