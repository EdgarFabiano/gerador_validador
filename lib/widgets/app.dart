import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:gerador_validador/defaults/defaults_export.dart';
import 'package:gerador_validador/pages/home_page.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return EasyDynamicThemeWidget(
      child: GeradorValidadorMaterialApp(),
    );
  }
}

class GeradorValidadorMaterialApp extends StatelessWidget {
  const GeradorValidadorMaterialApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Strings.appName,
      theme: ThemeData(
          brightness: Brightness.light, primarySwatch: Colors.blueGrey),
      darkTheme: ThemeData(
          brightness: Brightness.dark, primarySwatch: Colors.blueGrey),
      themeMode: EasyDynamicTheme.of(context).themeMode,
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
