
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'views/url_input_view.dart';

/// Entry point of the Flutter application.
void main() {
  runApp(const MyApp());
}

/// Root widget of the application.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Assignment',
      home: UrlInputView(),
      debugShowCheckedModeBanner: false,
    );
  }
}