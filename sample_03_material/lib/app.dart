import 'package:flutter/material.dart';

import 'routes/home.dart';
import 'routes/login.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'Mateial',
        home: HomePage(),
        debugShowCheckedModeBanner: false,
      );
}
