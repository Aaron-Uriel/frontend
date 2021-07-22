import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

const double title_size = 30;
const double button_text_size = 35;
const String base_url = 'http://192.168.1.7:8080/';

final BackendConnector myServer = BackendConnector(base_url);

const int rows_limit = 3;
const int columns_limit = 3;

const int table_capacity = 9;

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
  late Future<List<Bench>> tablesList;

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
              child: FutureBuilder<List<Bench>>(
                future: tablesList,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final List<Bench> tablesList = snapshot.data!;
                    final int neededTables = getNeededTables(tablesList.length);

                    int linearCount = 1;
                    return Table(
                        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                        children: List.generate(rows_limit, (row_index) {
                          return TableRow(
                            children: List.generate(columns_limit, (column_index) {
                              return ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: TextButton(
                                  child: Text('${linearCount++}'),
                                  style: TextButton.styleFrom(
                                    padding: EdgeInsets.all(16),
                                    textStyle: TextStyle(fontSize: button_text_size)
                                  ),
                                  onPressed: () {},
                                ),
                              );
                            })
                          );
                        }),
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
    tablesList = myServer.askForBenchesInfo();
  }
}


class BackendConnector {
  final String baseUrl;

  //Constructor
  BackendConnector(this.baseUrl);

  Future<List<Bench>> askForBenchesInfo() async {
    final response =
      await http.get(Uri.parse(this.baseUrl + 'tables_list'));
    if (response.statusCode == 200) {
      final Iterable rawList = json.decode(response.body);
      return List<Bench>.from(rawList.map((table) => Bench.fromJson(table)));
    } else {
      throw Exception('Failed to load tables list');
    }
  }
}

class Bench {
  final int id;
  final bool isOccupied;

  Bench({
    required this.id,
    required this.isOccupied
  });

  factory Bench.fromJson(Map<String, dynamic> json) {
    return Bench(
      id: json['id'],
      isOccupied: json['is_occupied']
    );
  }
}

int getNeededTables(int length) {
  final difference = length / table_capacity;
  final roundedDifference = (length / table_capacity).round();

  final int neededTables = (difference > roundedDifference)? roundedDifference + 1: roundedDifference;
  return neededTables;
}