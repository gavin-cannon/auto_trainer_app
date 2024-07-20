class Achievement {
  int id;
  DateTime? date;
  String name;
  String requirementType;
  int requirementAmount;
  bool completed;
  String requirementField;

  Achievement({
    required this.id,
    this.date,
    required this.name,
    required this.requirementType,
    required this.requirementAmount,
    required this.completed,
    required this.requirementField,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'date': date?.toIso8601String(),
      'name': name,
      'requirement_type': requirementType,
      'requirement_amount': requirementAmount,
      'completed': completed ? 1 : 0,
      'requirement_field': requirementField,
    };
  }

  factory Achievement.fromMap(Map<String, dynamic> map) {
    return Achievement(
      id: map['id'],
      date: map['date'] != null ? DateTime.parse(map['date']) : null,
      name: map['name'],
      requirementType: map['requirement_type'],
      requirementAmount: map['requirement_amount'],
      completed: map['completed'] == 1,
      requirementField: map['requirement_field'],
    );
  }

}
