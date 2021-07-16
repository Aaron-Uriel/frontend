import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:server_client/server_client.dart';

const double title_size = 30;
const double button_text_size = 35;
const String base_url = 'http://192.168.1.7:8080';

void main() {
  final adder = Adder();
  final result = adder.add(1, 2);
  print('${result}');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      darkTheme: ThemeData(
        brightness: Brightness.dark,
      ),
      themeMode: ThemeMode.dark,
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Padding(
                padding: EdgeInsets.only(top: 20, bottom: 20),
                child: Text(
                  '¿Para cuál mesa será la órden?',
                  style: TextStyle(fontSize: title_size),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.50,
              width: MediaQuery.of(context).size.width * 0.80,
              child: GridView.count(
                crossAxisCount: 3,
                children: List.generate(18, (index) {
                  return TextButton(
                    child: Text(
                      '${index + 1}',
                      style: TextStyle(fontSize: button_text_size),
                    ),
                    onPressed: null,
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Table {
  final int id;
  final bool is_occupied;

  Table({
    required this.id,
    required this.is_occupied,
  });
}
