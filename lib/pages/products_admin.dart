import 'package:flutter/material.dart';
import 'home.dart';
class ProductsAdminPage extends StatelessWidget {
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
              title: Text('Home'),
              onTap: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) =>
                            HomePage()));
              },
            )
          ],
        ),
      ),
      appBar: AppBar(title: Text('Manage Products')),
      body: Center(
        child: Text('Manage Product'),
      ),
    );
  }
}
