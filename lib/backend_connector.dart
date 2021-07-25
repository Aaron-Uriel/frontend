import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:taquexpress/database_tables_as_classes.dart';

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