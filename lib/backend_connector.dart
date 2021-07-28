import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:taquexpress/database_models_as_classes.dart';

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

  Future<Client> sendNewClient({int? clientTableId}) async {
    final clientToBeSent = NewClient(clientTableId);
    final response = await http.post(
      Uri.parse(this.baseUrl + 'new_client'),
      headers: <String, String> {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(clientToBeSent.toJson())
    );
    
    if (response.statusCode == 201) {
      return Client.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create new client');
    }
  }
}