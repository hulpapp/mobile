import 'package:flutter/material.dart';
import 'package:hulp/modules/view/events/createEvent.dart';
import 'package:hulp/modules/view/homePage.dart';
import 'package:hulp/modules/view/login.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hulp/modules/view/signUp/signUp.dart';

// import 'modules/view/singUp/signUp.dart';

void main() {

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hulp App',
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      supportedLocales: [const Locale('pt', 'BR')],
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: LoginPage(),
      routes: {
        '/event/new': (context) => CreateEventPage(),
        '/signup/': (context) => SignUpPage(),
        '/login': (context) => LoginPage(),
        // '/mapVisualizer': (context) => MapVisualizer(),
      },
    );
  }
}

