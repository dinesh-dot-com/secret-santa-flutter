import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project/models/employee.dart';
import '../providers/employee_provider.dart';
import '../services/csv_service.dart';
import '../services/secret_santa_service.dart';
import '../screens/assignment_screen.dart';
import '../widgets/file_picker_widget.dart';

final employeeFileUploadedProvider = StateProvider<bool>((ref) => false);
final previousFileUploadedProvider = StateProvider<bool>((ref) => false);

class ChristmasTheme {
  static const Color primary = Color(0xFFD42426); 
  static const Color secondary = Color(0xFF0F8A5F); 
  static const Color background = Color(0xFFF7F0EB); 
  static const Color surface = Colors.white;
  static const Color gold = Color(0xFFFFD700);
  static const Color darkGreen = Color(0xFF0A5F38);
}

class HomeScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isEmployeeFileUploaded = ref.watch(employeeFileUploadedProvider);
    final isPreviousFileUploaded = ref.watch(previousFileUploadedProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            Text("Secret Santa", 
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
            SizedBox(width: 8),
            Text("🎅", style: TextStyle(fontSize: 28)),
          ],
        ),
        backgroundColor: ChristmasTheme.primary,
        foregroundColor: Colors.white,
        elevation: 4,
      ),
      backgroundColor: ChristmasTheme.background,
      body: Container(
decoration: BoxDecoration(
  image: const DecorationImage(
    image: AssetImage('assets/snowflake_bg.png'),
    fit: BoxFit.cover, 
  ),
  color: Colors.white.withOpacity(0.6), 
),


        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                _buildSnowmanHeader(),
                const SizedBox(height: 30),
                _buildFilePickerCard(
                  context,
                  "Upload Employee List",
                  "We need to know who's participating in the gift exchange!",
                  Icons.people,
                  isEmployeeFileUploaded,
                  (filePath) async {
                    try {
                      final employees = await CsvService.readEmployeeCsv(filePath);
                      ref.read(employeeListProvider.notifier).state = employees;
                      ref.read(employeeFileUploadedProvider.notifier).state = true;
                    } catch (e) {
                      debugPrint("❌ Error reading Employee List CSV: $e");
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Error reading Employee List CSV!")),
                      );
                    }
                  },
                ),
                const SizedBox(height: 16),
                _buildFilePickerCard(
                  context,
                  "Upload Previous Assignments (Optional)",
                  "So we don't repeat last year's matches!",
                  Icons.history,
                  isPreviousFileUploaded,
                  (filePath) async {
                    try {
                      final previousAssignments = await CsvService.readPreviousAssignmentsCsv(filePath);
                      ref.read(previousAssignmentsProvider.notifier).state = previousAssignments;
                      ref.read(previousFileUploadedProvider.notifier).state = true;
                    } catch (e) {
                      debugPrint("❌ Error reading Previous Assignments CSV: $e");
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Error reading Previous Assignments CSV!")),
                      );
                    }
                  },
                ),
                const SizedBox(height: 30),
                _buildGenerateButton(context, ref),
                // Add some bottom padding to ensure there's space after the button
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSnowmanHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.8),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Column(
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("⛄ ", style: TextStyle(fontSize: 32)),
              Flexible(
                child: Text(
                  "Secret Santa Generator",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: ChristmasTheme.darkGreen,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Text(" ⛄", style: TextStyle(fontSize: 32)),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            "Spread holiday cheer with a fun gift exchange!",
            style: TextStyle(
              color: Colors.grey[700],
              fontSize: 16,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildFilePickerCard(
      BuildContext context,
      String title,
      String subtitle,
      IconData icon,
      bool isUploaded,
      Function(dynamic) onFileSelected) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: isUploaded ? ChristmasTheme.secondary : Colors.grey.shade300,
          width: isUploaded ? 2 : 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: ChristmasTheme.darkGreen),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: ChristmasTheme.darkGreen,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                if (isUploaded)
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: ChristmasTheme.secondary,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 16,
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              subtitle,
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 16),
            Center(
              child: FilePickerWidget(
                title: isUploaded ? "Replace File" : "Select File",
                onFileSelected: onFileSelected,
                christmasTheme: true,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGenerateButton(BuildContext context, WidgetRef ref) {
    return Container(
      width: double.infinity,
      height: 60,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [ChristmasTheme.primary, Color(0xFFB91B1B)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: ChristmasTheme.primary.withOpacity(0.4),
            spreadRadius: 1,
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: () {
          final employees = ref.read(employeeListProvider);
          final previousAssignments = ref.read(previousAssignmentsProvider);

          if (employees.isEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Text("Please upload an employee list first!"),
                backgroundColor: Colors.red[400],
              ),
            );
            return;
          }

          try {
            final assignments =
                SecretSantaService.assignSecretSanta(employees, previousAssignments);
            ref.read(secretSantaPairsProvider.notifier).state = assignments as Map<Employee, Employee>;

            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AssignmentScreen()),
            );
          } catch (e) {
            debugPrint("❌ Error in Secret Santa assignment: $e");
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Error: ${e.toString()}")),
            );
          }
        },
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white, 
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Generate Secret Santa",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(width: 8),
            Text("🎁", style: TextStyle(fontSize: 22)),
          ],
        ),
      ),
    );
  }
}