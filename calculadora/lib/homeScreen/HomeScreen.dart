import 'dart:math';

import 'package:calculadora/main.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<double> integer = [0, 0], decimal = [0, 0];
  double result = 0;
  int decimalQuantity = 0, actualNumber = 0;

  String calculo = '0', topEquation = '';
  bool decimalPoint = false;
  Operation actualOperation = Operation.nothing;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Calculadora"),
          backgroundColor: Colors.orangeAccent,
          centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Center(
            child: Container(
              // padding: EdgeInsets.fromLTRB(50, 20, 20, 50),
              child: Column(
                children: [
                  SizedBox(
                    height: 15,
                    width: 350,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 1, 20, 1),
                      child: Text(
                        topEquation,
                        textAlign: TextAlign.right,
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                    width: 350,
                    child: Center(
                      child: Text(
                        calculo,
                      ),
                    ),
                  ),
                ],
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: Colors.orangeAccent),
              ),
            ),
          ),
          SizedBox(
            height: 50,
          ),
          Container(
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        TextButton(
                          onPressed: () {
                            num(1);
                          },
                          child: Text(
                            "1",
                            style: TextStyle(color: Colors.white),
                          ),
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.all(8),
                            backgroundColor: Colors.blueGrey,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextButton(
                          onPressed: () {
                            num(4);
                          },
                          child: Text(
                            "4",
                            style: TextStyle(color: Colors.white),
                          ),
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.all(8),
                            backgroundColor: Colors.blueGrey,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextButton(
                          onPressed: () {
                            num(7);
                          },
                          child: Text(
                            "7",
                            style: TextStyle(color: Colors.white),
                          ),
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.all(8),
                            backgroundColor: Colors.blueGrey,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextButton(
                          onPressed: () {
                            decimalPoint = true;
                          },
                          child: Text(
                            ",",
                            style: TextStyle(color: Colors.white),
                          ),
                          style: TextButton.styleFrom(
                              backgroundColor: Colors.orangeAccent),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        TextButton(
                          onPressed: () {
                            num(2);
                          },
                          child: Text(
                            "2",
                            style: TextStyle(color: Colors.white),
                          ),
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.all(8),
                            backgroundColor: Colors.blueGrey,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextButton(
                          onPressed: () {
                            num(5);
                          },
                          child: Text(
                            "5",
                            style: TextStyle(color: Colors.white),
                          ),
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.all(8),
                            backgroundColor: Colors.blueGrey,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextButton(
                          onPressed: () {
                            num(8);
                          },
                          child: Text(
                            "8",
                            style: TextStyle(color: Colors.white),
                          ),
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.all(8),
                            backgroundColor: Colors.blueGrey,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextButton(
                          onPressed: () {
                            num(0);
                          },
                          child: Text(
                            "0",
                            style: TextStyle(color: Colors.white),
                          ),
                          style: TextButton.styleFrom(
                              backgroundColor: Colors.blueGrey),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        TextButton(
                          onPressed: () {
                            num(3);
                          },
                          child: Text(
                            "3",
                            style: TextStyle(color: Colors.white),
                          ),
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.all(8),
                            backgroundColor: Colors.blueGrey,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextButton(
                          onPressed: () {
                            num(6);
                          },
                          child: Text(
                            "6",
                            style: TextStyle(color: Colors.white),
                          ),
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.all(8),
                            backgroundColor: Colors.blueGrey,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextButton(
                          onPressed: () {
                            num(9);
                          },
                          child: Text(
                            "9",
                            style: TextStyle(color: Colors.white),
                          ),
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.all(8),
                            backgroundColor: Colors.blueGrey,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextButton(
                          onPressed: () {
                            actualOperation = Operation.plusZero;
                          },
                          child: Text(
                            "00",
                            style: TextStyle(color: Colors.white),
                          ),
                          style: TextButton.styleFrom(
                              backgroundColor: Colors.orangeAccent),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        TextButton(
                          onPressed: () {
                            actualOperation = Operation.plus;
                            addTopEquation();
                            actualNumber = 1;
                          },
                          style: TextButton.styleFrom(
                              backgroundColor: Colors.orangeAccent),
                          child: Icon(Icons.add, color: Colors.white),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextButton(
                          onPressed: () {
                            actualOperation = Operation.multi;
                            addTopEquation();
                            actualNumber = 1;
                          },
                          style: TextButton.styleFrom(
                              backgroundColor: Colors.orangeAccent),
                          child: Text(
                            " * ",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextButton(
                          onPressed: () {
                            actualOperation = Operation.divide;
                            addTopEquation();
                            actualNumber = 1;
                          },
                          style: TextButton.styleFrom(
                              backgroundColor: Colors.orangeAccent),
                          child: Text(
                            " / ",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextButton(
                          onPressed: () {
                            actualOperation = Operation.minus;
                            addTopEquation();
                            actualNumber = 1;
                          },
                          style: TextButton.styleFrom(
                              backgroundColor: Colors.orangeAccent),
                          child: Text(
                            " - ",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        TextButton(
                          onPressed: () {
                            actualOperation = Operation.Ac;
                            addTopEquation();
                            actualNumber = 0;
                          },
                          style: TextButton.styleFrom(
                              backgroundColor: Colors.orangeAccent),
                          child: Text(
                            "AC",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextButton(
                          onPressed: () {
                            actualOperation = Operation.percent;
                            addTopEquation();
                          },
                          style: TextButton.styleFrom(
                              backgroundColor: Colors.orangeAccent),
                          child: Text(
                            " % ",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          child: Center(
                            child: TextButton(
                              onPressed: () {
                                actualOperation = Operation.equal;
                                addTopEquation();
                              },
                              child: Text(
                                " = ",
                                style: TextStyle(color: Colors.white),
                              ),
                              style: TextButton.styleFrom(
                                  backgroundColor: Colors.orangeAccent,
                                  fixedSize: Size(1, 76)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ]),
      ),
    );
  }

  void num(double number) {
    if (!decimalPoint) {
      integer[actualNumber] *= 10;
      integer[actualNumber] += number;
      calculo = '${integer[actualNumber]}';
    } else {
      if (number != 0) decimalQuantity++;

      integer[actualNumber] += number / pow(10, decimalQuantity);
      calculo = '${integer[0]}';
    }
    setState(() {});
  }

  addTopEquation() {
    String topText = '';
    calculo = '0';

    switch (actualOperation) {
      case Operation.nothing:
        break;
      case Operation.plus:
        topText = ' + ';
        break;
      case Operation.minus:
        topText = ' - ';
        break;
      case Operation.Ac:
        integer[0] = integer[1] = 0;
        decimal[0] = decimal[1] = 0;
        topText = '';
        calculo = '0';

        break;
      case Operation.percent:
        integer[actualNumber] = integer[actualNumber];
        break;
      case Operation.multi:
        topText = ' * ';
        break;
      case Operation.divide:
        topText = ' / ';
        break;
      case Operation.equal:
        equalAction();
        break;
      case Operation.plusZero:
        break;
    }

    setState(() {
      topEquation = '${integer[0]} $topText';
    });
  }

  equalAction() {
    topEquation = '';

    switch (actualOperation) {
      case Operation.nothing:
        break;
      case Operation.plus:
        calculo = '${integer[0] + integer[1]} ';
        break;
      case Operation.minus:
        calculo = '${integer[0] - integer[1]} ';
        break;
      case Operation.Ac:
        break;
      case Operation.percent:
        break;
      case Operation.multi:
        calculo = '${integer[0] * integer[1]} ';
        break;
      case Operation.divide:
        calculo = '${integer[0] / integer[1]} ';
        break;
      case Operation.equal:
        break;
      case Operation.plusZero:
        break;
    }

    setState(() {});
  }
}
