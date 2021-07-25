import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:taquexpress/database_tables_as_classes.dart';

class BackendConnector {
  final String baseUrl;

  //Constructor
  BackendConnector(this.baseUrl);

  Future<List<Table>> askForBenchesInfo() async {
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