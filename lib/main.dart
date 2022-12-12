import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:real_api/peovider/all_user_provider.dart';
import 'package:real_api/peovider/catagory_provider.dart';
import 'package:real_api/peovider/order_provider.dart';
import 'package:real_api/peovider/prodact_provider.dart';
import 'package:real_api/scrren/auth/loginpage.dart';
import 'package:real_api/scrren/splash.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context)=>OrderProvider()),
        ChangeNotifierProvider(create: (context)=>CatagoryProvider()),
        ChangeNotifierProvider(create: (context)=>ProdactProvider()),
        ChangeNotifierProvider(create: (context)=>ProfileProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(

          primarySwatch: Colors.blue,
        ),
        home: SplashScreen(),
      ),
    );
  }
}
