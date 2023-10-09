import 'package:ecom_buy/screens/auth_screen/login_screen.dart';
import 'package:ecom_buy/screens/bottom_page.dart';
import 'package:ecom_buy/screens/bottom_screens/home_screen.dart';
import 'package:ecom_buy/utils/styles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class LandingScreen extends StatelessWidget {
  // const LandingScreen({super.key});
  Future<FirebaseApp> initilize = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: initilize,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            return Scaffold(
              body: Center(child: Text('${snapshot.error}')),
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return StreamBuilder(
                stream: FirebaseAuth.instance.authStateChanges(),
                builder: (BuildContext context, AsyncSnapshot streamSnapshot) {
                  if (streamSnapshot.hasError) {
                    return Scaffold(
                      body: Center(child: Text('${snapshot.error}')),
                    );
                  }
                  if (streamSnapshot.connectionState ==
                      ConnectionState.active) {
                    User? user = streamSnapshot.data;
                    if (user == null) {
                      return LoginScreen();
                    } else {
                      return BottomPage();
                    }
                  }
                  return const Scaffold(
                    body: Center(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'CHECKING AUTHENTICATIONS...',
                          textAlign: TextAlign.center,
                          style: EcoStyle.boldStyle,
                        ),
                        CircularProgressIndicator(),
                      ],
                    )),
                  );
                });
          }
          return const Scaffold(
            body: Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'INITILIZATION...',
                  style: EcoStyle.boldStyle,
                ),
                CircularProgressIndicator(),
              ],
            )),
          );
        });
  }
}
