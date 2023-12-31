import 'package:ecom_buy/screens/landing_screen.dart';
import 'package:ecom_buy/screens/web-side/addProducts_screen.dart';
import 'package:ecom_buy/screens/web-side/dashboard_screen.dart';
import 'package:ecom_buy/screens/web-side/deleteProducts_screen.dart';
import 'package:ecom_buy/screens/web-side/updateProduct_screen.dart';
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
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyCCiwQMiTsDyiOlFlNhxEKhBEkCKfp2fio",
            authDomain: "eco-buy.firebaseapp.com",
            projectId: "eco-buy",
            storageBucket: "eco-buy.appspot.com",
            messagingSenderId: "400546493929",
            appId: "1:400546493929:web:b33e3d8f9b51d9cbf0c778"));
  } else {
    await Firebase.initializeApp();
  }
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) => MaterialApp(
        title: 'ECO BUY',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          backgroundColor: Colors.white,
          scaffoldBackgroundColor: Colors.white,
        ),
        // home: LandingScreen(),
        home: WebLoginScreen(),
        routes: {
          WebLoginScreen.id: (context) => WebLoginScreen(),
          WebMainScreen.id: (context) => WebMainScreen(),
          AddProductScreen.id: (context) => AddProductScreen(),
          UpdateProductScreen.id: (context) => UpdateProductScreen(),
          DeleteProductScreen.id: (context) => DeleteProductScreen(),
          DashBoardScreen.id: (context) => DashBoardScreen(),
        },
      ),
    );
  }
}
