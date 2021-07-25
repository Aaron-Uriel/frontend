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