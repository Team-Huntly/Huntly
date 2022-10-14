import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../common/constants.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc() : super(AuthenticationInitial()) {
    on<AuthenticationEvent>((event, emit) async {
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
          print(
              "${url}users/auth/social/google-oauth2/${googleAuth.accessToken}");

          var params = {
            "access_token": googleAuth.accessToken,
          };
          print("Printing params");
          print(jsonEncode(params));
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
          print("Response: ${response.data}");

          emit(AuthenticationSuccess());
        } catch (e) {
          // Authentication Failure
          print("Failure");
          //!! remove the below line
          googleSignIn.disconnect();
          emit(AuthenticationFailure());
          debugPrint(e.toString());
        }
      } else if (event is AuthenticationLogOut) {
        googleSignIn.disconnect();
      } else if (event is AddProfileEvent) {
        emit(Loading());
        try {
          print("Add Profile Event");
          final googleUser = await googleSignIn.signIn();
          final googleAuth = await googleUser!.authentication;
          // print(googleAuth.accessToken);
          // String interestsString = "";

          Map<String, String> testmap = {};
          event.interests.forEach((element) {
            if (testmap[element.category] == null) {
              testmap[element.category] = element.interest;
            } else {
              testmap[element.category] =
                  "${testmap[element.category]} , ${element.interest}";
            }
          });
          var testMap2 = jsonEncode(testmap);
          print(testMap2.runtimeType);
          var params = {
            "first_name": googleUser.displayName,
            "last_name": "",
            "gender": "M",
            "date_of_birth": "1999-01-01",
            "phone_no": "",
            "bio": event.bio,
            "interests": testMap2
          };
          print("Printing params");
          print(jsonEncode(params));
          Response response = await Dio().put(
            "${url}users/update/",
            options: Options(
              headers: {
                "Accept": "application/json",
                "Content-Type": "application/json",
                "Authorization":
                    "Token 6b4a27a545d3a191eaca78e85bcef6703f65aff3"
              },
            ),
            data: jsonEncode(params),
          );
          print("Response: ${response.data}");
          final prefs = await SharedPreferences.getInstance();
          prefs.setInt("profile", 1);
          emit(ProfileAdded());
        } catch (e) {
          // Authentication Failure
          print("Failure");
          emit(AuthenticationFailure());
          debugPrint(e.toString());
        }
      }
    });
  }
}
