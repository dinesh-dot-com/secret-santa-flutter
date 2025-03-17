class Employee {
  final String name;
  final String email;
  Employee? secretChild;

  Employee({required this.name, required this.email});

  factory Employee.fromCsv(List<dynamic> row) {
    return Employee(
      name: row[0] as String,
      email: row[1] as String,
    );
  }
}
