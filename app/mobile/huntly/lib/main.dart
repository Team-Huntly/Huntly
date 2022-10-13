import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

//pages
import 'features/authentication/presentation/pages/authentication_page.dart';

void main() {
  runApp(const Huntly());
}

class Huntly extends StatelessWidget {
  const Huntly({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Huntly',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Huntly'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  GoogleSignInAccount? _currentUser;

  static const String OAUTH_CLIENT_ID =
      '363088523272-orkcfiqub7hshaq29pisji796or7ohpq.apps.googleusercontent.com';
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    // Optional clientId
    // serverClientId: '500990447063-tclvi1rdaaugi424hsnkt5kmdj0vfhhg.apps.googleusercontent.com',
    serverClientId: OAUTH_CLIENT_ID,
    scopes: <String>[
      'email',
      'profile',
    ],
  );

  StreamController<int> mystream =
    StreamController<int>.broadcast();
  @override
    void initState() {
     GoogleSignInAccount? a =  _googleSignIn.currentUser;
      if(a != null){
        mystream.add(1);
      }
      else{
        mystream.add(0);
      }
      super.initState();
    }
  @override
  Widget build(BuildContext context) {
    
    // return FutureBuilder(
    //   future: _googleSignIn.isSignedIn(),
    //   builder: (context , snapshot){
    //     print(snapshot.data);
    //     print(snapshot.connectionState);

    //     if(snapshot.hasError){
    //       return const Text('Error');
    //     }
    //     else if(snapshot.connectionState == ConnectionState.done){
    //       if(snapshot.data == false){
    //         return AuthenticationPage();
    //       }else{
    //         return const Text('Not Signed In');
    //       }
          
    //     }else {
    //       return const CircularProgressIndicator();
    //     }
    //   }

    // ); 

    // _googleSignIn.onCurrentUserChanged.listen((event) {
    //     if(event != null){
    //       print('Signed In');
    //     }else{
    //       print('Not Signed In');
    //     }

    // });
  return StreamBuilder<int>(
    stream: mystream.stream,
    builder: (context , snapshot){
      print(snapshot.data);
      if(snapshot.hasError){
        return const Text('Error');
      }
      else if(snapshot.connectionState == ConnectionState.done){
        if(snapshot.data == 0){
          return AuthenticationPage();
        }else{
          return const Text('Not Signed In');
        }
        
      }else {
        return const CircularProgressIndicator();
      }
    }
    );
  //  return StreamBuilder<GoogleSignInAccount?>(
  //   stream: _googleSignIn.onCurrentUserChanged,
  //   builder: (context, snapshot) {
  //     print(snapshot.data);
  //     print(snapshot.connectionState);
  //     if (snapshot.hasError) {
  //       return const Text('Error');
  //     } else if (snapshot.connectionState == ConnectionState.done) {
  //       if (snapshot.data == false) {
  //         print("Hello");
  //         return AuthenticationPage();
  //       } else {
  //         return const Text('Signed In');
  //       }
  //     } else {
  //       return AuthenticationPage();
  //     }
  //   },
  //  );
  
  }
}
