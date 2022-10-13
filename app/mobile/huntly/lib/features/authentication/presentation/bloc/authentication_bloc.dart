import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc() : super(AuthenticationInitial()) {
    on<AuthenticationEvent>((event, emit) async {
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

      if (event is AuthenticationStarted) {
        // Authentication Started
        emit(AuthenticationLoading());
        GoogleSignInAccount? _currentUser;
        String _contactText = '';

        googleSignIn.onCurrentUserChanged
            .listen((GoogleSignInAccount? account) {
          _currentUser = account;
        });
        googleSignIn.signInSilently();

        try {
          final googleUser = await googleSignIn.signIn();
          final googleAuth = await googleUser!.authentication;
          print(googleAuth.accessToken);
        } catch (e) {
          // Authentication Failure
          emit(AuthenticationFailure());
          debugPrint(e.toString());
        }
      } else if (event is AuthenticationLogOut) {
        googleSignIn.disconnect();
      }
    });
  }
}
