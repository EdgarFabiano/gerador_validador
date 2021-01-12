import 'package:flutter/material.dart';
import 'package:gerador_validador/defaults/defaults_export.dart';
import 'package:gerador_validador/pages/home_loading_page.dart';
import 'package:gerador_validador/service/admob_service.dart';

import 'app_drawer.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    AdMobService.startBanner();
    AdMobService.displayBanner();
  }

  @override
  Widget build(BuildContext context) {
    var mediaQueryData = MediaQuery.of(context);
    var isPortrait = mediaQueryData.orientation == Orientation.portrait;

    var screenWidth = mediaQueryData.size.width;
    var portraitSize = screenWidth / 2;
    var landscapeSize = screenWidth / 4;
    var tileSize = isPortrait
        ? (portraitSize > Constants.tileMaxSize
            ? Constants.tileMaxSize
            : portraitSize)
        : (landscapeSize > Constants.tileMaxSize
            ? Constants.tileMaxSize
            : landscapeSize);

    var spacing = mediaQueryData.size.height / 100;

    return Scaffold(
      appBar: AppBar(
        title: Text(Strings.appName),
      ),
      drawer: Drawer(
        child: AppDrawer(),
      ),
      body: HomeLoadingPage(spacing: spacing, tileSize: tileSize),
    );
  }
}
