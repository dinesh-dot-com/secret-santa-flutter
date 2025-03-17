import 'dart:math';
import '../models/employee.dart';

class SecretSantaService {
  static Map<Employee, Employee> assignSecretSanta(
      List<Employee> employees, Map<String, String> previousAssignments) {
    if (employees.length < 2) {
      throw Exception("At least two employees are required for Secret Santa.");
    }

    List<Employee> givers = List.from(employees);
    List<Employee> receivers = List.from(employees);
    final random = Random();

    Map<Employee, Employee> assignments = {};

    for (var giver in givers) {
      receivers.shuffle(random);

      Employee? receiver;
      for (var candidate in receivers) {
        if (candidate != giver &&
            previousAssignments[giver.email] != candidate.email) {
          receiver = candidate;
          break;
        }
      }

      if (receiver == null) {
        throw Exception("Failed to generate unique Secret Santa assignments.");
      }

      assignments[giver] = receiver;
      receivers.remove(receiver);
    }

    return assignments;
  }
}
