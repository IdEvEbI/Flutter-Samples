import 'package:flutter/material.dart';

import 'common/colors.dart';

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
        theme: _buildMyTheme(),
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

  ThemeData _buildMyTheme() {
    final ThemeData base = ThemeData.light();

    return base.copyWith(
      accentColor: kShrineBrown900,
      primaryColor: kShrinePink100,
      buttonColor: kShrinePink100,
      scaffoldBackgroundColor: kShrineBackgroundWhite,
      cardColor: kShrineBackgroundWhite,
      textSelectionColor: kShrinePink100,
      errorColor: kShrineErrorRed,
    );
  }
}
