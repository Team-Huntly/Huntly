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
      const String OAUTH_CLIENT_ID =
          '363088523272-rlre479rohbbo4ti8p7sdmshm9bq9f5h.apps.googleusercontent.com';
      GoogleSignIn _googleSignIn = GoogleSignIn(
        // Optional clientId
        // serverClientId: '500990447063-tclvi1rdaaugi424hsnkt5kmdj0vfhhg.apps.googleusercontent.com',
        serverClientId: OAUTH_CLIENT_ID,
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

        _googleSignIn.onCurrentUserChanged
            .listen((GoogleSignInAccount? account) {
          _currentUser = account;
        });
        _googleSignIn.signInSilently();

        try {
          final googleUser = await _googleSignIn.signIn();
          final googleAuth = await googleUser!.authentication;
          print(googleAuth.accessToken);
        } catch (e) {
          // Authentication Failure
          emit(AuthenticationFailure());
          debugPrint(e.toString());
        }
      } else if (event is AuthenticationLogOut) {
        _googleSignIn.disconnect();
      }
    });
  }
}
