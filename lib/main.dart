import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:gerador_validador/defaults/defaults_export.dart';
import 'package:gerador_validador/pages/home_page.dart';

import 'service/admob_service.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  FirebaseAdMob.instance.initialize(appId: AdMobService.getAppId());
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return new DynamicTheme(
        defaultBrightness: Brightness.light,
        data: (brightness) => new ThemeData(
              primarySwatch: Colors.blueGrey,
              brightness: brightness,
              pageTransitionsTheme: PageTransitionsTheme(builders: {
                TargetPlatform.android: CupertinoPageTransitionsBuilder(),
                TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
              }),
            ),
        themedWidgetBuilder: (context, theme) {
          return MaterialApp(
            title: Strings.appName,
            theme: theme,
            home: HomePage(),
            debugShowCheckedModeBanner: false,
          );
        });
  }
}
