
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RachaConta',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        scaffoldBackgroundColor: Colors.deepPurple
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  // VARIAVEIS
  final _Pessoas = TextEditingController();
  final _Conta = TextEditingController();
  final _Porcentagem = TextEditingController();
  var _opcao2;
  var _infoText = "Descubra a facada";
  var _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Racha Conta - Pedro H Reis"),
        centerTitle: false,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.refresh),
              onPressed: _ReiniciarDados),
          IconButton(icon : Icon(Icons.swap_horiz),
              onPressed: _ReiniciarDados)
        ],

      ),
      body: _body(),
    );
  }

  // PROCEDIMENTO PARA LIMPAR OS CAMPOS
  void _ReiniciarDados(){
    _Pessoas.text = "";
    _Conta.text = "";
    _Porcentagem.text = "";
    setState(() {
      _infoText = "Descubra a facada";
      _formKey = GlobalKey<FormState>();
    });
  }

  _body() {
    return SingleChildScrollView(
        padding: EdgeInsets.all(15.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              _editText("Quantas Pessoas:", _Pessoas),
              _editText("Valor Da Conta:", _Conta),
              _editText("Porcentagem Do Garçom (%):", _Porcentagem),
              _buttonCalcular(),
              _textInfo(),
            ],
          ),
        ));
  }

  // Widget text
  _editText(String field, TextEditingController controller) {
    return TextFormField(
      controller: controller,
      validator: (s) => _validate(s, field),
      keyboardType: TextInputType.number,
      style: TextStyle(
        fontSize: 18,
        color: Colors.black,
      ),
      decoration: InputDecoration(
        labelText: field,
        labelStyle: TextStyle(
          fontSize: 22,
          color: Colors.white,
        ),
      ),
    );
  }

  // PROCEDIMENTO PARA VALIDAR OS CAMPOS
  String _validate(String text, String field) {
    if (text.isEmpty) {
      return "Digite este campo";
    }
    return null;
  }

  // Widget button
  _buttonCalcular() {
    return Container(
      margin: EdgeInsets.only(top: 10.0, bottom: 20),
      height: 100,
      child: RaisedButton(
        color: Colors.black,
        child:
        Text(
          "Calcular",
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
          ),
        ),
        onPressed: () {
          if(_formKey.currentState.validate()){
            _calculate();
          }
        },
      ),
    );
  }

  // PROCEDIMENTO PARA CALCULAR A CONTA
  void _calculate(){
    setState(() {
      double pessoas = double.parse(_Pessoas.text);
      double conta = double.parse(_Conta.text);
      double porcentagem = double.parse(_Porcentagem.text);

      double valorT = (conta + (conta*(porcentagem/100)))/pessoas;
      double servicoT = conta * (porcentagem/100);
      String valorStr = valorT.toStringAsPrecision(4);
      String servicoStr = servicoT.toStringAsPrecision(4);
      _infoText = "O valor do serviço foi de $servicoStr reais \n\n Cada um pagará $valorStr reais";

    });
  }

  // // Widget text
  _textInfo() {
    return Text(
      _infoText,
      textAlign: TextAlign.center,
      style: TextStyle(color: Colors.black, fontSize: 25.0),
    );
  }
}

//////////////////////////EXTRA/////////////////////////
