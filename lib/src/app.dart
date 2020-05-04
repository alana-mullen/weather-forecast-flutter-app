
import 'package:flutter/material.dart';
import 'package:weatherforecastflutter/src/routing/route_generator.dart';
//import 'package:flutter_localizations/flutter_localizations.dart';

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather Forecast',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
          fontFamily: 'Lato',
          primarySwatch: Colors.lightBlue,
          primaryTextTheme: TextTheme(
            title: TextStyle(
              color: Colors.black,
            ),
          ),
          textTheme: TextTheme(
              title: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                  fontFamily: 'Lato'
              ),
              body1: TextStyle(
                  fontSize: 16.0,
                  fontFamily: 'Lato'
              )
          )
      ),
      onGenerateRoute: RouteGenerator.generateRoute,
      /* localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
            const Locale('en', 'UK'), // English
      ], */
    );
  }
}

