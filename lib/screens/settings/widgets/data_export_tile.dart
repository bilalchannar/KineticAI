import 'package:flutter/material.dart';
import 'package:kinetic_ai/shared/constants/app_colors.dart';

class DataExportTile extends StatelessWidget {
  final String format;
  final VoidCallback onTap;

  const DataExportTile({
    super.key,
    required this.format,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      leading: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(color: Colors.white10, borderRadius: BorderRadius.circular(12)),
        child: const Icon(Icons.file_download_outlined, color: AppColors.accent, size: 20),
      ),
      title: Text('Export as $format', style: const TextStyle(color: Colors.white, fontSize: 14)),
      subtitle: const Text('Download your data for external analysis', style: TextStyle(color: Colors.white38, fontSize: 11)),
      trailing: const Icon(Icons.chevron_right, color: Colors.white24),
    );
  }
}