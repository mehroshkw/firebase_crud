import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crud/firebase_crud/add.dart';
import 'package:firebase_crud/home.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: AddData(),
  ));
}
