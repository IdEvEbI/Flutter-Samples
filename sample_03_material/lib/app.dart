import 'package:flutter/material.dart';

import 'routes/home.dart';
import 'routes/login.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'Mateial',
        home: HomePage(),
        debugShowCheckedModeBanner: false,
        initialRoute: '/login',
        onGenerateRoute: _getRoute,
      );

  Route _getRoute(RouteSettings settings) {
    if (settings.name != '/login') {
      return null;
    }

    return MaterialPageRoute(
      settings: settings,
      builder: (context) => LoginPage(),
      fullscreenDialog: true,
    );
  }
}
