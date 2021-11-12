import 'package:flutter/material.dart';
import 'package:hulp/modules/view/events/createEvent.dart';
import 'package:hulp/modules/view/homePage.dart';
import 'package:hulp/modules/view/login.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hulp/modules/view/signUp/signUp.dart';
import 'package:hulp/modules/entities/event.dart';
import 'modules/view/AddEventPlace.dart';
import 'modules/view/events/EventDetails.dart';
import 'modules/view/teams.dart';
import 'modules/view/teamsDetail.dart';
import 'modules/view/welcomePage.dart';

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
        visualDensity: VisualDensity.adaptivePlatformDensity
      ),
      home: WelcomePage(),
      routes: {
        '/event/new': (context) => CreateEventPage(),
        '/event/location': (context) => LocationSelectPage(),
        '/event/detail': (context) => EventDetail(),
        '/signup/': (context) => SignUpPage(),
        '/login/': (context) => LoginPage(),
        '/home/': (context) => HomePage(),
        '/teams/new': (context) => TeamsDetail(),
        '/teams': (context) => TeamPage(),
      },
    );
  }
}

