import 'package:flutter/material.dart';
import '../flavors/app_properties.dart';

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppProperties.title),
      ),
      body: Center(
        child: Text(
          'Hello ${AppProperties.title}',
        ),
      ),
    );
  }
}
