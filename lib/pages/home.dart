import 'package:flutter/material.dart';
import 'package:flutter_course/product_manager.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My First App"),
      ),
      body: ProductManager(),
    );
  }
}
