import 'package:device_info/device_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:gerador_validador/defaults/defaults_export.dart';
import 'package:gerador_validador/pages/settings_page.dart';
import 'package:url_launcher/url_launcher.dart';

final InAppReview _inAppReview = InAppReview.instance;

Future<void> _requestReview() async {
  DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  final androidInfo = await deviceInfoPlugin.androidInfo;

  if (androidInfo.version.sdkInt < 21) {
    _inAppReview.openStoreListing();
  } else {
    _inAppReview.isAvailable().then((isAvailable) {
      if (isAvailable) {
        _inAppReview.requestReview();
        return true;
      }
      _inAppReview.openStoreListing();
      return false;
    }).catchError((err) => Fluttertoast.showToast(msg: "Operação indisponível no momento"));
  }
}

class AppDrawer extends StatefulWidget {
  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        DrawerHeader(
          child: Center(
            child: Column(
              children: <Widget>[
                Image.asset(
                  Constants.logoTransparentAssetPath,
                  width: 120,
                ),
                Text(
                  "Gerador-Validador",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ),
          decoration: BoxDecoration(color: Theme.of(context).primaryColor),
        ),
        ListTile(
          leading: Icon(Icons.settings),
          title: Text("Configurações"),
          onTap: () {
            Navigator.of(context).pop();
            Navigator.push(context,
                CupertinoPageRoute(builder: (context) => SettingsPage()));
          },
        ),
        ListTile(
          leading: Icon(Icons.star),
          title: Text("Avaliar"),
          onTap: _requestReview,
        ),
        ListTile(
          leading: Icon(Icons.store),
          title: Text("Mais apps como este"),
          onTap: () {
            try {
              launch("https://play.google.com/store/apps/dev?id=9122266344608230682&hl=pt_BR");
            } on PlatformException catch(e) {
              Fluttertoast.showToast(msg: "Operação indisponível no momento");
            }
          },
        ),
      ],
    );
  }
}
