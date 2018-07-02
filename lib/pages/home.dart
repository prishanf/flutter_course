import 'package:flutter/material.dart';
import 'package:flutter_course/product_manager.dart';
import './products_admin.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: <Widget>[
            AppBar(
              automaticallyImplyLeading: false,
              title: Text('Choose'),
            ),
            ListTile(
              title: Text('Manage Products'),
              onTap: () {
                Navigator.pushReplacementNamed(context,'admin');
              },
            )
          ],
        ),
      ),
      appBar: AppBar(
        title: Text("My First App"),
      ),
      body: ProductManager(),
    );
  }
}
