import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'features/authentication/presentation/pages/authentication_page.dart';

void main() {
  runApp(const Huntly());
}

class Huntly extends StatelessWidget {
  const Huntly({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Huntly',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const AuthenticationPage(),
    );
  }
}
