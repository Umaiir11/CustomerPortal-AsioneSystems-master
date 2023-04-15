import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:login/MVVM/View/VwLogin.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            inputDecorationTheme: InputDecorationTheme(
              filled: true, // fill the TextField with the specified color
              fillColor: Colors.grey[200],
              // set the background color of the TextField
            ),
            primarySwatch: Colors.cyan),
        home: VwLogin());
  }
}
