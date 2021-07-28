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

class NewClient {
  final int? tableId;

  NewClient(this.tableId);

  Map<String, int?> toJson() => {
    'table_id': tableId,
  };
}

class Client {
  final int id;
  final int? tableId;
  final String arrival;

  Client({
    required this.id,
    required this.tableId,
    required this.arrival,
  });

  factory Client.fromJson(Map<String, dynamic> json) {
    return Client(id: json['id'], tableId: json['table_id'], arrival: json['arrival']);
  }
}