import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _infoText = 'Informe seus dados';

  void _resetField() {
    weightController.text = '';
    heightController.text = '';
    setState(() {
      _infoText = 'Informe seus dados';
      _formKey = GlobalKey<FormState>();
    });
  }

  void _calculate() {
    setState(() {
      double weight = double.parse(weightController.text);
      double height = double.parse(heightController.text) / 100;

      double bmi = weight / pow(height, 2);

      if (bmi < 18.5) {
        _infoText = 'Abaixo do peso (${bmi.toStringAsPrecision(3)})';
      } else if (bmi >= 18.5 && bmi <= 24.9) {
        _infoText = 'Peso Nomal (${bmi.toStringAsPrecision(3)})';
      } else if (bmi >= 25.0 && bmi <= 29.9) {
        _infoText = 'Sobrepeso (${bmi.toStringAsPrecision(3)})';
      } else if (bmi >= 30.0 && bmi <= 34.9) {
        _infoText = 'Obesidade Grau I (${bmi.toStringAsPrecision(3)})';
      } else if (bmi >= 35.0 && bmi <= 39.9) {
        _infoText =
            'Obesidade Severa (Grau II) (${bmi.toStringAsPrecision(3)})';
      } else if (bmi >= 40.0) {
        _infoText =
            'Obesidade Mórbida (Grau III) (${bmi.toStringAsPrecision(3)})';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('BMI Calculator'),
          centerTitle: true,
          backgroundColor: Colors.orange,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: _resetField,
            )
          ],
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Icon(
                    Icons.person,
                    size: 120,
                    color: Colors.orange,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Insira seu peso';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: 'Peso (KG)',
                        labelStyle: TextStyle(color: Colors.orange)),
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.orange, fontSize: 25),
                    controller: weightController,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Insira sua altura';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: 'Altura (CM)',
                        labelStyle: TextStyle(color: Colors.orange)),
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.orange, fontSize: 25),
                    controller: heightController,
                  ),
                  Padding(
                    child: Container(
                      height: 50.0,
                      child: RaisedButton(
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            _calculate();
                          }
                        },
                        child: Text(
                          'Calcular',
                          style: TextStyle(
                              fontSize: 25.0,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                        color: Colors.orange,
                      ),
                    ),
                    padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                  ),
                  Text(_infoText,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.orange, fontSize: 25.0))
                ],
              ),
            )));
  }
}
