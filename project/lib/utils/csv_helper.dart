import 'dart:io';
import 'package:csv/csv.dart';
import '../models/employee.dart';

class CsvHelper {

  static Future<List<Employee>> parseEmployeeCsv(String filePath) async {
    final input = await File(filePath).readAsString();
    final fields = const CsvToListConverter().convert(input);

    return fields.skip(1).map((row) => Employee.fromCsv(row)).toList();
  }

  static Future<Map<String, String>> parsePreviousAssignments(String filePath) async {
    final input = await File(filePath).readAsString();
    final fields = const CsvToListConverter().convert(input);

    Map<String, String> previousAssignments = {};
    for (var row in fields.skip(1)) {
      previousAssignments[row[1]] = row[3];
    }
    return previousAssignments;
  }

  
  static Future<void> writeCsv(String filePath, List<Employee> employees) async {
    List<List<String>> csvData = [
      ["Employee_Name", "Employee_EmailID", "Secret_Child_Name", "Secret_Child_EmailID"]
    ];

    for (var emp in employees) {
      csvData.add([emp.name, emp.email, emp.secretChild?.name ?? "", emp.secretChild?.email ?? ""]);
    }

    final csv = const ListToCsvConverter().convert(csvData);
    await File(filePath).writeAsString(csv);
  }
}
