import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:teaching_game/app/db/premath_hive.dart';
import 'package:teaching_game/app/modules/home/views/home_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Directory path = await getApplicationDocumentsDirectory();
  Hive
    ..init(path.path)
    ..registerAdapter(PreMathProgressModelAdapter());
  await Hive.openBox<PreMathProgressModel>('premath');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeView(),
      theme: ThemeData(fontFamily: 'ADLaMDisplay'),
    );
  }
}
