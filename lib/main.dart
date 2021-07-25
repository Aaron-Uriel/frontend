import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:taquexpress/theme.dart';

import 'package:taquexpress/backend_connector.dart';
import 'package:taquexpress/database_tables_as_classes.dart';

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
      title: 'Tacos xd',
      theme: MyTheme.theme,
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
    final windowsSize = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                top: windowsSize.height * 0.05,
                bottom: windowsSize.height * 0.05,
              ),
              child: Text(
                '¿Para cuál mesa será la órden?',
                style: Theme.of(context).textTheme.headline1,
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              child: FutureBuilder<List<Bench>>(
                future: tablesList,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final List<Bench> tablesList = snapshot.data!;
                    final int neededTables = getNeededTables(tablesList.length);

                    int linearCount = 0;
                    return Container(
                      width: windowsSize.width * 0.9,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Table(
                            children: List.generate(rows_limit, (row_index) {
                              return TableRow(
                                children: List.generate(columns_limit, (column_index) {
                                  final bool doesThisTableExist = (linearCount < tablesList.length);
                                  final bool isThisTableAviable =
                                    (doesThisTableExist)
                                      ? !tablesList[linearCount].isOccupied
                                      : false;

                                  return Container(
                                    margin: EdgeInsets.all(windowsSize.height * 0.01),
                                    child: TextButton(
                                      child: Text(
                                        '${++linearCount}',
                                        style: Theme.of(context).textTheme.headline2,
                                      ),
                                      onPressed: (doesThisTableExist && isThisTableAviable)
                                        ? () {}
                                        : null,
                                    ),
                                  );
                                }),
                              );
                            }),
                          ),
                          Container(
                            margin: EdgeInsets.all(windowsSize.height * 0.01),
                            child: TextButton(
                              onPressed: () {},
                              child: Text(
                                'Para llevar',
                                style: Theme.of(context).textTheme.bodyText1,
                                textAlign: TextAlign.center,
                              ),
                              style: Theme.of(context).textButtonTheme.style,
                            ),
                          ),
                        ],
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
    tablesList = myServer.askForBenchesInfo();
  }
}

int getNeededTables(int length) {
  final difference = length / table_capacity;
  final roundedDifference = (length / table_capacity).round();

  final int neededTables = (difference > roundedDifference)
      ? roundedDifference + 1
      : roundedDifference;
  return neededTables;
}
