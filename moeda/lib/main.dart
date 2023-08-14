import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

String request = "https://api.hgbrasil.com/finance?key=35767af8";

void main() async {
  //print(await getData());

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(),
  ));
}

Future<Map> getData() async {
  http.Response response = await http.get(Uri.parse(request));
  return (json.decode(response.body));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final controlerReal = TextEditingController();
  final controlerDolar = TextEditingController();
  final controlerEuro = TextEditingController();

  double dolar = 0, euro = 0;

  void _realChanged() {
    if (controlerReal.text.isEmpty) {
      clearAll();
    }
    double real = double.parse(controlerReal.text);
    controlerDolar.text = (real / dolar).toStringAsFixed(2);
    controlerEuro.text = (real / euro).toStringAsFixed(2);
  }

  void _dolarChanged() {
    if (controlerDolar.text.isEmpty) {
      clearAll();
    }
    double dolarAux = double.parse(controlerDolar.text);
    controlerReal.text = (dolarAux * this.dolar).toStringAsFixed(2);
    controlerEuro.text = (dolarAux * this.dolar / this.euro).toStringAsFixed(2);
  }

  void _euroChanged() {
    if (controlerEuro.text.isEmpty) {
      clearAll();
    }
    double euroAux = double.parse(controlerEuro.text);
    controlerDolar.text = (euroAux * this.euro / dolar).toStringAsFixed(2);
    controlerReal.text = (euroAux * this.euro).toStringAsFixed(2);
  }

  void clearAll() {
    controlerDolar.text = '';
    controlerReal.text = '';
    controlerEuro.text = '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {clearAll();},
            icon: Icon(Icons.refresh),
          ),
        ],
        centerTitle: true,
        backgroundColor: Colors.deepPurpleAccent,
        title: Text("Conversor"),
      ),
      body: FutureBuilder<Map>(
        future: getData(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return Center(
                child: Text(
                  "Carregando Dados ... ",
                  style: TextStyle(color: Colors.deepPurpleAccent),
                ),
              );

            default:
              if (snapshot.hasError) {
                return Center(
                  child: Text(
                    "Carregando Dados ... ",
                    style: TextStyle(color: Colors.deepPurpleAccent),
                  ),
                );
              } else {
                //print(snapshot.data);
                dolar = snapshot.data!["results"]["currencies"]["USD"]["buy"];
                euro = snapshot.data!["results"]["currencies"]["EUR"]["buy"];

                return Container(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        buildValueFields(
                            "Real", "R\$", controlerReal, _realChanged),
                        buildValueFields(
                            "Dolár", "US\$", controlerDolar, _dolarChanged),
                        buildValueFields(
                            "Euro", "€\$", controlerEuro, _euroChanged),
                      ],
                    ),
                  ),
                );
              }
          }
        },
      ),
    );
  }
}

Widget buildValueFields(
    String coin, String prefix, TextEditingController controler, Function f) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: TextField(
      keyboardType: TextInputType.number,
      controller: controler,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.deepPurpleAccent, width: 2),
          borderRadius: BorderRadius.circular(20),
        ),
        labelText: coin,
        labelStyle: TextStyle(color: Colors.deepPurpleAccent),
        prefixText: prefix,
        prefixStyle: TextStyle(color: Colors.deepPurpleAccent),
      ),
      onChanged: (value) => f(),
    ),
  );
}
