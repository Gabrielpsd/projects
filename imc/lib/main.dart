import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController high = TextEditingController();
  TextEditingController weight = TextEditingController();
  String? errorWeight, errorHigh;
  String message = '';

  calculate() {
    double auxWeight = 0, auxHigh = 0;
    bool anyError = false;
    double result = 0;

    if (high.text.isEmpty) {
      errorWeight = 'Peso invalido';
      message = '';

      anyError = true;
    }
    if (weight.text.isEmpty) {
      errorHigh = 'Altura invalida';
      message = '';

      anyError = true;
    }

    if (anyError) return;

    auxHigh = double.tryParse(high.text)!;
    auxWeight = double.parse(weight.text)!;
    auxHigh = auxHigh / 100;

    result = auxWeight / (auxHigh * auxHigh);

    classify(result);
    errorHigh = null;
    errorWeight = null;
  }

  String? classify(double imc) {
    if (imc < 18.5)
      message = 'Magreza IMC(${double.parse(imc.toStringAsFixed(3))})';
    else if (imc > 18.5 && imc < 24.9)
      message = 'Normal IMC(${double.parse(imc.toStringAsFixed(3))})';
    else if (imc > 25 && imc < 29.9)
      message = 'Sobrepeso IMC(${double.parse(imc.toStringAsFixed(3))})';
    else if (imc > 30 && imc < 34.9)
      message = 'Obesidade Grau I IMC(${double.parse(imc.toStringAsFixed(3))})';
    else if (imc > 35 && imc < 39.9)
      message =
          'Obesidade Grau II IMC(${double.parse(imc.toStringAsFixed(3))})';
    else if (imc > 40)
      message =
          'Obesidade grau III IMC(${double.parse(imc.toStringAsFixed(3))})';
  }

  reset() {
    errorHigh = null;
    errorWeight = null;
    weight.clear();
    high.clear();
    message ='';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("IMC calculator"),
        centerTitle: true,
        backgroundColor: Colors.amberAccent,
        actions: <Widget>[
          IconButton(
            onPressed: () {
              setState(() {
                reset();
              });
            },
            icon: Icon(Icons.refresh),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(10, 0.0, 10, 0.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Icon(
              Icons.person,
              size: 120,
              color: Colors.amberAccent,
            ),
            TextField(
              controller: weight,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                errorText: errorWeight,
                labelText: "Peso (kg)",
                labelStyle: TextStyle(color: Colors.amberAccent, fontSize: 20),
              ),
              textAlign: TextAlign.center,
            ),
            TextField(
              controller: high,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                errorText: errorHigh,
                labelText: "Altura (cm)",
                labelStyle: TextStyle(color: Colors.amberAccent, fontSize: 20),
              ),
              textAlign: TextAlign.center,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 20, 10, 10.0),
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    calculate();
                  });
                },
                child: Text(
                  "Calcular",
                  style: TextStyle(fontSize: 20),
                ),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amberAccent),
              ),
            ),
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.amberAccent),
            ),
          ],
        ),
      ),
    );
  }
}

import 'dart:io' as io;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = new DatabaseHelper.internal();

  factory DatabaseHelper() => _instance;
  static Database _db;

  DatabaseHelper.internal();

  initDb() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "database_name.db");
    _db = await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Database get db {
    return _db;
  }

  void _onCreate(Database db, int version) async {
    // When creating the db, create the table
await db.execute(
        'CREATE TABLE todos (id INTEGER PRIMARY KEY AUTOINCREMENT,' 
            ' item_name TEXT,' ' date_created TEXT');
  }
}