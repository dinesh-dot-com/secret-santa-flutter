import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:csv/csv.dart';
import 'package:project/models/employee.dart';
import 'dart:html' as html; 

class CsvService {

  static Future<Map<String, String>> readPreviousAssignmentsCsv(dynamic fileData) async {
    try {
      String csvContent;

      if (fileData == null) {
        throw Exception("No file selected!");
      }

      if (fileData is Uint8List) {
        csvContent = utf8.decode(fileData); 
      } else if (fileData is String) {
        csvContent = await File(fileData).readAsString(); 
      } else {
        throw Exception("Invalid file data type");
      }

      List<List<dynamic>> csvRows = const CsvToListConverter().convert(csvContent);
      if (csvRows.isEmpty || csvRows.length == 1) {
        throw Exception("CSV file is empty or missing data!");
      }

      Map<String, String> previousAssignments = {};

      for (var row in csvRows.skip(1)) {
        if (row.length < 2) continue; 
        previousAssignments[row[0].toString()] = row[1].toString();
      }

      return previousAssignments;
    } catch (e) {
      debugPrint("❌ Error reading Previous Assignments CSV: $e");
      return {};
    }
  }

static Future<List<Employee>> readEmployeeCsv(dynamic fileData) async {
  try {
    String csvContent;

    if (fileData == null) {
      throw Exception("No file selected!");
    }

    if (fileData is Uint8List) {
      csvContent = utf8.decode(fileData); 
    } else if (fileData is String) {
      csvContent = await File(fileData).readAsString(); 
    } else {
      throw Exception("Invalid file data type");
    }

    List<List<dynamic>> csvRows = const CsvToListConverter().convert(csvContent);
    if (csvRows.isEmpty || csvRows.length == 1) {
      throw Exception("CSV file is empty or missing data!");
    }

    List<Employee> employees = [];

    for (var row in csvRows.skip(1)) {
      if (row.length < 2) continue;
      employees.add(Employee(name: row[0].toString(), email: row[1].toString()));
    }

    return employees;
  } catch (e) {
    debugPrint("❌ Error reading Employee List CSV: $e");
    return []; 
  }
}


  static Future<void> writeAssignmentsCsv(String fileName, Map<Employee, Employee> assignments) async {
    List<List<String>> csvData = [
      ["Giver Name", "Giver Email", "Receiver Name", "Receiver Email"]
    ];

    for (var entry in assignments.entries) {
      csvData.add([
        entry.key.name,
        entry.key.email,
        entry.value.name,
        entry.value.email,
      ]);
    }

    String csvContent = const ListToCsvConverter().convert(csvData);

    if (kIsWeb) {
     
      final bytes = utf8.encode(csvContent);
      final blob = html.Blob([bytes], 'text/csv');
      final url = html.Url.createObjectUrlFromBlob(blob);
      final anchor = html.AnchorElement(href: url)
        ..setAttribute("download", fileName)
        ..click();
      html.Url.revokeObjectUrl(url);
    } else {
      final file = File(fileName);
      await file.writeAsString(csvContent);
    }
  }
}
