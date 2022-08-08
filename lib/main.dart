import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:gerador_validador/widgets/app.dart';

import 'service/admob_service.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  FirebaseAdMob.instance.initialize(appId: AdMobService.getAppId());
  runApp(App());
}
