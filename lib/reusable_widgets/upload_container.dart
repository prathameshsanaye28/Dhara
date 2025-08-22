import 'dart:io'; // Required for File type

import 'package:flutter/material.dart';
import 'package:path/path.dart' as path; // To get the filename from file path

class UploadContainer extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final File? file;
  final String? iconPath;

  const UploadContainer({
    super.key,
    required this.label,
    required this.onTap,
    this.file,
    this.iconPath,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          color: const Color.fromRGBO(233, 234, 230, 0.17),
          borderRadius: BorderRadius.circular(12),
        ),
        child: file == null
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    label,
                    style: const TextStyle(
                      color: Colors.white54,
                      fontSize: 16,
                    ),
                  ),
                  iconPath != null
                      ? Image.asset(
                          iconPath!, // Custom icon using path
                          color: Colors.white54,
                          width: 24,
                          height: 24,
                        )
                      : const Icon(
                          Icons.folder, // Fallback icon
                          color: Colors.white54,
                        ),
                ],
              )
            : Row(
                children: [
                  iconPath != null
                      ? Image.asset(
                          iconPath!, // Custom icon using path
                          color: Colors.white54,
                          width: 24,
                          height: 24,
                        )
                      : const Icon(
                          Icons.folder, // Fallback icon
                          color: Colors.white54,
                        ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      path.basename(file!.path),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
