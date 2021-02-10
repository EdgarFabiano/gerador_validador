import 'package:flutter/material.dart';
import 'package:gerador_validador/service/validador_service.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class ValidadorCPFPage extends StatefulWidget {
  @override
  _ValidadorCPFPageState createState() => _ValidadorCPFPageState();
}

class _ValidadorCPFPageState extends State<ValidadorCPFPage>
    with AutomaticKeepAliveClientMixin {
  TextEditingController _controller;
  final _formKey = GlobalKey<FormState>();
  String _text;

  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  void _validateCPF() {
    setState(() {
      _formKey.currentState.validate();
      if (_controller.text != null && _controller.text.isNotEmpty) {
        if (_formKey.currentState.validate()) {
          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text(
              'CPF válido',
              style: TextStyle(color: Colors.greenAccent),
            ),
            action: SnackBarAction(
              label: "Fechar",
              onPressed: () => Scaffold.of(context).hideCurrentSnackBar(),
            ),
            duration: Duration(seconds: 1),
          ));
        } else {
          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text('CPF inválido', style: TextStyle(color: Colors.red)),
            action: SnackBarAction(
              label: "Fechar",
              onPressed: () => Scaffold.of(context).hideCurrentSnackBar(),
            ),
            duration: Duration(seconds: 1),
          ));
        }
      } else{
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text('Preencha o CPF', style: TextStyle(color: Colors.red)),
          action: SnackBarAction(
            label: "Fechar",
            onPressed: () => Scaffold.of(context).hideCurrentSnackBar(),
          ),
          duration: Duration(seconds: 1),
        ));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    _controller.text = _text;
    var container = Container(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Center(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextFormField(
                  controller: _controller,
                  textInputAction: TextInputAction.done,
                  // onEditingComplete: () => _validateCPF(),
                  onFieldSubmitted: (value) {
                    _validateCPF();
                  },
                  autofocus: true,
                  inputFormatters: [
                    MaskTextInputFormatter(
                      mask: '###.###.###-##',
                    )
                  ],
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    errorStyle: TextStyle(color: Colors.red),
                    hintText: "Digite o CPF",
                    suffixIcon: IconButton(
                      onPressed: () => _controller.clear(),
                      icon: Icon(Icons.clear),
                    ),
                    // border: OutlineInputBorder(
                    //     borderRadius: BorderRadius.circular(20))
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty || value == '') {
                      return null;
                    } else if (!ValidadorService.validateCpf(value)) {
                      return 'CPF inválido';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    _formKey.currentState.validate();
                  },
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 15.0),
                    child: RaisedButton.icon(
                      onPressed: _validateCPF,
                      icon: Icon(Icons.check),
                      label: Text("Validar"),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
    return container;
  }

  @override
  bool get wantKeepAlive => true;
}
