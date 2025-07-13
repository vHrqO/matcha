import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:matcha/model/backup_info.dart';
import 'package:matcha/ui/widgets/shared/loading_dialog.dart';
import 'package:matcha/view_model/settings/data_viewmodel.dart';
import 'package:skeletonizer/skeletonizer.dart';

class SafetyBackupsAction extends ConsumerWidget {
  const SafetyBackupsAction({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      spacing: 8,
      children: [
        OutlinedButton(
          onPressed: () async {
            ref.invalidate(safetyBackupsListProvider);
          },
          child: Text('Refresh'),
        ),
        OutlinedButton(
          onPressed: () async {
            showLoadingDialog(context, 'Creating backup...');

            await ref
                .read(safetyBackupsListProvider.notifier)
                .addBackup(isManual: true);

            Navigator.of(context).pop(); // Close the loading dialog
          },
          child: Text('Backup Now'),
        ),
        OutlinedButton(
          onPressed: () async {
            showLoadingDialog(context, 'Clearing all backups...');

            await ref.read(safetyBackupsListProvider.notifier).deleteAllBackup();

            Navigator.of(context).pop(); // Close the loading dialog
          },
          child: Text('Clear All'),
        ),
      ],
    );
  }
}

class SafetyBackupsListRx extends ConsumerWidget {
  const SafetyBackupsListRx({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final backupsAsync = ref.watch(safetyBackupsListProvider);

    switch (backupsAsync) {
      case AsyncData(value: final backups):
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: backups
              .map(
                (backup) => SafetyBackupTile(
                  title: backup.saveTime.toLocal().toString(),
                  subtitle: backup.backupType,
                  onRestore: () async {
                    showLoadingDialog(context, 'Restoring backup...');

                    await ref
                        .read(safetyBackupsListProvider.notifier)
                        .restoreBackup(backup);

                    Navigator.of(context).pop(); // Close the loading dialog
                  },
                  onDelete: () async {
                    showLoadingDialog(context, 'Deleting backup...');

                    await ref
                        .read(safetyBackupsListProvider.notifier)
                        .deleteBackup(backup);

                    Navigator.of(context).pop(); // Close the loading dialog
                  },
                ),
              )
              .toList(),
        );

      default:
        return Skeletonizer(
          child: SafetyBackupTile(title: 'Backup name', subtitle: 'date here'),
        );
    }
  }
}

class SafetyBackupTile extends StatelessWidget {
  const SafetyBackupTile({
    super.key,
    required this.title,
    required this.subtitle,
    this.onRestore,
    this.onDelete,
  });

  final String title;
  final String subtitle;
  final VoidCallback? onRestore;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          OutlinedButton.icon(
            icon: Icon(Icons.restore),
            label: Text('Restore'),
            onPressed: onRestore,
          ),
          OutlinedButton.icon(
            icon: Icon(Icons.delete),
            label: Text('Delete'),
            onPressed: onDelete,
          ),
        ],
      ),
    );
  }
}
