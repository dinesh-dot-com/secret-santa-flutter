import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/employee_provider.dart';

class EmployeeListScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final employees = ref.watch(employeeListProvider);

    return Scaffold(
      appBar: AppBar(title: Text("Employee List 📋")),
      body: employees.isEmpty
          ? Center(child: Text("No employees loaded. Please upload a CSV file."))
          : ListView.builder(
              itemCount: employees.length,
              itemBuilder: (context, index) {
                final employee = employees[index];
                return ListTile(
                  title: Text(employee.name),
                  subtitle: Text(employee.email),
                );
              },
            ),
    );
  }
}
