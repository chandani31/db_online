import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:online_db_form/Login.dart';

import 'Registration.dart';

void main()
{
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Login(),
      debugShowCheckedModeBanner: false,
    );
  }
}
