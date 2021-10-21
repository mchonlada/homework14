import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'pages/guess.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: GoogleFonts.athiti().fontFamily,
        primarySwatch: Colors.blue,
        textTheme: const TextTheme(
          headline1: TextStyle(
            fontSize: 40.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          headline2: TextStyle(
            fontSize: 25.0,
            color: Colors.white,
          ),
          bodyText1: TextStyle(
            fontSize: 25.0,
            color: Colors.brown,
            fontWeight: FontWeight.bold,
          ),
          bodyText2: TextStyle(
            fontSize: 25.0,
            color: Colors.deepPurple,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      routes: {
        GuessAge.routeName: (context) => const GuessAge(),
        Answer.routeName: (context) => const Answer(),
      },
      initialRoute: GuessAge.routeName,
    );
  }
}