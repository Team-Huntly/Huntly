import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:huntly/core/utils/get_google_signin.dart';
import 'package:huntly/core/utils/get_headers.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../common/constants.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc() : super(AuthenticationInitial()) {
    on<AuthenticationEvent>((event, emit) async {
      final GoogleSignIn googleSignIn = getGoogleSignin();

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

          var params = {
            "access_token": googleAuth.accessToken,
          };

          Response response = await Dio().post(
            "${url}users/auth/social/google-oauth2/",
            options: Options(
              headers: {
                "Accept": "application/json",
                "Content-Type": "application/json",
              },
            ),
            data: jsonEncode(params),
          );

          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString("token", response.data["token"]);
          emit(AuthenticationSuccess());
        } catch (e) {
          // Authentication Failure

          print("Authentication Failure");
          //!! remove the below line
          emit(AuthenticationFailure());
          debugPrint(e.toString());
        }
      } else if (event is AuthenticationLogOut) {
        googleSignIn.disconnect();
      } else if (event is AddProfileEvent) {
        emit(Loading());
        try {
          final googleUser = await googleSignIn.signIn();
          final googleAuth = await googleUser!.authentication;

          Map<String, String> interestParams = {};
          event.interests.forEach((element) {
            if (interestParams[element.category] == null) {
              interestParams[element.category] = element.interest;
            } else {
              interestParams[element.category] =
                  "${interestParams[element.category]} , ${element.interest}";
            }
          });

          var interestParamsJson = jsonEncode(interestParams);
          var params = {
            "first_name": googleUser.displayName,
            "last_name": "",
            "gender": "M",
            "date_of_birth": "1999-01-01",
            "phone_no": "",
            "bio": event.bio,
            "interests": interestParamsJson
          };

          Response response = await Dio().put(
            "${url}users/update/",
            options: await getHeaders(),
            data: jsonEncode(params),
          );
          final prefs = await SharedPreferences.getInstance();
          prefs.setInt("profile", 1);
          emit(ProfileAdded());
        } catch (e) {
          // Authentication Failure
          emit(AuthenticationFailure());
          debugPrint(e.toString());
        }
      }
    });
  }
}
