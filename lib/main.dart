// @dart=2.9
import 'package:city_navigation/controllers/navigationController.dart';
import 'package:city_navigation/pages/home.dart';
import 'package:city_navigation/pages/welcome.dart';
import 'package:city_navigation/providers/AppData.dart';
import 'package:city_navigation/utilities/sessionData.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'constants/AppStyle.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => NavigationController()),
        ChangeNotifierProvider(create: (context) => AppData()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  bool tokenAvailable = false;
  @override
  void initState() {
    checkToken();
    super.initState();
  }

  checkToken() async {
    final token = await SessionManager.getCurrentUserToken();
    tokenAvailable = token.isNotEmpty;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          systemNavigationBarColor: Colors.white,
          systemNavigationBarIconBrightness: Brightness.dark),
    );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'City Navigation',
      theme: ThemeData(
        primaryColor: AppStyle.primaryColor,
        primarySwatch: Colors.blue,
        textTheme: GoogleFonts.montserratTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      home: tokenAvailable ? const HomePage() : const WelcomePage(),
    );
  }
}
