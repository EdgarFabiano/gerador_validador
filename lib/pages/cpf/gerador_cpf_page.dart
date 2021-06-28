import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gerador_validador/service/admob_service.dart';
import 'package:gerador_validador/service/gerador_service.dart';

class GeradorCPFPage extends StatefulWidget {
  @override
  _GeradorCPFPageState createState() => _GeradorCPFPageState();
}

class _GeradorCPFPageState extends State<GeradorCPFPage>
    with AutomaticKeepAliveClientMixin {
  TextEditingController _controller;
  bool _useMask = true;
  int _chance = 0;

  void initState() {
    super.initState();
    AdMobService.buildInterstitial();
    _controller = TextEditingController();
    _controller.text = GeradorService.generateCpf();
    _checkMask();
  }

  void _checkMask() {
    if (_useMask) {
      _controller.text = _controller.text.replaceAllMapped(
          new RegExp(r'(.{3})(.{3})(.{3})(.{2})', caseSensitive: false),
          (Match m) => "${m[1]}.${m[2]}.${m[3]}-${m[4]}");
    } else {
      _controller.text = _controller.text.replaceAll(new RegExp(r'[^\d]+'), '');
    }
  }

  void _generateNew() {
    setState(() {
      _chance++;
      if (_chance >= 3) {
        AdMobService.buildInterstitial()
          ..load()
          ..show();
        _chance = 0;
      }
      _controller.text = GeradorService.generateCpf();
      _checkMask();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Center(
          child: Column(
            children: [
              TextField(
                controller: _controller,
                readOnly: true,
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(
                  hintText: "CPF",
                  suffixIcon: IconButton(
                    onPressed: () {
                      Clipboard.setData(
                          new ClipboardData(text: _controller.text));
                      Scaffold.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            "Copiado '" + _controller.text + "'",
                          ),
                        duration: Duration(seconds: 1),),
                      );
                    },
                    icon: Icon(Icons.content_copy),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Row(
                        children: [
                          Text("Utilizar máscara"),
                          Switch(
                            value: _useMask,
                            onChanged: (value) {
                              setState(() {
                                _useMask = value;
                                _checkMask();
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    RaisedButton.icon(
                      onPressed: _generateNew,
                      icon: Icon(Icons.refresh),
                      label: Text("Gerar novo"),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
