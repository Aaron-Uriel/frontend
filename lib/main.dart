import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

const double title_size = 30;
const double button_text_size = 35;
const String base_url = 'http://192.168.1.7:8080/';

final BackendConnector myServer = BackendConnector(base_url);

void main() {
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
  late Future<List<Table>> tablesList;

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
            Center(
              child: FutureBuilder<List<Table>>(
                future: tablesList,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final List<Table> tables_list = snapshot.data!;
                    return SizedBox(
                      height: MediaQuery.of(context).size.height * 0.50,
                      width: MediaQuery.of(context).size.width * 0.80,
                      child: GridView.count( 
                        crossAxisCount: 3,
                        children: List.generate(tables_list.length, (index) {
                          return TextButton(
                            onPressed: null,
                            child: Text('${index + 1}', style: TextStyle(fontSize: button_text_size)),
                          );
                        }),
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  }
                  return CircularProgressIndicator();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    tablesList = myServer.askForTablesInfo();
  }
}


class BackendConnector {
  final String baseUrl;

  //Constructor
  BackendConnector(this.baseUrl);

  Future<List<Table>> askForTablesInfo() async {
    final response =
      await http.get(Uri.parse(this.baseUrl + 'tables_list'));
    if (response.statusCode == 200) {
      final Iterable rawList = json.decode(response.body);
      return List<Table>.from(rawList.map((table) => Table.fromJson(table)));
    } else {
      throw Exception('Failed to load tables list');
    }
  }
}

class Table {
  final int id;
  final bool isOccupied;

  Table({
    required this.id,
    required this.isOccupied
  });

  void printme() {
    print("Table =  id: ${this.id}, isOccupied: ${this.isOccupied}");
  }

  factory Table.fromJson(Map<String, dynamic> json) {
    return Table(
      id: json['id'],
      isOccupied: json['is_occupied']
    );
  }
}