import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:io' show Platform;

class FilePickerWidget extends StatelessWidget {
  final String title;
  final Function(dynamic fileData) onFileSelected;
  final bool christmasTheme;

  const FilePickerWidget({
    Key? key, 
    required this.title, 
    required this.onFileSelected,
    this.christmasTheme = false,
  }) : super(key: key);

  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    
    if (result != null) {
      if (kIsWeb) {
        Uint8List? fileBytes = result.files.first.bytes;
        if (fileBytes != null) {
          onFileSelected(fileBytes);
        }
      } else {
        // On mobile and desktop, use `path`
        String? filePath = result.files.first.path;
        if (filePath != null) {
          onFileSelected(filePath);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!christmasTheme) {
      return ElevatedButton(
        onPressed: _pickFile,
        child: Text(title),
      );
    }

    // Christmas themed button
    return Container(
      height: 44,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF0F8A5F), Color(0xFF0A5F38)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: Color(0xFF0F8A5F).withOpacity(0.4),
            spreadRadius: 1,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
        border: Border.all(
          color: Colors.white.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: ElevatedButton(
        onPressed: _pickFile,
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white, backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(22),
          ),
          padding: EdgeInsets.symmetric(horizontal: 20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.upload_file, size: 16),
            SizedBox(width: 8),
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}