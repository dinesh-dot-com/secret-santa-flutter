import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/employee.dart';

final employeeListProvider = StateProvider<List<Employee>>((ref) => []);
final previousAssignmentsProvider = StateProvider<Map<String, String>>((ref) => {});
final secretSantaPairsProvider = StateProvider<Map<Employee, Employee>>((ref) => {});
