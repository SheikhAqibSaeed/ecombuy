import 'package:ecom_buy/screens/layout_screen.dart';
import 'package:ecom_buy/screens/web-side/addProducts_screen.dart';
import 'package:ecom_buy/screens/web-side/dashboard_screen.dart';
import 'package:ecom_buy/screens/web-side/deleteProducts_screen.dart';
import 'package:ecom_buy/screens/web-side/updateProduct_screen.dart';
import 'package:ecom_buy/screens/web-side/update_complete_screen.dart';
import 'package:ecom_buy/screens/web-side/web_login.dart';
import 'package:ecom_buy/screens/web-side/web_main.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    // setPathUrlStrategy();
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyDR0tLzmtfqtsxCxDUX8OVXoO0Kab6MI-I",
            authDomain: "ecom-buy-de85e.firebaseapp.com",
            projectId: "ecom-buy-de85e",
            storageBucket: "ecom-buy-de85e.appspot.com",
            messagingSenderId: "831874884447",
            appId: "1:831874884447:web:d656579195f8584d7dccea",
            measurementId: "G-92G4P8N8MN"));
  } else {
    await Firebase.initializeApp();
  }

  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  // enableFlutterDriverExtension();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(
        builder: (context, orientation, deviceType) => MaterialApp(
              title: 'ECO Buy',
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                  primarySwatch: Colors.blue, backgroundColor: Colors.white),
              home: const LayoutScreen(),
              // home: WebMainScreen(),
              routes: {
                WebLoginScreen.id: (context) => WebLoginScreen(),
                WebMainScreen.id: (context) => WebMainScreen(),
                AddProductScreen.id: (context) => AddProductScreen(),
                DeleteProductScreen.id: (context) => DeleteProductScreen(),
                UpdateProductScreen.id: (context) => UpdateProductScreen(),
                DashBoardScreen.id: (context) => DashBoardScreen(),
              },
            ));
  }
}
