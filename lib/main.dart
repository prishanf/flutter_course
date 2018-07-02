import 'package:flutter/material.dart';

import './pages/home.dart';
import './pages/auth.dart';
import './pages/products_admin.dart';

main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          brightness: Brightness.light,
          primarySwatch: Colors.deepOrange,
          accentColor: Colors.deepPurple),
      //home: AuthPage(),
      routes: {
        '/': (BuildContext context) => HomePage(),
        'admin': (BuildContext context) => ProductsAdminPage(),
      },
    );
  }
}
