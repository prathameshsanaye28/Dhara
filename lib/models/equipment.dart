class Equipment {
  String name;
  String status;
  String priority; // Use String to simplify Firestore storage

  Equipment({
    required this.name,
    required this.status,
    required this.priority,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'status': status,
      'priority': priority,
    };
  }
}

enum Priority { low, medium, high }