class Table {
  final int id;
  final bool isOccupied;

  Table({
    required this.id,
    required this.isOccupied
  });

  factory Table.fromJson(Map<String, dynamic> json) {
    return Table(
      id: json['id'],
      isOccupied: json['is_occupied']
    );
  }
}