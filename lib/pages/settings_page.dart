import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:gerador_validador/defaults/defaults_export.dart';
import 'package:gerador_validador/service/admob_service.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {

  void _switchTheme(BuildContext context) {
    var b = Theme.of(context).brightness;
    DynamicTheme.of(context).setBrightness(
        b == Brightness.dark ? Brightness.light : Brightness.dark);
  }

  @override
  Widget build(BuildContext context) {
    var reorderableListView = Container();

    return Scaffold(
      appBar: AppBar(
        title: Text(Strings.settings),
      ),
      body: Padding(
        padding: EdgeInsets.only(bottom: AdMobService.bannerPadding(context)),
        child: ListView.builder(
          physics: ClampingScrollPhysics(),
          itemCount: 1,
          itemBuilder: (context, index) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ListTile(
                  leading: Icon(Theme
                      .of(context)
                      .brightness == Brightness.dark
                      ? Icons.brightness_3
                      : Icons.brightness_high),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("Modo noturno"),
                      Switch(
                        value: Theme
                            .of(context)
                            .brightness == Brightness.dark,
                        onChanged: (value) {
                          _switchTheme(context);
                        },
                      ),
                    ],
                  ),
                  onTap: () {
                    _switchTheme(context);
                  },
                ),
                Divider(),
                // ListTile(
                //   title: Text("Tela inicial"),
                // ),
                // Divider(),
                SizedBox(
                  height: 500,
                  child: reorderableListView,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
