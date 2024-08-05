import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:techdocks_assignment/screens/home.dart';
import 'package:timezone/data/latest.dart' as tz;

import 'package:techdocks_assignment/app_themes.dart';
import 'package:techdocks_assignment/database_service/sql_service.dart';
import 'package:techdocks_assignment/services/dark_theme_service.dart';
import 'package:techdocks_assignment/services/notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  NotificationService().initNotification();
  tz.initializeTimeZones();
  await Permission.notification.isDenied.then((value) {
    if (value) {
      Permission.notification.request();
    }
  });
  await SqlServices.initDatabase();
  await GetStorage.init();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Title text',
    
      debugShowCheckedModeBanner: false,
      theme: AppThemes.lightMode,
      themeMode: ThemeService().theme,
      darkTheme: AppThemes.darkMode,
      home: const Home(),
    );
  }
}
