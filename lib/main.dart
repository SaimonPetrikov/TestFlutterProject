import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_project/core/constant.dart';

import 'core/data/api/service_locator.dart';
import 'package:flutter_project/core/constant.dart';
import 'features/apod/presentation/pages/apod_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runZoned<Future<void>>(
        () async {
      await ServiceLocator.init();

      runApp(MyApp());
    },
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'APOD',
      theme: ThemeData(
        primaryColor: kPrimaryColor,
      ),
      home: HomeScreen(),
    );
  }
}
